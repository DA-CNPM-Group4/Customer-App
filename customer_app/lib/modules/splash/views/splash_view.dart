import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:customer_app/modules/home/views/home_view.dart';
import 'package:customer_app/modules/welcome/views/welcome_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        splash: Image.asset("assets/images/logo_taxihub.png"),
        splashIconSize: 150,
        nextScreen:
            controller.isFirstTime ? const WelcomeView() : const HomeView(),
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}
