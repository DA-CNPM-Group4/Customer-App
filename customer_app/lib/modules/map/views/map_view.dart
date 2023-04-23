import 'package:customer_app/core/constants/common_object.dart';
import 'package:customer_app/core/constants/enum.dart';
import 'package:customer_app/modules/map/widgets/bottom_sheets.dart';
import 'package:customer_app/data/models/realtime_models/realtime_driver.dart';
import 'package:customer_app/modules/map/widgets/dragable_buble_chat.dart';
import 'package:customer_app/modules/utils/widgets.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controllers/map_controller.dart';

class MapView extends GetView<MapController> {
  const MapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    Size size = MediaQuery.of(context).size;
    double heightSafeArea = size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        key: controller.parentKey,
        children: [
          Obx(
            () => GoogleMap(
              polylines: controller.polyline.toSet(),
              mapType: MapType.normal,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              myLocationEnabled: true,
              onMapCreated: (GoogleMapController control) {
                controller.isLoading.value = true;
                controller.googleMapController = control;
                controller.isLoading.value = false;
              },
              markers: controller.markers.values.toSet(),
              initialCameraPosition: CameraPosition(
                  target: controller.searchDestination == null
                      ? LatLng(
                          controller.findTransportationController
                              .position["latitude"],
                          controller.findTransportationController
                              .position["longitude"])
                      : LatLng(controller.searchDestination!.location!.lat!,
                          controller.searchDestination!.location!.lng!),
                  zoom: 15),
            ),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Visibility(
                            visible:
                                controller.status.value != DrivingStatus.FOUND
                                    ? true
                                    : false,
                            child: roundedButton(
                                icon: Icons.arrow_back,
                                f: () async {
                                  if (controller.status.value ==
                                      DrivingStatus.FINDING) {
                                    await controller.openCancelRequestDialog();
                                  } else {
                                    Get.back();
                                  }
                                }),
                          ),
                        ),
                        roundedButton(
                            icon: Icons.navigation,
                            f: () async {
                              await controller.handleMyLocationButton();
                            })
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Obx(
                    () => AnimatedContainer(
                        height: controller.pass.value &&
                                controller.status.value != DrivingStatus.FOUND
                            ? heightSafeArea * 0.41
                            : heightSafeArea * 0.39,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: !controller.pass.value ? 10 : 0),
                        margin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[400]!,
                                offset: const Offset(0.0, -2.5), //(x,y)
                                blurRadius: 10.0,
                              ),
                            ],
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            border: Border.all(color: Colors.grey[300]!)),
                        duration: const Duration(milliseconds: 500),
                        child: controller.isDragging.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : controller.pass.value
                                ? (controller.status.value ==
                                            DrivingStatus.SELECTVEHICLE ||
                                        controller.status.value ==
                                            DrivingStatus.HASVOUCHER
                                    ? selectVehicle(
                                        context: context, textTheme: textTheme)
                                    : controller.status.value ==
                                            DrivingStatus.FINDING
                                        ? findingDriver(textTheme: textTheme)
                                        : foundDriver(
                                            textTheme: textTheme,
                                            driver: controller.driver.value))
                                : searchContainer(textTheme)),
                  )
                ],
              ),
            ),
          ),
          Obx(
            () => controller.status.value == DrivingStatus.FOUND &&
                    !controller.isStateChanged.value
                ? DraggableFloatingActionButton(
                    initialOffset: const Offset(200, 70),
                    parentKey: controller.parentKey,
                    onPressed: () {
                      Get.toNamed(Routes.CHAT);
                    },
                    child: Container(
                        width: 60,
                        height: 60,
                        decoration: const ShapeDecoration(
                          shape: CircleBorder(),
                          color: Color.fromARGB(255, 18, 190, 69),
                        ),
                        child: const Icon(Icons.chat_bubble)),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  Widget foundDriver(
      {required TextTheme textTheme, required RealtimeDriver? driver}) {
    return Obx(
      () => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.isStateChanged.value
                        ? "On the way"
                        : "Your driver is coming",
                    style: BaseTextStyle.heading2(fontSize: 16),
                  ),
                  Text(
                    "Never go on a bike which doesn't match the information",
                    style:
                        BaseTextStyle.body1(fontSize: 11, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 102,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 2,
                      color: Colors.grey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipOval(
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(
                                        30), // Image radius
                                    child: Image.asset(
                                        "assets/icons/face_icon.png",
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Text(driver?.info.name ?? "Driver name",
                                    style:
                                        BaseTextStyle.heading2(fontSize: 12)),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  driver?.vehicle.name ?? "Vehicle name",
                                  style: BaseTextStyle.heading2(fontSize: 16),
                                ),
                                Text(
                                  driver?.vehicle.brand ?? "Honda",
                                  style: BaseTextStyle.heading2(fontSize: 15),
                                ),
                                Text(
                                  driver?.info.phone ?? "0931328047",
                                  style: BaseTextStyle.heading2(fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: Get.width,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () async {
                          await FlutterPhoneDirectCaller.callNumber(
                              driver?.info.phone ?? "115");
                        },
                        child: const Text("Call driver")),
                  )
                ],
              ),
            ),
    );
  }

  Widget findingDriver({required TextTheme textTheme}) {
    return Obx(
      () => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      leading: Image.asset(
                        CommonObject.vehicleList[controller.selectedIndex.value]
                            .picture!,
                        height: 40,
                      ),
                      title: Text(
                        "Finding a driver for you...",
                        style: BaseTextStyle.heading2(fontSize: 14),
                      ),
                      subtitle: Text(
                        "We got your order",
                        style: BaseTextStyle.body1(fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      leading: Image.asset(
                        "assets/icons/cash_icon.jpeg",
                        height: 40,
                      ),
                      title: Text(
                        "Cash",
                        style: BaseTextStyle.body1(fontSize: 14),
                      ),
                      trailing: Text(
                        "${formatBalance.format(double.parse(CommonObject.vehicleList[controller.selectedIndex.value].price!))}đ",
                        style: BaseTextStyle.body1(fontSize: 14),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Obx(() => Text(
                          style: BaseTextStyle.body1(),
                          "${(controller.waitingSecond.value / 60).floor().toString()} : ${(controller.waitingSecond.value % 60).toString()} ")),
                      Container(
                        height: 80,
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 30),
                        width: double.infinity,
                        child: ElevatedButton(
                            key: const Key("map_view_cancel_order_btn"),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            onPressed: () async {
                              await controller.openCancelRequestDialog();
                            },
                            child: const Text("Cancel order")),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget searchContainer(TextTheme textTheme) {
    return Wrap(
      spacing: 10,
      children: [
        Obx(
          () => Text(
            controller.text.value,
            style: BaseTextStyle.heading2(fontSize: 18, color: Colors.green),
          ),
        ),
        const SizedBox(height: 48),
        Text(
          controller.address.value,
          style: BaseTextStyle.body3(fontSize: 16),
        ),
        const SizedBox(height: 20),
        Text(
          controller.address.value,
          style: BaseTextStyle.body2(fontSize: 15),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Visibility(
              visible: controller.isShow,
              child: Expanded(
                child: ElevatedButton(
                    key: const Key("map_view_next_btn"),
                    onPressed: () async {
                      await controller.handleSearch();
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: Text(
                      "Next",
                      style: BaseTextStyle.body1(
                          fontSize: 15, color: Colors.white),
                    )),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget selectVehicle(
      {required BuildContext context, required TextTheme textTheme}) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => controller.isLoading.value
            ? const Align(
                alignment: Alignment.topCenter,
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: CommonObject.vehicleList.length,
                padding: const EdgeInsets.only(bottom: 150),
                itemBuilder: (context, itemBuilder) {
                  return Obx(
                    () => ListTile(
                      tileColor: controller.selectedIndex.value == itemBuilder
                          ? Colors.grey[100]
                          : Colors.white,
                      leading: Image.asset(
                        CommonObject.vehicleList[itemBuilder].picture!,
                        height: 30,
                      ),
                      title: Row(
                        children: [
                          Text(
                            CommonObject.vehicleList[itemBuilder].name!,
                            style: BaseTextStyle.heading2(fontSize: 13),
                          ),
                          const Spacer(),
                          Text(
                            "${formatBalance.format(double.parse(CommonObject.vehicleList[itemBuilder].price!))}đ",
                            style: BaseTextStyle.heading2(fontSize: 16),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Text(CommonObject.vehicleList[itemBuilder].duration!),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.supervisor_account,
                            color: Colors.grey,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${CommonObject.vehicleList[itemBuilder].seatNumber!} seaters",
                          ),
                          const Spacer(),
                          Visibility(
                            visible: CommonObject.vehicleList[itemBuilder]
                                        .priceAfterVoucher !=
                                    ""
                                ? true
                                : false,
                            child: Text(
                              CommonObject.vehicleList[itemBuilder]
                                          .priceAfterVoucher !=
                                      ""
                                  ? "${formatBalance.format(double.parse(CommonObject.vehicleList[itemBuilder].priceAfterVoucher!))}đ"
                                  : "",
                              style: const TextStyle(
                                  fontSize: 12,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ),
                        ],
                      ),
                      onTap: () async {
                        controller.selectedIndex.value = itemBuilder;

                        // await controller.route(controller.from, controller.to);
                      },
                    ),
                  );
                }),
      ),
      bottomSheet: Container(
        height: Get.height * 0.16,
        width: Get.width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey[200]!,
                offset: const Offset(0.0, -2.5), //(x,y)
                blurRadius: 3.0,
              ),
            ],
            color: Colors.white,
            border: const Border(
              top: BorderSide(
                //
                color: Colors.black,
                width: 0.1,
              ),
            )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showPaymentMethod(
                        context: context,
                        height: Get.height * 0.95,
                        groupValue: controller.groupValue);
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/cash_icon.jpeg",
                        height: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        controller.groupValue.value,
                        style: BaseTextStyle.body1(fontSize: 15),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    width: 100,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(
                              side: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                            backgroundColor: Colors.white,
                            elevation: 0),
                        onPressed: () async {
                          // await controller.handleVoucher();
                        },
                        child: Text("Voucher",
                            style: BaseTextStyle.body1(fontSize: 12))))
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: IgnorePointer(
                ignoring: controller.isLoading.value,
                child: ElevatedButton(
                    key: const Key("map_view_order_btn"),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () async {
                      // await controller.bookingCar();

                      await controller.sendRequest();
                    },
                    child: const Text("Order")),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget roundedButton({required IconData icon, required Function() f}) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[350]!,
              offset: const Offset(0.0, 0.0), //(x,y)
              blurRadius: 10.0,
            ),
          ],
          border: Border.all(color: Colors.grey[300]!)),
      child: IconButton(
        icon: Icon(
          icon,
          color: Colors.black,
        ),
        onPressed: f,
      ),
    );
  }
}
