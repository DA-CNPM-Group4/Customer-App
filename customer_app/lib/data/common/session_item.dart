import 'package:customer_app/data/models/requests/trip_response.dart';
import 'package:customer_app/modules/edit_profile/widgets/avatar_circle.dart';
import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class SessionItem extends StatelessWidget {
  const SessionItem({Key? key, required this.session}) : super(key: key);

  final TripResponse session;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 25),
                  height: 70,
                  width: 70,
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: AvatarCircle(
                        width: 80,
                        height: 80,
                        source: "assets/icons/face_icon.png"),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Driver Name", //Replace with driver name
                        style: BaseTextStyle.heading2(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 20,
                            child: SvgPicture.asset(
                                "assets/icons/ic_calendar.svg",
                                width: 15),
                          ),
                          const Text(
                            "10/06/2023", //Replace with trip date
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 20,
                            child: SvgPicture.asset("assets/icons/ic_clock.svg",
                                width: 20),
                          ),
                          const Text(
                            "17:00 - 18:00", //Replace with trip create time and end time
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 20,
                            child: SvgPicture.asset("assets/icons/ic_score.svg",
                                width: 15),
                          ),
                          const Text(
                            "Great Trip!",
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          color: Colors.green,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4),
                              bottomLeft: Radius.circular(4))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Rate trip",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(4),
                              bottomRight: Radius.circular(4))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Trip Detail",
                            style: TextStyle(color: Colors.green),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
