import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syngentaaudit/app/components/base_app_bar.dart';

import 'map_controller.dart';

class MapView extends GetView<MapController> {
  @override
  Widget build(BuildContext context) {
    Size size = Get.mediaQuery.size;
    return controller.obx(
      (state) => Scaffold(
        appBar: BaseAppBar(
          title: Text('Map'),
          rightIsNotify: false,
          height: 50,
          isShowBackGround: false,
          leftIcon: Icons.arrow_back_ios,
          leftClick: () {
            Get.back();
          },
        ),
        body: Container(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                  child: GoogleMap(
                      zoomControlsEnabled: true,
                      zoomGesturesEnabled: true,
                      markers: Set<Marker>.of(controller.markers),
                      myLocationButtonEnabled: true,
                      compassEnabled: true,
                      mapType: MapType.terrain,
                      initialCameraPosition: controller.shopLocation,
                      onMapCreated: (GoogleMapController controllerMap) {
                        if (!controller.mapController.isCompleted) {
                          controller.mapController.complete(controllerMap);
                        }
                      },
                      onCameraMove: (CameraPosition cameraPosition) {
                        print(cameraPosition.zoom);
                      },
                      gestureRecognizers:
                          <Factory<OneSequenceGestureRecognizer>>[
                        new Factory<OneSequenceGestureRecognizer>(
                          () => new EagerGestureRecognizer(),
                        ),
                      ].toSet())),
              Container(
                width: size.width,
                height: 100,
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Flexible(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      width: 20,
                                      height: 20,
                                      child: Image.asset(
                                        "assets/icons/ic_location_pin.png",
                                        fit: BoxFit.contain,
                                        color: controller.normal,
                                        width: 50.0,
                                        height: 50.0,
                                      ),
                                    ),
                                    Container(
                                      constraints: new BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2),
                                      child: Text(
                                        'Cửa hàng chưa làm',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            decoration: TextDecoration.none),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Flexible(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    width: 20,
                                    height: 20,
                                    child: Image.asset(
                                      "assets/icons/ic_location_pin.png",
                                      fit: BoxFit.contain,
                                      color: controller.locked,
                                      width: 50.0,
                                      height: 50.0,
                                    ),
                                  ),
                                  Container(
                                    constraints: new BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width /
                                                2),
                                    child: Text('Cửa hàng đã khóa',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            decoration: TextDecoration.none)),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Flexible(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      width: 20,
                                      height: 20,
                                      child: Image.asset(
                                        "assets/icons/ic_location_pin.png",
                                        fit: BoxFit.contain,
                                        color: controller.nolocked,
                                        width: 50.0,
                                        height: 50.0,
                                      ),
                                    ),
                                    Container(
                                      constraints: new BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2),
                                      child: Text('Cửa hàng chưa khóa',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10,
                                              decoration: TextDecoration.none)),
                                    ),
                                  ],
                                ),
                              )),
                          Flexible(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    width: 20,
                                    height: 20,
                                    child: Image.asset(
                                      "assets/icons/ic_location_pin.png",
                                      fit: BoxFit.contain,
                                      color: controller.uploaded,
                                      width: 50.0,
                                      height: 50.0,
                                    ),
                                  ),
                                  Container(
                                    constraints: new BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width /
                                                2),
                                    child: Text('Cửa hàng đã gửi',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            decoration: TextDecoration.none)),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
