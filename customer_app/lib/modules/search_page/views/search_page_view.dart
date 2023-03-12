import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:customer_app/data/common/util.dart';
import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/search_page_controller.dart';

class SearchPageView extends GetView<SearchPageController> {
  const SearchPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            title: Obx(
              () => Text(
                !controller.isMyLocationFocused.value
                    ? "Where do you want to go?"
                    : "Set pickup location",
                style: textTheme.headline1,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(height * 0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    height: height * 0.2,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[200]!),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Obx(
                              () => !controller.isMyLocationFocused.value
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.05),
                                      child: Image.asset(
                                        "assets/my_location.png",
                                        height: 25,
                                      ),
                                    )
                                  : AvatarGlow(
                                      endRadius: 20,
                                      duration:
                                          const Duration(milliseconds: 1000),
                                      repeatPauseDuration:
                                          const Duration(milliseconds: 200),
                                      glowColor: Colors.green,
                                      child: Image.asset(
                                        "assets/my_location.png",
                                        height: 25,
                                      )),
                            ),
                            CustomPaint(
                                size: Size(1, height * 0.03),
                                painter: DashedLineVerticalPainter()),
                            Obx(
                              () => !controller.isDestinationFocused.value
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        "assets/destination.png",
                                        height: 25,
                                      ),
                                    )
                                  : AvatarGlow(
                                      endRadius: 20,
                                      duration:
                                          const Duration(milliseconds: 1000),
                                      repeatPauseDuration:
                                          const Duration(milliseconds: 200),
                                      glowColor: Colors.green,
                                      child: Image.asset(
                                        "assets/destination.png",
                                        height: 25,
                                      )),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextFormField(
                                decoration: InputDecoration.collapsed(
                                    hintText:
                                        !controller.isMyLocationFocused.value
                                            ? 'Your current location'
                                            : 'Search for a pickup',
                                    hintStyle: !controller
                                            .isMyLocationFocused.value
                                        ? const TextStyle(color: Colors.black)
                                        : const TextStyle(color: Colors.grey)),
                                focusNode: controller.myLocation,
                                controller: controller.myLocationController,
                                onFieldSubmitted: (value) async {
                                  await controller.searchLocation(value);
                                },
                                onTap: () =>
                                    controller.myLocationController.selection =
                                        TextSelection(
                                            baseOffset: 0,
                                            extentOffset: controller
                                                .myLocationController
                                                .value
                                                .text
                                                .length),
                              ),
                              Divider(
                                height: 1,
                                thickness: 1,
                                color: Colors.grey[500]!,
                              ),
                              TextFormField(
                                focusNode: controller.destination,
                                decoration: const InputDecoration.collapsed(
                                    hintText: 'Search for a destination'),
                                controller: controller.destinationController,
                                onTap: () {
                                  controller.destinationController.selection =
                                      TextSelection(
                                          baseOffset: 0,
                                          extentOffset: controller
                                              .destinationController
                                              .value
                                              .text
                                              .length);
                                },
                                onFieldSubmitted: (e) async {
                                  await controller.searchLocation(e);
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.white),
                        onPressed: () {
                          Get.toNamed(Routes.MAP, arguments: {
                            "location": controller.currentLocation,
                            "type": SEARCHTYPES.MYDESTINATION
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/map.png",
                              height: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Select via map",
                              style: BaseTextStyle.body1(),
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
            elevation: 1,
          ),
          body: Obx(
            () => controller.location.isEmpty && !controller.isLoading.value
                ? Image.asset("assets/empty.jpeg")
                : controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const Icon(Icons.location_on),
                            horizontalTitleGap: 0,
                            title: Text(controller.location[index].name!),
                            subtitle: Text(controller.location[index].address!),
                            onTap: () async {
                              if (controller
                                      .myLocationController.text.isNotEmpty &&
                                  controller
                                      .destinationController.text.isEmpty) {
                                controller.myLocationController.text =
                                    controller.location[index].address!;
                                Get.toNamed(Routes.MAP, arguments: {
                                  'location': controller.location[index],
                                  "type": SEARCHTYPES.LOCATION
                                });
                              } else if (controller
                                      .myLocationController.text.isEmpty &&
                                  controller
                                      .destinationController.text.isNotEmpty) {
                                controller.destinationController.text =
                                    controller.location[index].address!;
                                Get.toNamed(Routes.MAP, arguments: {
                                  'destination': controller.location[index],
                                  "type": SEARCHTYPES.MYDESTINATION
                                });
                              } else if (controller
                                      .myLocationController.text.isNotEmpty &&
                                  controller
                                      .destinationController.text.isNotEmpty) {
                                Get.toNamed(Routes.MAP, arguments: {
                                  'destination': controller.location[index],
                                  "type": SEARCHTYPES.MYDESTINATION
                                });
                              }
                            },
                          );
                        },
                        itemCount: controller.location.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            thickness: 1,
                            height: 20,
                          );
                        },
                      ),
          )),
    );
  }
}

class DashedLineVerticalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 1, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
