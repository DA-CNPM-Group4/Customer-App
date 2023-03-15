import 'package:customer_app/data/common/bottom_sheets.dart';
import 'package:customer_app/data/common/util.dart';
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
    double keyboardHeight = EdgeInsets.fromWindowPadding(
            WidgetsBinding.instance.window.viewInsets,
            WidgetsBinding.instance.window.devicePixelRatio)
        .bottom;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
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
                  target: controller.searchingLocation == null
                      ? LatLng(
                          controller.findTransportationController
                              .position["latitude"],
                          controller.findTransportationController
                              .position["longitude"])
                      : LatLng(controller.searchingLocation!.location!.lat!,
                          controller.searchingLocation!.location!.lng!),
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
                            visible: controller.status.value != STATUS.FOUND
                                ? true
                                : false,
                            child: roundedButton(
                                icon: Icons.arrow_back,
                                f: () {
                                  if (controller.status.value ==
                                      STATUS.FINDING) {
                                    controller.handleBackButton();
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
                                controller.status.value != STATUS.FOUND
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
                                            STATUS.SELECTVEHICLE ||
                                        controller.status.value ==
                                            STATUS.HASVOUCHER
                                    ? selectVehicle(
                                        context: context, textTheme: textTheme)
                                    : controller.status.value == STATUS.FINDING
                                        ? findingDriver(textTheme: textTheme)
                                        : foundDriver(textTheme: textTheme))
                                : searchContainer(textTheme)),
                  )
                ],
              ),
            ),
          )
        ]));
  }

  Widget foundDriver({required TextTheme textTheme}) {
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
                    "Your driver is coming",
                    style: BaseTextStyle.heading2(fontSize: 13),
                  ),
                  Text(
                    "Never go on a bike which doesn't match the information",
                    style:
                        BaseTextStyle.body1(fontSize: 11, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 100,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipOval(
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(
                                        30), // Image radius
                                    child: Image.asset("assets/face.png",
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Text(controller.driver?.fullname ?? "",
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
                                  controller.driver?.vehicleList?.first
                                          .licensePlateNum ??
                                      "",
                                  style: BaseTextStyle.heading2(fontSize: 16),
                                ),
                                Text(
                                  controller.driver?.vehicleList?.first.brand ??
                                      "",
                                  style: BaseTextStyle.heading2(fontSize: 16),
                                ),
                                Text(
                                  controller.driver?.phone ?? "",
                                  style: BaseTextStyle.heading2(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        onPressed: () async {
                          await FlutterPhoneDirectCaller.callNumber(
                              controller.driver?.phone.toString() ?? "113");
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
                        controller.vehicleList[controller.selectedIndex.value]
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
                        "${formatBalance.format(double.parse(controller.vehicleList[controller.selectedIndex.value].price!))}đ",
                        style: BaseTextStyle.body1(fontSize: 14),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                      height: 80,
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 30),
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () async {
                            await controller.cancelBooking();
                          },
                          child: const Text("Cancel order"))),
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
                    onPressed: () async {
                      controller.handleSearch();
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.green),
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
    print("isLoading value: ${controller.isLoading.value}");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => controller.isLoading.value
            ? const Align(
                alignment: Alignment.topCenter,
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: controller.vehicleList.length,
                padding: const EdgeInsets.only(bottom: 150),
                itemBuilder: (context, itemBuilder) {
                  return Obx(
                    () => ListTile(
                      tileColor: controller.selectedIndex.value == itemBuilder
                          ? Colors.grey[100]
                          : Colors.white,
                      leading: Image.asset(
                        controller.vehicleList[itemBuilder].picture!,
                        height: 30,
                      ),
                      title: Row(
                        children: [
                          Text(
                            controller.vehicleList[itemBuilder].name!,
                            style: BaseTextStyle.heading2(fontSize: 13),
                          ),
                          const Spacer(),
                          Text(
                            "${formatBalance.format(double.parse(controller.vehicleList[itemBuilder].price!))}đ",
                            style: BaseTextStyle.heading2(fontSize: 16),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Text(controller.vehicleList[itemBuilder].duration!),
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
                            "${controller.vehicleList[itemBuilder].seatNumber!} seaters",
                          ),
                          const Spacer(),
                          Visibility(
                            visible: controller.vehicleList[itemBuilder]
                                        .priceAfterVoucher !=
                                    ""
                                ? true
                                : false,
                            child: Text(
                              controller.vehicleList[itemBuilder]
                                          .priceAfterVoucher !=
                                      ""
                                  ? "${formatBalance.format(double.parse(controller.vehicleList[itemBuilder].priceAfterVoucher!))}đ"
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
                            primary: Colors.white,
                            elevation: 0),
                        onPressed: () async {
                          await controller.handleVoucher();
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
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: () async {
                        // await controller.bookingCar();

                        await controller.sendRequest();
                      },
                      child: const Text("Order")),
                )),
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
        ));
  }
}
