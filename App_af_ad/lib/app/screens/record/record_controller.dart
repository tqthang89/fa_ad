import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syngentaaudit/app/base/AudioInfo.dart';
import 'package:syngentaaudit/app/base/ShopInfo.dart';
import 'package:syngentaaudit/app/base_controller.dart';
import 'package:syngentaaudit/app/context/auditContext.dart';
import 'package:syngentaaudit/app/core/FileUtils.dart';
import 'package:syngentaaudit/app/data/DatabaseHelper.dart';
import 'package:syngentaaudit/app/data/TableNames.dart';
import 'package:syngentaaudit/app/extensions/ExsString.dart';
import 'package:syngentaaudit/app/models/WorkResultInfo.dart';

import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart'
    as fspi;

class RecordController extends BaseController {
  FlutterSoundRecorder recorder;
  String pathToAudio;
  RxString timeText = "".obs;
  Track track;
  StreamSubscription recorderSubscription;
  RxList<AudioInfo> lstAudio = <AudioInfo>[].obs;
  DatabaseHelper db = DatabaseHelper();
  AudioPlayer player = AudioPlayer();
  AudioInfo filePlaying;
  @override
  void onReady() {
    player.setVolume(100.0);
    super.onReady();
  }

  Future<void> getWorkResult(ShopInfo shop) async {
    await AuditContext.getAudit(shop).then((WorkResultInfo value) {
      if (value == null) {
        confirm(
            content: "Lỗi không tìm thấy WorkResult.",
            onCancel: () {
              Navigator.of(Get.overlayContext).pop();
            },
            onConfirm: backPressed);
      } else {
        work.value = value;
      }
    });
  }

  Future<void> initRecord(ShopInfo shop) async {
    recorder = FlutterSoundRecorder();
    //await getWorkResult(shop);
    // await recorder.openAudioSession(
    //     focus: AudioFocus.requestFocusAndStopOthers,
    //     category: SessionCategory.playAndRecord,
    //     mode: SessionMode.modeDefault,
    //     device: AudioDevice.speaker);

    //        Copy UMP ----------------
    await recorder.openAudioSession(
        focus: AudioFocus.requestFocusAndDuckOthers,
        category: SessionCategory.playAndRecord,
        mode: SessionMode.modeDefault,
        device: AudioDevice.speaker,
        audioFlags: outputToSpeaker | allowBlueToothA2DP | allowAirPlay);
    await recorder.setSubscriptionDuration(Duration(milliseconds: 10));
    await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }

  Future<void> startRecording() async {
    if (!work.value.locked) {
      if (player.playing) {
        player.stop();
      }
      File file = await FileUtils.createAudio();
      if (file != null) {
        pathToAudio = file.path;
        track = new Track(trackPath: file.path, codec: Codec.aacMP4);
        recorder.openAudioSession();
        await recorder.startRecorder(
            //toFile: track.trackPath,
            //codec: Codec.amrNB,

            // --------------- Copy UMP------
            codec: Codec.aacMP4,
            numChannels: 1,
            bitRate: 16000,
            sampleRate: 16000,
            toFile: track.trackPath,
            audioSource: fspi.AudioSource.microphone);
        recorderSubscription =
            recorder.onProgress.listen((RecordingDisposition e) {
          if (e != null) {
            DateTime date = DateTime.fromMillisecondsSinceEpoch(
                e.duration.inMilliseconds,
                isUtc: true);
            timeText.value = DateFormat('mm:ss:SS', 'en_US').format(date);
            timeText.substring(0, 8);
            print(timeText.value);
          }
        });
      } else {
        alert(content: "Tạo file ghi âm không thành công, vui lòng thử lại!");
      }
    } else {
      alert(content: "Bạn không thể ghi âm thêm khi báo cáo đã khóa.");
    }
  }

  Future<void> stopRecording() async {
    if (!work.value.locked) {
      if (recorder.isRecording || recorder.isPaused) {
        try {
          confirm(
              content: "Bạn có muốn lưu tệp ghi âm này không ?",
              onCancel: () async {
                try {
                  if (recorder.isRecording || recorder.isPaused) {
                    recorder.closeAudioSession();
                    recorderSubscription.cancel();
                    recorderSubscription = null;
                    await recorder.stopRecorder();
                    timeText.value = "";
                  }
                  String tempPath = track.trackPath;
                  if (!ExString(tempPath).isNullOrWhiteSpace()) {
                    File tempFile = new File(tempPath);
                    if (tempFile.existsSync()) {
                      tempFile.deleteSync();
                    }
                  }
                } catch (ex) {
                  print(ex);
                }
              },
              onConfirm: () async {
                try {
                  if (recorder.isRecording || recorder.isPaused) {
                    recorder.closeAudioSession();
                    recorderSubscription.cancel();
                    recorderSubscription = null;
                    await recorder.stopRecorder();
                    timeText.value = "";
                    await saveAudio(track);
                  }
                } catch (ex) {
                  print(ex);
                }
                navigator.pop();
              });
        } catch (ex) {
          recorder.closeAudioSession();
          await recorder.stopRecorder();
        }
      }
    } else {}
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
    await recorder.closeAudioSession();
    await player.stop();
  }

  Future<void> saveAudio(Track track) async {
    if (track != null) {
      AudioInfo audio = new AudioInfo();
      if (Platform.isAndroid) {
        audio.audioPath = track.trackPath.split("/").last;
      } else {
        audio.audioPath = track.trackPath.split("/").last;
      }
      if (Platform.isAndroid) {
        audio.audioLocal = track.trackPath;
      } else {
        audio.audioLocal = track.trackPath.split("/").last;
      }
      //audio.audioLocal = track.trackPath;
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
    if (player.playing == false) {
      if (file.playing == 0) {
        filePlaying = file;
        await player.setAudioSource(AudioSource.uri(Uri.file(
            FileUtils.GetFilePathAudio(DirectoryPath, file.audioLocal,
                work.value.workDate.toString()))));
        file.playing = 1;
        for (AudioInfo item in lstAudio) {
          if (item.audioPath != file.audioPath) {
            item.playing = 0;
          }
        }
        lstAudio.refresh();
        await player.play().whenComplete(() => {
              player.stop(),
              file.playing = 0,
              lstAudio.refresh(),
            });
      } else {
        file.playing = 0;
        lstAudio.refresh();
      }
    } else {
      if (filePlaying.audioPath == file.audioPath) {
        player.stop();
        file.playing = 0;
        lstAudio.refresh();
      } else {
        confirm(
            content: "Đang hát.",
            onConfirm: () {
              player.stop();
              file.playing = 0;
              lstAudio.refresh();
              Navigator.pop(Get.context);
            });
      }
    }
  }
}
