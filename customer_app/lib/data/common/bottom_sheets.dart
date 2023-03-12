import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

// StickyHeader sticky({required BuildContext context,required String title, String? subtitle, required Widget content}) {
//   var textTheme = Theme.of(context).textTheme;
//   return StickyHeader(
//       header: Column(
//         children: [
//           Text(
//             "title",
//             style: textTheme.headline1!.copyWith(fontSize: 12),
//           ),
//           Text(
//             "subtitle",
//             style: textTheme.headline2!,
//           ),
//         ],
//       ),
//       content: content);
// }

void showPaymentMethod(
    {required BuildContext context, required double height, required RxString groupValue}) {
  var textTheme = Theme.of(context).textTheme;
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: false,
    builder: (BuildContext context) {
      return Container(
        height: height,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Select a payment method",
                style: textTheme.headline1,
              ),
              Text(
                "Digital payment method",
                style: textTheme.headline1!.copyWith(fontSize: 18),
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.creditcard_fill),
                title: const Text("E-Wallet"),
                trailing: Radio(
                    value: "E_WALLET",
                    groupValue: groupValue.value,
                    onChanged: (value) {
                      groupValue.value = value.toString();
                    }),
              ),
              Text(
                "Traditional payment method",
                style: textTheme.headline1!.copyWith(fontSize: 18),
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.money_dollar_circle_fill, color: Colors.yellow,),
                title: const Text("Cash"),
                trailing: Radio(
                    value: "CASH",
                    groupValue: groupValue.value,
                    onChanged: (value) {
                      groupValue.value= value.toString();
                    }),
              ),
            ],
          ),
        ),
      );
    },
  );
}
