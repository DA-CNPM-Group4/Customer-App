import 'package:customer_app/routes/app_pages.dart';
import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class WelcomeView extends StatelessWidget {
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
              mainAxisAlignment: MainAxisAlignment.start,
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
                        key: const Key("welcome_login_btn"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () {
                          Get.toNamed(Routes.LOGIN);
                        },
                        child: const Text("Log in"))),
                Container(
                    padding:
                        const EdgeInsets.only(left: 16, top: 10, right: 16),
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(
                              side: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                            backgroundColor: Colors.white,
                            elevation: 0),
                        onPressed: () {
                          Get.toNamed(Routes.REGISTER);
                        },
                        child: Text(
                          "I'm new, sign me up",
                          style: BaseTextStyle.body1(color: BaseColor.green),
                        ))),
                TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.FORGOT_PASSWORD);
                    },
                    child: Text(
                      "Forgot password?",
                      style: BaseTextStyle.subtitle3(
                          fontSize: 14, color: Colors.blue),
                    )),
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
