import 'dart:math';

import 'package:customer_app/modules/trip_info/widgets/session_item.dart';
import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'trip_info_controller.dart';

class TripInfoView extends GetView<TripInfoController> {
  const TripInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double safeWidth = min(size.width, 500);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey[800]),
        title: Text(
          "Trip Information",
          style: BaseTextStyle.heading2(fontSize: 20, color: BaseColor.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 104,
                child: Image.asset(
                  "assets/icons/icon_history.png",
                  fit: BoxFit.fitHeight,
                  color: Colors.green,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "Booking History",
                  style: BaseTextStyle.heading4(),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 16.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: Colors.black12, width: 0.1),
                    boxShadow: [
                      BoxShadow(
                          color: const Color.fromARGB(255, 6, 11, 21)
                              .withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 1,
                          offset: const Offset(0, 0))
                    ]),
                width: safeWidth,
                child: Text(
                  "The following is a list of trip you have taken. You can view the details of the trip you have booked.",
                  style: BaseTextStyle.body1(fontSize: 14),
                ),
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 16),
              controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : !controller.isLoading && controller.bookedList.isEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/ic_empty.svg",
                                  width: 200,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    "You don't have any booking history",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(
                          height: size.height * 0.8,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 14),
                                  itemCount: controller.bookedList.length,
                                  controller: controller.scrollController,
                                  itemBuilder: (context, index) => Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: SessionItem(
                                      session: controller.bookedList[index],
                                    ),
                                  ),
                                ),
                              ),
                              if (controller.isLoadMore)
                                const SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                            ],
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
