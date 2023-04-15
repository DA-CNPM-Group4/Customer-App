import 'package:customer_app/core/constants/enum.dart';
import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';

extension TripStatusWidget on TripStatus {
  // Overload the [] getter to get the name of the fruit.
  TextSpan toTextTripDetail({double? size}) {
    return TextSpan(
      text: value,
      style: BaseTextStyle.heading2(fontSize: size ?? 18, color: color),
    );
  }

  Text toTextTripsInfo({double? size}) {
    return Text(
      value,
      style: BaseTextStyle.heading2(fontSize: size ?? 16, color: color),
    );
  }
}
