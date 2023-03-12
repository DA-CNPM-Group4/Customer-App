
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Loading extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  const Loading._({Key? key, this.width = double.infinity,  this.height = double.infinity, this.borderRadius = 0}) : super(key: key);

  const Loading.square({
    required double width, required double height
  }) : this._(width: width, height: height);

  const Loading.circle({
    required this.width, required this.height, required this.borderRadius
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.grey,
      baseColor: Colors.white24,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(borderRadius)
        ),
      ),
    );
  }
}