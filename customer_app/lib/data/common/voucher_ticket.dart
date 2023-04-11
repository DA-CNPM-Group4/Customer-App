import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/voucher/voucher.dart';

class TicketView extends StatelessWidget {
  final Voucher voucher;
  final bool selected;

  const TicketView({Key? key, required this.voucher, required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Card(
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            margin: EdgeInsets.zero,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "${voucher.discountName} discount",
                    style: textTheme.displayLarge!.copyWith(fontSize: 18),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Discount percent: ${voucher.discountPercent}",
                          style: textTheme.displayMedium,
                        ),
                        Text(
                          "Quantity: ${voucher.quantity}",
                          style: textTheme.displayMedium,
                        ),
                      ])
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 20,
                  width: 10,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        color: Colors.grey[100]),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Flex(
                          direction: Axis.horizontal,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                              (constraints.constrainWidth() / 10).floor(),
                              (index) => SizedBox(
                                    height: 1,
                                    width: 5,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade400),
                                    ),
                                  )),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                  width: 10,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        color: Colors.grey[100]),
                  ),
                ),
              ],
            ),
          ),
          Stack(children: [
            Card(
              elevation: 3,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                height: 100,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Image.asset(
                      "assets/logo_gojek.png",
                      height: 20,
                    )),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300]!,
                      offset: const Offset(1.0, 5), //(x,y)
                      blurRadius: 1.0,
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24))),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.access_time,
                    color: Colors.black,
                    size: 10,
                  ),
                  Text(
                    "Voucher expires on ${voucher.endDate}",
                    style: textTheme.displaySmall!.copyWith(fontSize: 9),
                  ),
                  const Spacer(),
                  SizedBox(
                      width: 100,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(
                                side: BorderSide(
                                  color: Colors.green,
                                ),
                              ),
                              backgroundColor:
                                  selected ? Colors.grey : Colors.white,
                              elevation: 0),
                          onPressed: () {
                            if (selected) {
                              Get.back(result: null);
                            } else {
                              Get.back(result: voucher);
                            }
                          },
                          child: Text(
                            selected ? "Remove" : "Apply",
                            style: textTheme.displayMedium,
                          )))
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
