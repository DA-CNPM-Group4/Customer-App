import 'dart:async';

import 'package:customer_app/core/constants/enum.dart';
import 'package:customer_app/data/common/network_handler.dart';
import 'package:customer_app/data/models/local_entity/location.dart';
import 'package:customer_app/data/models/local_entity/search_location.dart';
import 'package:customer_app/modules/find_transportation/controllers/find_transportation_controller.dart';
import 'package:customer_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var isLoading = false.obs;

  late AnimationController animationController;
  late Animation animation;

  FocusNode pickupFocusNode = FocusNode();
  FocusNode destinationFocusNode = FocusNode();

  var isMyLocationFocused = false.obs;
  var isDestinationFocused = false.obs;

  var findTransportationController = Get.find<FindTransportationController>();
  TextEditingController myPickupSearchLocationController =
      TextEditingController();
  TextEditingController myDestinationSearchController = TextEditingController();
  List<SearchLocation> location = [];
  late Location currentLocation;
  late Location myDestination;

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

    pickupFocusNode.addListener(() {
      if (pickupFocusNode.hasFocus) {
        isMyLocationFocused.value = true;
      } else {
        isMyLocationFocused.value = false;
      }
    });
    destinationFocusNode.addListener(() {
      if (destinationFocusNode.hasFocus) {
        isDestinationFocused.value = true;
      } else {
        isDestinationFocused.value = false;
      }
    });

    myPickupSearchLocationController.addListener(() {
      if (myPickupSearchLocationController.text == "") {
        location = [];
      }
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 650), () {
        if (myPickupSearchLocationController.text != "") {
          searchLocation(myPickupSearchLocationController.text);
        }
      });
    });

    myDestinationSearchController.addListener(() {
      if (myDestinationSearchController.text.isEmpty) {
        location = [];
      }
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 650), () {
        if (myDestinationSearchController.text != "") {
          searchLocation(myDestinationSearchController.text);
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

  void selectSearchLocation(int index) {
    if (myPickupSearchLocationController.text.isNotEmpty &&
        myDestinationSearchController.text.isEmpty) {
      myPickupSearchLocationController.text = location[index].address!;
      Get.toNamed(Routes.MAP, arguments: {
        'location': location[index],
        "type": SEARCHTYPES.pickupLocation
      });
    } else if (myPickupSearchLocationController.text.isEmpty &&
        myDestinationSearchController.text.isNotEmpty) {
      myDestinationSearchController.text = location[index].address!;
      Get.toNamed(Routes.MAP, arguments: {
        'destination': location[index],
        "type": SEARCHTYPES.mydestination
      });
    } else if (myPickupSearchLocationController.text.isNotEmpty &&
        myDestinationSearchController.text.isNotEmpty) {
      Get.toNamed(Routes.MAP, arguments: {
        'destination': location[index],
        "type": SEARCHTYPES.mydestination
      });
    }
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }
}
