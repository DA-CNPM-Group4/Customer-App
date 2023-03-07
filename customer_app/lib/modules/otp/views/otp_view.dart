import 'package:customer_app/themes/base_style.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpView extends StatelessWidget {
  const OtpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/img.png",
                      height: 80,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "You're almost there!",
                      style: BaseTextStyle.heading1(),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "You must enter OTP which we sent you earlier",
                      style: BaseTextStyle.body1(),
                    ),
                    const SizedBox(height: 32),
                    Form(
                      child: Pinput(
                        length: 6,
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          onPressed: () {},
                          child: const Text("Resend")),
                    )
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 0.0,
            backgroundColor: Colors.grey,
            onPressed: () async {},
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          )),
    );
  }
}
