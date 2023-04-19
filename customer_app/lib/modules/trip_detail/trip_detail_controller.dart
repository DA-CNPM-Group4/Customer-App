import 'package:customer_app/data/models/chat_message/chat_message.dart';
import 'package:customer_app/data/models/local_entity/driver_entity.dart';
import 'package:customer_app/data/models/local_entity/user_entity.dart';
import 'package:customer_app/data/models/requests/rate_trip_request.dart';
import 'package:customer_app/data/models/requests/rate_trip_response.dart';
import 'package:customer_app/data/models/requests/trip_response.dart';
import 'package:customer_app/data/services/rest/passenger_api_service.dart';
import 'package:customer_app/modules/lifecycle_controller.dart';
import 'package:customer_app/modules/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class TripDetailController extends GetxController {
  final LifeCycleController lifeCycleController =
      Get.find<LifeCycleController>();

  late UserEntity passenger;

  Rxn<DriverEntity> driver = Rxn<DriverEntity>();
  late TripResponse trip;
  late RateTripResponse feedback;
  late List<ChatMessage>? chatHistory;

  RxBool isLoading = false.obs;
  RxBool isRate = false.obs;
  RxBool isChatLoaded = false.obs;

  int star = 2;
  TextEditingController feedbackController = TextEditingController();
  @override
  void onInit() async {
    super.onInit();
    trip = Get.arguments as TripResponse;
    passenger = await lifeCycleController.getPassenger;
    isLoading.value = true;
    try {
      feedback = await PassengerAPIService.tripApi
          .getTripFeedBack(tripId: trip.tripId);
      isRate.value = true;
    } catch (e) {
      isRate.value = false;
    }
    try {
      driver.value =
          await PassengerAPIService.getDriverInfo(driverId: trip.driverId);
    } catch (e) {
      isLoading.value = false;
      showSnackBar("Driver info", "Get Driver Info Failed");
    }

    try {
      var chatLog =
          await PassengerAPIService.chatApi.getChatLog(tripId: trip.tripId);
      chatHistory = chatLog.toChatMessage(passenger.accountId);
    } catch (e) {
      isChatLoaded.value = false;
      showSnackBar("Chat History", "Get Chat History Failed");
    }
    isLoading.value = false;
  }

  Future<void> openRateDialog() async {
    Get.dialog(
      AlertDialog(
        title: const Center(child: Text('Rate your driver')),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage("assets/icons/face_icon.png"),
            ),
            Text(driver.value?.name ?? "Driver Name"),
            RatingBar.builder(
              initialRating: 1,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                star = rating.toInt();
              },
            ),
            TextFormField(
              controller: feedbackController,
            )
          ],
        ),
        actions: [
          Center(
            child: TextButton(
              child: const Text("Send"),
              onPressed: () async {
                try {
                  EasyLoading.show();
                  await PassengerAPIService.tripApi.rateTrip(
                    requestBody: RateTripRequestBody(
                      tripId: trip.tripId,
                      rate: star.toDouble(),
                      description: feedbackController.text,
                    ),
                  );
                  feedback = await PassengerAPIService.tripApi
                      .getTripFeedBack(tripId: trip.tripId);
                  isRate.value = true;
                  showSnackBar("Rate Success", "Rating Driver sucessfully");
                } catch (e) {
                  showSnackBar("Rate failed", "Rating Driver failed");
                } finally {
                  EasyLoading.dismiss();
                  Get.back(closeOverlays: true);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
