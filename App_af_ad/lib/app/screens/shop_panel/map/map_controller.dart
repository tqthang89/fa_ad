import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:syngentaaudit/app/base_controller.dart';
import 'package:syngentaaudit/app/base/ShopInfo.dart';
import 'package:syngentaaudit/app/context/auditContext.dart';
import 'package:syngentaaudit/app/core/DateTimes.dart';
import 'package:syngentaaudit/app/models/WorkResultInfo.dart';

class MapController extends BaseController {
  Completer<GoogleMapController> mapController = Completer();
  CameraPosition shopLocation;
  List<Marker> markers = <Marker>[];
  MapType mapType = MapType.normal;
  LatLng source;
  LatLng dest;
  Set<Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  BitmapDescriptor userIcon;
  Position position;
  RxList<ShopInfo> listShop;

  Color normal = const Color(0xFF4527A0);
  Color locked = const Color(0xFF1B5E20);
  Color nolocked = const Color(0xFFD84315);
  Color uploaded = const Color(0xFF9C27B0);



  @override
  void onInit() {
    super.onInit();
    load();
  }

  void load() {
    change(value, status: RxStatus.loading());
    listShop = Get.arguments[0];
    loadMap().then((value) {
      change(value, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err));
    });
  }

  Future<CameraPosition> loadMap() async {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(5, 5)),
            'assets/icons/ic_user_location.png')
        .then((icon) {
      userIcon = icon;
    });
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    markers.add(Marker(
        icon: userIcon,
        markerId: MarkerId('UserPosition'),
        position: new LatLng(position.latitude, position.longitude),
        infoWindow: InfoWindow(title: 'Vị trí của tôi'),
        visible: true));
    await loadMarkers();
    return shopLocation = CameraPosition(
      target: new LatLng(position.latitude, position.longitude),
      zoom: 14.4746,
    );
  }

  BitmapDescriptor getIcons(ShopInfo shop) {
    if (shop.locked == null) {
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
    } else {
      if (shop.locked) {
        if (shop.isUpload != null && shop.isUpload) {
          return BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue);
        } else {
          return BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen);
        }
      } else {
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      }
    }
  }

  Future<void> loadMarkers() async {
    if (listShop != null && listShop.length > 0) {
      for (ShopInfo shop in listShop) {
        if (shop.latitude != null && shop.longitude != null) {
          double distance = Geolocator.distanceBetween(shop.latitude,
              shop.longitude, position.latitude, position.longitude);
          markers.add(Marker(
              onTap: () async {

              },
              icon: getIcons(shop),
              markerId: MarkerId(
                  shop.latitude.toString() + "-" + shop.longitude.toString()),
              position: source = new LatLng(shop.latitude, shop.longitude),
              infoWindow: InfoWindow(
                  title: "Mã CH: " +
                      shop.shopId.toString() +
                      " Tên CH: " +
                      shop.shopName,

                  snippet: "Ước chừng " +
                      (distance / 1000).toStringAsFixed(2) +
                      " km",
                  onTap: () async{
                    createAuditResult(shop).then((value) {
                      Get.toNamed('\shop',
                          arguments: <dynamic>[shop, value], preventDuplicates: false);
                    });
                  }
              )));
        }
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
