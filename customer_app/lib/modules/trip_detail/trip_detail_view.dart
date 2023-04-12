import 'dart:math';

import 'package:customer_app/modules/search_page/views/search_page_view.dart';
import 'package:customer_app/modules/trip_detail/trip_detail_controller.dart';
import 'package:customer_app/modules/trip_detail/widgets/rate_comment.dart';
import 'package:customer_app/modules/trip_info/widgets/session_item.dart';
import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TripDetailView extends GetView<TripDetailController> {
  const TripDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey[800]),
        title: Text(
          "Trip Detail",
          style: BaseTextStyle.heading2(fontSize: 20, color: BaseColor.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 22),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDriverInfo(),
                const SizedBox(height: 18),
                _buildTripAddress(size.height, size.width),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTripInfo(),
                      const SizedBox(height: 22),
                      Text("Rate and reviews",
                          style: BaseTextStyle.heading2(fontSize: 17)),
                      const SizedBox(height: 12),
                      const RateAndComment(),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Widget _buildDriverInfo() {
    return SizedBox(
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
                      size: const Size.fromRadius(30), // Image radius
                      child: Image.asset("assets/icons/face_icon.png",
                          fit: BoxFit.cover),
                    ),
                  ),
                  Text("Driver name", //Replace with driver name
                      style: BaseTextStyle.heading2(fontSize: 12)),
                ],
              ),
              const Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Honda Future", //Replace with vehicle name
                    style: BaseTextStyle.heading2(fontSize: 16),
                  ),
                  Text(
                    "Honda", //Replace with brand name
                    style: BaseTextStyle.heading2(fontSize: 15),
                  ),
                  Text(
                    "0931328047", //Replace with driver phone number
                    style: BaseTextStyle.heading2(fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTripAddress(double height, double width) {
    return Container(
      height: height * 0.2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey[200]!),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "assets/icons/my_location.png",
                height: 25,
              ),
              CustomPaint(
                  size: Size(1, height * 0.03),
                  painter: DashedLineVerticalPainter()),
              Image.asset(
                "assets/icons/destination.png",
                height: 25,
              ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  '102 Nguyen Van Linh, District 7, Ho Chi Minh City',
                  //Replace with start address
                  style: TextStyle(fontSize: 13, color: Colors.black),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey[500]!,
                ),
                const Text('85 Nguyen Van Cu, District 5, Ho Chi Minh City',
                    style: TextStyle(fontSize: 13, color: Colors.black)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTripInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text("Distance: 5.5 km", //Replace with distance
                  style: BaseTextStyle.heading2(
                      fontSize: 15, color: Colors.white)),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text("Price: 50000đ", //Replace with price
                  style: BaseTextStyle.heading2(
                      fontSize: 15, color: Colors.white)),
            ),
          ],
        ),
        const SizedBox(height: 18),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Status: ",
                style: BaseTextStyle.heading3(fontSize: 18),
              ),
              TextSpan(
                text: "Done", //Replace with trip status
                style:
                    BaseTextStyle.heading2(fontSize: 18, color: Colors.green),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Time: ",
                style: BaseTextStyle.heading3(fontSize: 18),
              ),
              TextSpan(
                text:
                    "April 12, 16:00 - April 12, 17:00", //Replace with trip time
                style: BaseTextStyle.heading3(fontSize: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
