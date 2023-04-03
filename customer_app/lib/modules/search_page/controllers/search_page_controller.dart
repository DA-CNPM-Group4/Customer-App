import 'dart:async';

import 'package:customer_app/data/common/network_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/common/location.dart';
import '../../../data/common/search_location.dart';
import '../../find_transportation/controllers/find_transportation_controller.dart';

class SearchPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  FocusNode myLocation = FocusNode();
  FocusNode destination = FocusNode();

  var isMyLocationFocused = false.obs;
  var isDestinationFocused = false.obs;
  var findTransportationController = Get.find<FindTransportationController>();

  TextEditingController myLocationController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  List<SearchLocation> location = [];
  late Location currentLocation;
  late Location myDestination;
  var isLoading = false.obs;

  String text = "";
  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    currentLocation = Location(
        lat: findTransportationController.position["latitude"],
        lng: findTransportationController.position["longitude"]);

    myDestination = Location(
        lat: findTransportationController.position["latitude"],
        lng: findTransportationController.position["longitude"]);
    myLocation.addListener(() {
      if (myLocation.hasFocus) {
        isMyLocationFocused.value = true;
      } else {
        isMyLocationFocused.value = false;
      }
    });
    destination.addListener(() {
      if (destination.hasFocus) {
        isDestinationFocused.value = true;
      } else {
        isDestinationFocused.value = false;
      }
    });

    myLocationController.addListener(() {
      if (myLocationController.text == "") {
        location = [];
      }
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 650), () {
        if (myLocationController.text != "") {
          searchLocation(myLocationController.text);
        }
      });
    });

    destinationController.addListener(() {
      if (destinationController.text.isEmpty) {
        location = [];
      }
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 650), () {
        if (destinationController.text != "") {
          searchLocation(destinationController.text);
        }
      });
    });
  }

  searchLocation(String text) async {
    isLoading.value = true;
    location = [];
    Map<String, String> query = {
      "key": "007f1251dd7ab0b676d064a314b46fa4",
      "text": text,
      "location": "${currentLocation.lat},${currentLocation.lng}"
    };
    var response =
        await NetworkHandler.getWithQuery('place/text-search', query);
    for (var i = 0; i < response["result"].length; i++) {
      location.add(SearchLocation.fromJson(response["result"][i]));
    }
    isLoading.value = false;
  }
}
