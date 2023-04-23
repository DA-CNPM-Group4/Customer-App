import 'package:avatar_glow/avatar_glow.dart';
import 'package:customer_app/core/constants/enum.dart';
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
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
                style: BaseTextStyle.heading2(fontSize: 18),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(height * 0.32),
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
                                        "assets/icons/my_location.png",
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
                                        "assets/icons/my_location.png",
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
                                        "assets/icons/destination.png",
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
                                        "assets/icons/destination.png",
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
                                focusNode: controller.pickupFocusNode,
                                controller:
                                    controller.myPickupSearchLocationController,
                                onFieldSubmitted: (value) async {
                                  await controller.searchLocation(value);
                                },
                                onTap: () => controller
                                        .myPickupSearchLocationController
                                        .selection =
                                    TextSelection(
                                        baseOffset: 0,
                                        extentOffset: controller
                                            .myPickupSearchLocationController
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
                                key: const Key(
                                    "search_page_view_search_for_a_destination"),
                                focusNode: controller.destinationFocusNode,
                                decoration: const InputDecoration.collapsed(
                                    hintText: 'Search for a destination'),
                                controller:
                                    controller.myDestinationSearchController,
                                onTap: () {
                                  controller.myDestinationSearchController
                                          .selection =
                                      TextSelection(
                                          baseOffset: 0,
                                          extentOffset: controller
                                              .myDestinationSearchController
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
                    padding: const EdgeInsets.all(12),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        onPressed: () {
                          Get.toNamed(Routes.MAP, arguments: {
                            "location": controller.currentLocation,
                            "type": SEARCHTYPES.mydestination
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/icons/map.png",
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
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Obx(
              () => controller.location.isEmpty && !controller.isLoading.value
                  ? Image.asset("assets/images/empty.jpeg")
                  : controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            return ListTile(
                              key: Key(
                                  "search_page_view_destination_item${index.toString()}"),
                              leading: const Icon(Icons.location_on),
                              horizontalTitleGap: 0,
                              title: Text(
                                controller.location[index].name!,
                                style: BaseTextStyle.heading2(fontSize: 18),
                              ),
                              subtitle: Text(
                                controller.location[index].address!,
                                style: BaseTextStyle.body1(fontSize: 16),
                              ),
                              onTap: () async {
                                controller.selectSearchLocation(index);
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
