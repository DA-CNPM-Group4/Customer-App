import 'package:customer_app/modules/login/views/login_view.dart';
import 'package:customer_app/modules/register/views/register_view.dart';
import 'package:customer_app/modules/welcome/controllers/welcome_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:get/get.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<String> banners = [
      "assets/images/banner1.png",
      "assets/images/banner2.png",
      "assets/images/banner3.png",
    ];

    return Scaffold(
        appBar: AppBar(
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                  color: Colors.grey, shape: BoxShape.circle),
              child: const Center(
                  child: Text(
                "EN",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: Align(
          alignment: Alignment.center,
          child: SafeArea(
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 400,
                  child: CarouselSlider.builder(
                    itemCount: 3,
                    slideBuilder: ((itemIndex) {
                      return Image.asset(banners[itemIndex]);
                    }),
                    slideIndicator: CircularSlideIndicator(
                      currentIndicatorColor: Colors.green,
                    ),
                  ),
                ),
                Container(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 32),
                    width: double.infinity,
                    height: 72,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        onPressed: () {
                          Get.toNamed(Routes.LOGIN);
                        },
                        child: const Text("Log in"))),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(
                              side: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                            primary: Colors.white,
                            elevation: 0),
                        onPressed: () {
                          Get.toNamed(Routes.REGISTER);
                        },
                        child: Text(
                          "I'm new, sign me up",
                          style: BaseTextStyle.body1(color: BaseColor.green),
                        ))),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: "By logging in or registering, you agree to our ",
                      style: BaseTextStyle.body1(color: BaseColor.black),
                    ),
                    TextSpan(
                      text: "Terms of service ",
                      style: BaseTextStyle.body1(color: Colors.blue),
                    ),
                    TextSpan(
                      text: "and ",
                      style: BaseTextStyle.body1(color: BaseColor.black),
                    ),
                    TextSpan(
                      text: "Privacy policy",
                      style: BaseTextStyle.body1(color: Colors.blue),
                    ),
                  ])),
                )
              ],
            )),
          ),
        ));
  }
}
