import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

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
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            elevation: 0,
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
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          alignment: Alignment.center,
                          height:
                              (keyboardHeight == 0) ? heightSafeArea * 0.4 : 0,
                          child: Image.asset("assets/images/banner1.png",
                              width: safeWidth * 0.8, fit: BoxFit.fitWidth)),
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          "Login",
                          style: BaseTextStyle.heading1(
                              fontSize: 30, color: Colors.blue),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildLoginArea(),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
              elevation: 0.0,
              backgroundColor: Colors.grey,
              onPressed: () {
                //  TODO: Do some login logic
              },
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ))),
    );
  }
}

Widget _buildLoginArea() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Email",
        style: BaseTextStyle.heading3(fontSize: 20),
      ),
      TextFormField(
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            hintText: 'someone@gmail.com',
            hintStyle: BaseTextStyle.body3(color: Colors.grey),
            suffixIcon: const Icon(Icons.email_rounded)),
      ),
      const SizedBox(height: 16),
      Text(
        "Password",
        style: BaseTextStyle.heading3(fontSize: 20),
      ),
      TextFormField(
        textInputAction: TextInputAction.next,
        obscureText: true,
        decoration: InputDecoration(
            hintStyle: BaseTextStyle.body3(color: Colors.grey),
            hintText: "* * * * * *",
            suffixIcon: const Icon(Icons.lock)),
      ),
    ],
  );
}
