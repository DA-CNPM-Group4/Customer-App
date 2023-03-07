import 'package:customer_app/modules/welcome/views/welcome_view.dart';
import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class PasswordView extends StatelessWidget {
  const PasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double heightSafeArea = size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    double safeWidth = min(size.width, 500);
    double keyboardHeight = EdgeInsets.fromWindowPadding(
            WidgetsBinding.instance.window.viewInsets,
            WidgetsBinding.instance.window.devicePixelRatio)
        .bottom;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.info,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        alignment: Alignment.center,
                        height: (keyboardHeight == 0)
                            ? heightSafeArea * 0.3
                            : heightSafeArea * 0.28,
                        child: Image.asset("assets/images/car.png",
                            width: safeWidth * 0.6, fit: BoxFit.fitWidth)),
                    const SizedBox(height: 18),
                    Text(
                      "You're almost there!",
                      style: BaseTextStyle.heading1(),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Please enter a password in order to create an account in our system.",
                      style: BaseTextStyle.body1(),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      "Password",
                      style: BaseTextStyle.heading3(fontSize: 22),
                    ),
                    Form(
                      child: TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 0.0,
            backgroundColor: Colors.grey,
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          )),
    );
  }
}
