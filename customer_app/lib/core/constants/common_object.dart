import 'package:customer_app/data/models/vehicle.dart';

class CommonObject {
  static List<Vehicle> vehicleList = [
    Vehicle(
        name: "Motorbike",
        type: "Motorbike",
        price: "12500",
        duration: "",
        priceAfterVoucher: "",
        picture: "assets/images/motorcycle.png",
        seatNumber: "2"),
    Vehicle(
        name: "Car4S",
        type: "Car4S",
        price: "29000",
        duration: "",
        priceAfterVoucher: "",
        picture: "assets/images/car.png",
        seatNumber: "4"),
    Vehicle(
        name: "Car7S",
        type: "Car7S",
        price: "34000",
        duration: "",
        priceAfterVoucher: "",
        picture: "assets/images/car.png",
        seatNumber: "7"),
  ];
}
