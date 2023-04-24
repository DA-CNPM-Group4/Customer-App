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

  String previousSearchPickup = "";
  String previousSearhDestination = "";

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
  void onClose() {
    _debounce?.cancel();
    animationController.dispose();
    pickupFocusNode.dispose();
    destinationFocusNode.dispose();
    myPickupSearchLocationController.dispose();
    myDestinationSearchController.dispose();
    super.onClose();
  }

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
      if (Get.routing.current != Routes.SEARCH_PAGE ||
          previousSearchPickup == myPickupSearchLocationController.text) return;

      if (myPickupSearchLocationController.text == "") {
        location = [];
      }
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 650), () {
        if (myPickupSearchLocationController.text != "") {
          previousSearchPickup = myPickupSearchLocationController.text;
          searchLocation(myPickupSearchLocationController.text);
        }
      });
    });

    myDestinationSearchController.addListener(() {
      if (Get.routing.current != Routes.SEARCH_PAGE ||
          previousSearhDestination == myDestinationSearchController.text) {
        return;
      }

      if (myDestinationSearchController.text.isEmpty) {
        location = [];
      }
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 650), () {
        if (myDestinationSearchController.text != "") {
          previousSearhDestination = myDestinationSearchController.text;
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
      var iResult = response['result'][i];
      debugPrint("Map4D Search Result $i : ${iResult.toString()} ");
      location.add(SearchLocation.fromJson(iResult));
    }
    isLoading.value = false;
  }

  void selectSearchLocation(int index) {
    if (myPickupSearchLocationController.text.isNotEmpty &&
        myDestinationSearchController.text.isEmpty) {
      previousSearchPickup = location[index].address!;

      myPickupSearchLocationController.text = location[index].address!;

      debugPrint("Select Pickup Location: ${location[index].toJson()}");

      Get.toNamed(Routes.MAP, arguments: {
        'location': location[index],
        "type": SEARCHTYPES.pickupLocation
      });
    } else if (myPickupSearchLocationController.text.isEmpty &&
        myDestinationSearchController.text.isNotEmpty) {
      previousSearhDestination = location[index].address!;

      myDestinationSearchController.text = location[index].address!;

      debugPrint("Select Destination Location: ${location[index].toJson()}");

      Get.toNamed(Routes.MAP, arguments: {
        'destination': location[index],
        "type": SEARCHTYPES.mydestination
      });
    } else if (myPickupSearchLocationController.text.isNotEmpty &&
        myDestinationSearchController.text.isNotEmpty) {
      previousSearhDestination = location[index].address!;
      myDestinationSearchController.text = location[index].address!;

      debugPrint("Select Both Location: ${location[index].toJson()}");

      Get.toNamed(Routes.MAP, arguments: {
        'destination': location[index],
        "type": SEARCHTYPES.mydestination
      });
    }
  }
}
