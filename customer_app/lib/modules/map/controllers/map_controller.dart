import 'dart:async';
import 'package:customer_app/Data/models/realtime_models/realtime_passenger.dart';
import 'package:customer_app/core/constants/common_object.dart';
import 'package:customer_app/core/constants/enum.dart';
import 'package:customer_app/data/common/location.dart';
import 'package:customer_app/data/models/local_entity/user_entity.dart';
import 'package:customer_app/data/models/realtime_models/realtime_driver.dart';
import 'package:customer_app/data/models/realtime_models/realtime_location.dart';
import 'package:customer_app/data/models/requests/create_triprequest_request.dart';
import 'package:customer_app/data/models/requests/rate_trip_request.dart';
import 'package:customer_app/data/models/vehicle.dart';
import 'package:customer_app/data/providers/firesbase_realtime_provider.dart';
import 'package:customer_app/data/services/device_location_service.dart';
import 'package:customer_app/data/services/passenger_api_service.dart';
import 'package:customer_app/data/services/firebase_realtime_service.dart';
import 'package:customer_app/modules/find_transportation/controllers/find_transportation_controller.dart';
import 'package:customer_app/modules/lifecycle_controller.dart';
import 'package:customer_app/modules/search_page/controllers/search_page_controller.dart';
import 'package:customer_app/modules/utils/widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../data/common/network_handler.dart';
import '../../../data/common/search_location.dart';
import '../../../data/models/voucher/voucher.dart';

class MapController extends GetxController {
  LifeCycleController lifeCycleController = Get.find<LifeCycleController>();
  late UserEntity pasenger;

  // cancel request
  final waitingSecond = 0.obs;
  var waitingMultipy = 1;
  var isShowCancel = false;
  late Timer? _timer;
  bool isPressCancel = false;

  var isLoading = false.obs;
  var isDragging = false.obs;
  var isShow = false;
  var pass = false.obs;
  var distance = 0.0.obs;
  var address = ''.obs;
  var selectedIndex = 0.obs;
  String tripId = "";
  String requestId = "";

// feedback
  TextEditingController feedbackController = TextEditingController();
  double star = 5;

  Rx<DrivingStatus> status = DrivingStatus.SELECTVEHICLE.obs;
  RxString text = "Your current location".obs;
  Voucher? voucher;
  var groupValue = "CASH".obs;

  // Map
  late GoogleMapController googleMapController;
  BitmapDescriptor? mapMarker;
  List<PointLatLng> searchResult = [];
  RxMap<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;
  RxList<LatLng> polylinePoints = <LatLng>[].obs;
  final RxList<Polyline> polyline = <Polyline>[].obs;

  // search
  var findTransportationController = Get.find<FindTransportationController>();
  var searchPageController = Get.find<SearchPageController>();

  SearchLocation? myLocation;
  SearchLocation? searchingLocation;

  SelectLocation? types;
  Location? from;
  Location? to;

  Map<dynamic, dynamic> request = {};
  Rxn<RealtimeDriver> driver = Rxn<RealtimeDriver>();
  Future<DatabaseEvent>? requestListener;
  StreamSubscription? driverListener;
  StreamSubscription? tripChangeStatusListener;
  StreamSubscription? tripDeleteListener;
  var isStateChanged = false.obs;

  @override
  void onClose() {
    print("ON CLOSE");
    _timer?.cancel();
    super.onClose();
  }

  @override
  void onInit() async {
    super.onInit();
    pasenger = await lifeCycleController.getPassenger;

    isLoading.value = true;
    await getCurrentPosition();

    from = Location(
        lat: findTransportationController.position["latitude"],
        lng: findTransportationController.position["longitude"]);

    await getAddress(from);
    await createMarker();

    to = Location(
        lat: findTransportationController.position["latitude"],
        lng: findTransportationController.position["longitude"]);

    polyline.add(Polyline(
      polylineId: const PolylineId('line1'),
      visible: true,
      points: polylinePoints,
      width: 5,
      color: Colors.blue,
    ));

    if (Get.arguments != null) {
      if (Get.arguments["type"] == SEARCHTYPES.location) {
        isShow = true;
        text.value = "Set pickup location";
        myLocation = Get.arguments["location"];
        await getAddress(myLocation!.location);
        await myLocationMarker("1", myLocation?.location,
            searchPageController.myPickupSearchLocationController);
        types = SelectLocation.SELECTLOCATION;
      } else {
        if (Get.arguments["location"] != null &&
            Get.arguments["destination"] == null) {
          isShow = true;
          from = Get.arguments["location"];
          text.value = "Set destination";
          await myLocationMarker(
              "2", to, searchPageController.myDestinationSearchController);
          types = SelectLocation.SELECTEVIAMAP;
        } else {
          isShow = true;
          searchingLocation = Get.arguments["destination"];
          text.value = "Set pickup location";
          from = searchPageController.currentLocation;
          await myLocationMarker(
              "1", from, searchPageController.myPickupSearchLocationController);
          types = SelectLocation.SELECTDESTINATION;
        }
      }
    }
    isLoading.value = false;
  }

  getCurrentPosition() async {
    findTransportationController.position.value =
        await findTransportationController.map.getCurrentPosition();
  }

  getAddress(Location? location) async {
    var temp = await findTransportationController.map
        .getCurrentAddress(location?.lat!, location?.lng!);
    address.value =
        '${temp.street}, ${temp.subAdministrativeArea}, ${temp.administrativeArea}, ${temp.country}';
    location?.address = address.value;
  }

  myLocationMarker(String makerId, Location? location,
      TextEditingController textEditController) async {
    await getAddress(location);
    textEditController.text = address.value;
    final Marker marker = Marker(
        markerId: MarkerId(makerId),
        draggable: true,
        onDrag: (position) {
          isDragging.value = true;
        },
        icon: makerId == "2"
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
            : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        onDragEnd: ((newPosition) async {
          isDragging.value = false;
          location?.setLocation(newPosition);
          await getAddress(location);
          textEditController.text = address.value;
        }),
        position: LatLng(
            location?.lat ?? findTransportationController.map.position.latitude,
            location?.lng ??
                findTransportationController.map.position.longitude));
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(location!.lat!, location.lng!), zoom: 15),
    ));
    markers[MarkerId(makerId)] = marker;
  }

  route(Location? from, Location? to) async {
    polylinePoints.clear();
    var start = "${from?.lat},${from?.lng}";
    var end = "${to?.lat},${to?.lng}";
    Map<String, String> query = {
      "key": "007f1251dd7ab0b676d064a314b46fa4",
      "origin": start,
      "destination": end,
      "mode": selectedIndex.value == 0 ? "motorcycle" : "car"
    };

    isLoading.value = true;
    var response = await NetworkHandler.getWithQuery('route', query);
    searchResult = PolylinePoints()
        .decodePolyline(response["result"]["routes"][0]["overviewPolyline"]);
    for (var point in searchResult) {
      polylinePoints.add(LatLng(point.latitude, point.longitude));
    }
    polyline.refresh();

    distance.value =
        response["result"]["routes"][0]["legs"][0]["distance"]['value'] / 1000;

    isLoading.value = false;
  }

  void dragPosition(MarkerId markerId, CameraPosition position) {
    LatLng newMarkerPosition =
        LatLng(position.target.latitude, position.target.longitude);
    markers[markerId] = Marker(markerId: markerId, position: newMarkerPosition);
  }

  Future<void> handleSearch() async {
    if (types == SelectLocation.SELECTLOCATION) {
      text.value = "Set pickup location";
      searchPageController.currentLocation = myLocation!.location!;
      searchPageController.myPickupSearchLocationController.text =
          address.value;
      searchPageController.location.clear();
      Get.back();
    } else if (types == SelectLocation.SELECTDESTINATION) {
      text.value = "Set up destination";
      await myLocationMarker("2", searchingLocation?.location,
          searchPageController.myDestinationSearchController);
      to = searchingLocation?.location;
      types = SelectLocation.HASBOTH;
    } else if (types == SelectLocation.SELECTEVIAMAP) {
      text.value = "Set pickup location";
      await myLocationMarker(
          "1", from, searchPageController.myPickupSearchLocationController);
      types = SelectLocation.HASBOTH;
    } else if (types == SelectLocation.HASBOTH) {
      await route(from, to);
      await updatePrice(CommonObject.vehicleList, distance.value);

      pass.value = true;
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                (from!.lat! + to!.lat!) / 2, (from!.lng! + to!.lng!) / 2),
            zoom: 15),
      ));
    }
  }

  Future<void> handleMyLocationButton() async {
    await getCurrentPosition();
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(findTransportationController.position["latitude"],
                findTransportationController.position["longitude"]),
            zoom: 15),
      ),
    );
  }

  String getRate(int i) {
    switch (i) {
      case 1:
        return "ONE";
      case 2:
        return "TWO";
      case 3:
        return "THREE";
      case 4:
        return "FOUR";
      case 5:
        return "FIVE";
      default:
        return "";
    }
  }

  Future<void> createMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/vehicle_icons/car_icon.png");
  }

  Future<void> handleBackButton() async {
    isShowCancel = true;
    Get.defaultDialog(
        middleText: "You are waiting pretty long, do you want cancel request?",
        backgroundColor: Colors.white,
        titleStyle: const TextStyle(color: Colors.black),
        middleTextStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        textConfirm: "Yes",
        onConfirm: () async {
          await cancelBooking();
          isShowCancel = false;
          Get.back();
        },
        onCancel: () {
          isShowCancel = false;
        },
        radius: 10,
        textCancel: "No");
  }

  Future<void> cancelBooking() async {
    EasyLoading.show();
    isLoading.value = true;

    requestListener?.ignore();
    PassengerAPIService.tripApi.cancelRequest(requestId: requestId);

    stopTimeout();

    status.value = DrivingStatus.SELECTVEHICLE;

    isLoading.value = false;
    EasyLoading.dismiss();
  }

  void stopTimeout() {
    waitingSecond.value = 0;
    waitingMultipy = 1;
    _timer?.cancel();
  }

  Future<void> updatePrice(List<Vehicle> vehicleList, double distance) async {
    try {
      EasyLoading.show();
      isLoading.value = true;
      var data = await PassengerAPIService.tripApi.getPrice(length: distance);

      vehicleList[0].price = data['motorbike'].toString();
      vehicleList[1].price = data['car4S'].toString();
      vehicleList[2].price = data['car7S'].toString();
    } catch (e) {
      showSnackBar("Error", e.toString());
    }
    EasyLoading.dismiss();
    isLoading.value = false;
  }

  Future<void> sendRequest() async {
    isLoading.value = true;

    var accountId = pasenger.accountId;

    var requestBody = CreateTripRequestBody(
        LatStartAddr: from!.lng!,
        LongStartAddr: from!.lng!,
        StartAddress: from!.address!,
        LongDesAddr: to!.lng!,
        LatDesAddr: to!.lng!,
        Destination: to!.address!,
        Distance: distance.value,
        PassengerNote: "Fast!!!",
        PassengerPhone: pasenger.phone,
        Price:
            double.parse(CommonObject.vehicleList[selectedIndex.value].price!)
                .ceil(),
        VehicleType: CommonObject.vehicleList[selectedIndex.value].type!);

    try {
      await FirebaseRealtimeService.instance.setPassengerNode(
        passenger: RealtimePassenger(
          info: RealtimePassengerInfo(
            name: pasenger.name,
            phone: pasenger.phone,
          ),
          location: RealtimeLocation(
            address: from!.address!,
            lat: from!.lat!,
            long: from!.lng!,
          ),
        ),
        passengerId: accountId,
      );

      requestId =
          await PassengerAPIService.tripApi.createRequest(body: requestBody);
      isLoading.value = false;

      status.value = DrivingStatus.FINDING;
      startTimer();

      requestListener = FirebaseDatabase.instance
          .ref(FirebaseRealtimePaths.requests)
          .child(requestId)
          .once(DatabaseEventType.childRemoved);

      requestListener?.then((value) async {
        var tripInfo =
            await PassengerAPIService.tripApi.getCurrentTrip(requestId);
        tripId = tripInfo['tripId'] as String;
        var driverId = tripInfo['driverId'] ?? "testDriverId";
        polylinePoints.clear();

        stopTimeout();
        driver.value =
            await FirebaseRealtimeService.instance.readDriverNode(driverId);
        status.value = DrivingStatus.FOUND;

        await enableRealtimeLocator();

        tripChangeStatusListener = FirebaseDatabase.instance
            .ref(FirebaseRealtimePaths.trips)
            .child(tripId)
            .onChildChanged
            .listen((event) {
          if (!event.snapshot.exists) return;
          isStateChanged.value = true;
        });

        assignDriverListener(driverId);

        FirebaseDatabase.instance
            .ref(FirebaseRealtimePaths.trips)
            .child(tripId)
            .once(DatabaseEventType.childRemoved)
            .then((value) async {
          await driverListener?.cancel();
          await disableRealtimeLocator();
          if (isStateChanged.value) {
            rateDialog(tripId);
            showSnackBar("Trip Completed", "Trip Completed");
          } else {
            showSnackBar("Trip Cancel", "Your trip have been cancel by driver");
            status.value = DrivingStatus.SELECTVEHICLE;
          }
          isStateChanged.value = false;
        });
      });
    } catch (_) {}
    isLoading.value = false;
  }

  void assignDriverListener(driverId) {
    driverListener = FirebaseDatabase.instance
        .ref(FirebaseRealtimePaths.drivers)
        .child(driverId)
        .child("location")
        .onValue
        .listen(
      (event) async {
        final data = Map<String, dynamic>.from(event.snapshot.value as Map);
        var driverLocation = RealtimeLocation.fromJson(data);

        markers[const MarkerId("1")] = Marker(
          markerId: const MarkerId("1"),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: const InfoWindow(title: "Driver Location"),
          position: LatLng(
            driverLocation.lat,
            driverLocation.long,
          ),
        );
      },
    );
  }

  StreamSubscription? gpsStreamSubscription;
  Future<void> enableRealtimeLocator() async {
    var stream = await DeviceLocationService.instance.getLocationStream();
    gpsStreamSubscription = stream.listen((value) async {
      var address =
          await DeviceLocationService.instance.getAddressFromLatLang(value);
      var position = RealtimeLocation(
          lat: value.latitude, long: value.longitude, address: address);
      await FirebaseRealtimeService.instance
          .updatePassengerNode(pasenger.accountId, position);
    });
  }

  Future<void> disableRealtimeLocator() async {
    await gpsStreamSubscription?.cancel();
    await FirebaseRealtimeService.instance
        .deletePassengerNode(pasenger.accountId);
  }

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) async {
        print("timer is running");
        waitingSecond.value += 1;
        if (waitingSecond.value > 30 * waitingMultipy) {
          waitingMultipy += 1;
          isShowCancel ? null : await handleBackButton();
        }
      },
    );
  }

  void rateDialog(String tripId) {
    Get.dialog(
      AlertDialog(
        title: const Center(child: Text('Rate your driver')),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage("assets/icon/face_icon.png"),
            ),
            Text(driver.value?.info.name ?? "Driver Name"),
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
                star = rating;
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
                      tripId: tripId,
                      rate: star,
                      description: feedbackController.text,
                    ),
                  );
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
