import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syngentaaudit/app/base/AudioInfo.dart';
import 'package:syngentaaudit/app/base/ShopInfo.dart';
import 'package:syngentaaudit/app/base_controller.dart';
import 'package:syngentaaudit/app/context/auditContext.dart';
import 'package:syngentaaudit/app/core/FileUtils.dart';
import 'package:syngentaaudit/app/data/DatabaseHelper.dart';
import 'package:syngentaaudit/app/data/TableNames.dart';
import 'package:syngentaaudit/app/models/WorkResultInfo.dart';

class RecordController extends BaseController {
  FlutterSoundRecorder recorder;
  FlutterSoundPlayer player;
  String pathToAudio;
  RxString timeText = "".obs;
  StreamSubscription recorderSubscription;
  RxList<AudioInfo> lstAudio = <AudioInfo>[].obs;
  DatabaseHelper db = DatabaseHelper();
  AudioInfo filePlaying;
  bool hasResponded = false;  // Biến kiểm tra trạng thái phản hồi

  @override
  void onReady() {
    super.onReady();
    recorder = FlutterSoundRecorder();
    player = FlutterSoundPlayer();

    // Mở phiên làm việc cho player
    player.openPlayer().then((_) {
      print("Player is ready!");
    }).catchError((e) {
      print("Error opening player: $e");
    });
    player.setVolume(1.0);  // Set volume to 100%
  }

  Future<void> initRecord(ShopInfo shop) async {
    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }

  Future<void> startRecording() async {
    if (!work.value.locked) {
      if (player.isPlaying) {
        await player.stopPlayer();
      }

      File file = await FileUtils.createAudio();
      if (file != null) {
        pathToAudio = file.path;

        // Đảm bảo rằng recorder đã được mở trước khi ghi âm
        await recorder.openRecorder();

        await recorder.startRecorder(
          toFile: pathToAudio,
          codec: Codec.aacMP4,
          numChannels: 1,
          bitRate: 16000,
          sampleRate: 16000,
        );

        recorderSubscription =
            recorder.onProgress.listen((e) {
              if (e != null && e.duration != null) {
                DateTime date = DateTime.fromMillisecondsSinceEpoch(
                  e.duration.inMilliseconds,
                  isUtc: true,
                );
                //timeText.value = DateFormat('mm:ss:SS').format(date);
              }
            });
        startTimer();
      } else {
        alert(content: "Tạo file ghi âm không thành công, vui lòng thử lại!");
      }
    } else {
      alert(content: "Bạn không thể ghi âm thêm khi báo cáo đã khóa.");
    }
  }

  Timer _timer;                // Timer để đếm giây
  int _seconds = 0;                 // Biến lưu trữ số giây đã trôi qua

  void startTimer() {
    _seconds = 0;  // Reset giây về 0 mỗi khi bắt đầu
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds++;  // Tăng số giây lên mỗi lần đếm
      int minutes = _seconds ~/ 60;  // Lấy số phút
      int seconds = _seconds % 60;  // Lấy số giây
      timeText.value = "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    });
  }

  void stopTimer() {
    _timer.cancel();
  }

  Future<void> stopRecording(BuildContext context) async {
    if (!work.value.locked) {
      if (recorder.isRecording || recorder.isPaused) {
        try {
          if (!hasResponded) {  // Kiểm tra phản hồi chỉ gửi một lần
            hasResponded = true;
            // confirm(
            //     content: "Bạn có muốn lưu tệp ghi âm này không ?",
            //     onCancel: () async {
            //       await recorder.stopRecorder();
            //       await recorder.closeRecorder();  // Đảm bảo recorder được đóng
            //       recorderSubscription?.cancel();
            //       recorderSubscription = null;
            //
            //       String tempPath = pathToAudio;
            //       File tempFile = File(tempPath);
            //       if (tempFile.existsSync()) {
            //         tempFile.deleteSync();
            //       }
            //     },
            //     onConfirm: () async {
            //       await recorder.stopRecorder();
            //       await recorder.closeRecorder();  // Đảm bảo recorder được đóng
            //       timeText.value = "00:00";
            //       await saveAudio();
            //     });

            showConfirmDialog(
              context,  // context hiện tại
              'Thông báo',  // Tiêu đề hộp thoại
              'Bạn có muốn lưu tệp ghi âm này không ?',  // Nội dung
              onConfirm,  // Callback khi người dùng chọn "Confirm"
              onCancel,   // Callback khi người dùng chọn "Cancel"
            );
          }
        } catch (ex) {
          print(ex);
          await recorder.stopRecorder();
          await recorder.closeRecorder();  // Đảm bảo recorder được đóng
        }
      }
    }
  }

  // Hàm xử lý khi người dùng xác nhận
  void onConfirm() async {
    stopTimer();
    await recorder.stopRecorder();
    await recorder.closeRecorder();  // Đảm bảo recorder được đóng
    timeText.value = "00:00";
    await saveAudio();
  }

  // Hàm xử lý khi người dùng hủy
  void onCancel() async {
    stopTimer();
    await recorder.stopRecorder();
    await recorder.closeRecorder();  // Đảm bảo recorder được đóng
    recorderSubscription?.cancel();
    recorderSubscription = null;

    String tempPath = pathToAudio;
    File tempFile = File(tempPath);
    if (tempFile.existsSync()) {
      tempFile.deleteSync();
    }
  }

  Future<bool> backPressed() async {
    if (recorder.isRecording) {
      alert(content: "Bạn chưa tắt ghi âm");
    } else {
      print('AudioPath: $pathToAudio');
      Get.back();
    }
    return false;
  }

  Future<void> closeAudio() async {
    await recorder.stopRecorder();
    await recorder.closeRecorder();
    await player.stopPlayer();
    _timer.cancel();  // Đảm bảo hủy bỏ timer khi widget bị hủy
  }

  Future<void> saveAudio() async {
    if (pathToAudio != null) {
      AudioInfo audio = AudioInfo();
      audio.audioPath = pathToAudio.split("/").last;  // Chỉ lấy tên file
      audio.audioLocal = pathToAudio;  // Lưu đường dẫn đầy đủ
      audio.uploaded = 0;
      audio.workId = work.value.rowId;
      await db.insertRow(TableNames.audio, audio);
      await getListAudio(work.value);
    }
  }

  Future<List<AudioInfo>> getListAudio(WorkResultInfo work) async {
    lstAudio.clear();
    lstAudio.value = await AuditContext.getListAudio(work);
    return lstAudio;
  }

  Future<void> play(AudioInfo file) async {
    if (player.isPlaying == false) {
      if (file.playing == 0) {
        filePlaying = file;

        // Sử dụng String thay vì Uri
        await player.startPlayer(
            fromURI: FileUtils.GetFilePathAudio(
                DirectoryPath, file.audioLocal, work.value.workDate.toString()),
            whenFinished: () {
              // Khi phát lại hoàn tất
              file.playing = 0;
              lstAudio.refresh();
            }
        );

        file.playing = 1;
        for (AudioInfo item in lstAudio) {
          if (item.audioPath != file.audioPath) {
            item.playing = 0;
          }
        }
        lstAudio.refresh();
      } else {
        file.playing = 0;
        lstAudio.refresh();
      }
    } else {
      if (filePlaying.audioPath == file.audioPath) {
        await player.stopPlayer();
        file.playing = 0;
        lstAudio.refresh();
      } else {
        confirm(
            content: "Đang phát âm thanh.",
            onConfirm: () {
              player.stopPlayer();
              file.playing = 0;
              lstAudio.refresh();
              Navigator.pop(Get.context);
            });
      }
    }
  }
}
