import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateAndComment extends StatelessWidget {
  const RateAndComment({
    super.key,
    required this.feedback,
    required this.passengerName,
    required this.rating,
  });

  final String feedback;
  final String passengerName;
  final int rating;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 4, right: 15),
                  height: 40,
                  width: 40,
                  child: const Icon(Icons.person, size: 40),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        passengerName, //Replace with passenger name
                        style: BaseTextStyle.heading2(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            RatingBar.builder(
              initialRating: rating.toDouble(),
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {},
            ),
            Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: feedback.isNotEmpty ? Text(feedback) : null),
          ],
        ),
      ),
    );
  }
}
