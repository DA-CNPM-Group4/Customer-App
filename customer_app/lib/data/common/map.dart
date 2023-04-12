// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';

// class Maps {
//   late Position position;
//   late bool serviceEnabled;
//   late LocationPermission permission;

//   Future<Position> determinePosition() async {
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//     return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//   }

//   Future<Map<String, dynamic>> getCurrentPosition() async {
//     position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     return {"latitude": position.latitude, "longitude": position.longitude};
//   }

//   Future<Placemark> getCurrentAddress(
//       dynamic latitude, dynamic longitude) async {
//     List<Placemark> newPlace =
//         await placemarkFromCoordinates(latitude, longitude);
//     return newPlace[0];
//   }
// }
