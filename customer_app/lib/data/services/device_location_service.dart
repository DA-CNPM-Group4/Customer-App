import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class DeviceLocationService {
  static DeviceLocationService? _instance;

  // singleton
  static DeviceLocationService get instance {
    return _instance ??= DeviceLocationService._();
  }

  late LocationSettings currentSetting;
  DeviceLocationService._() {
    currentSetting = _getDeviceSetting();
  }

  factory DeviceLocationService() {
    _instance ??= DeviceLocationService._();
    // since you are sure you will return non-null value, add '!' operator
    return _instance!;
  }
  // singleton

  Future<Position> getCurrentPosition() async {
    bool canAccessLocation = await requestPermission();

    if (canAccessLocation) {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } else {
      throw Future.error('Access Device Location Denied');
    }
  }

  Future<Map<String, dynamic>> getCurrentPositionAsMap() async {
    bool canAccessLocation = await requestPermission();

    if (canAccessLocation) {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return {"latitude": position.latitude, "longitude": position.longitude};
    } else {
      throw Future.error('Access Device Location Denied');
    }
  }

  Future<Stream<Position>> getLocationStream() async {
    if (await requestPermission()) {
      return Geolocator.getPositionStream(locationSettings: currentSetting);
    } else {
      throw Stream.error("Access Device Location Denied");
    }
  }

  Future<String> getAddressFromLatLang(
      {required double latitude, required double longitude}) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemark[0];
    return '${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}';
  }

  Future<bool> requestPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }

      // Only in IOS
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
    }
    return true;
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  LocationSettings _getDeviceSetting() {
    // if (defaultTargetPlatform == TargetPlatform.android) {
    //   return AndroidSettings(
    //       accuracy: LocationAccuracy.bestForNavigation,
    //       distanceFilter: 5,
    //       forceLocationManager: true,
    //       intervalDuration: const Duration(seconds: 5),
    //       //(Optional) Set foreground notification config to keep the app alive
    //       //when going to the background
    //       foregroundNotificationConfig: const ForegroundNotificationConfig(
    //         notificationText:
    //             "Example app will continue to receive your location even when you aren't using it",
    //         notificationTitle: "Running in Background",
    //         enableWakeLock: true,
    //       ));
    // } else if (defaultTargetPlatform == TargetPlatform.iOS ||
    //     defaultTargetPlatform == TargetPlatform.macOS) {
    //   return AppleSettings(
    //     accuracy: LocationAccuracy.bestForNavigation,
    //     activityType: ActivityType.fitness,
    //     distanceFilter: 5,
    //     pauseLocationUpdatesAutomatically: true,
    //     // Only set to true if our app will be started up in the background.
    //     showBackgroundLocationIndicator: false,
    //   );
    // } else {
    return const LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 5,
    );
  }
}
