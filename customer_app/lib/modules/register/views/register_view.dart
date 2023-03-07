import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

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
              onPressed: () {},
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
                          height: (keyboardHeight == 0)
                              ? heightSafeArea * 0.37
                              : heightSafeArea * 0.3,
                          child: Image.asset("assets/images/banner1.png",
                              width: safeWidth * 0.8, fit: BoxFit.fitWidth)),
                      const SizedBox(height: 30),
                      Center(
                        child: Text(
                          "Register",
                          style: BaseTextStyle.heading1(
                              fontSize: 30, color: Colors.blue),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        "Please fill in a few details below",
                        style: BaseTextStyle.heading2(
                            fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      _buildRegisterArea(),
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
              onPressed: () {},
              child: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ))),
    );
  }
}

Widget _buildRegisterArea() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Name",
        style: BaseTextStyle.heading3(fontSize: 22),
      ),
      TextFormField(
        decoration: InputDecoration(
          hintText: 'e.g., John Doe',
          hintStyle: BaseTextStyle.body3(color: Colors.grey),
        ),
      ),
      const SizedBox(height: 30),
      Text(
        "Email",
        style: BaseTextStyle.heading3(fontSize: 22),
      ),
      TextFormField(
        decoration: InputDecoration(
          hintText: 'e.g., name@gmail.com',
          hintStyle: BaseTextStyle.body3(color: Colors.grey),
        ),
      ),
      const SizedBox(height: 30),
      Text(
        "Phone number",
        style: BaseTextStyle.heading3(fontSize: 22),
      ),
      Row(
        children: [
          SizedBox(
            width: 100,
            height: 30,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.asset(
                      "assets/icons/flag.png",
                      height: 20,
                      width: 20,
                    ),
                    Text(
                      "+84",
                      style: BaseTextStyle.body3(),
                    ),
                  ],
                )),
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
            child: TextFormField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText: '123xxxxxxx',
                hintStyle: BaseTextStyle.body3(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
