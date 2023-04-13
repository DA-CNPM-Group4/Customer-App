enum ComunicationMode {
  Normal("1"),
  WithGrpc("2");

  const ComunicationMode(this.value);
  final String value;
}

enum SEARCHTYPES { location, mydestination, both }

enum SearchLocationTypes {
  SELECTLOCATION,
  SELECTEVIAMAP,
  SELECTDESTINATION,
  HASBOTH
}

enum DrivingStatus {
  SELECTVEHICLE,
  HASVOUCHER,
  FINDING,
  FOUND,
  COMPLETED,
  CANCEL
}
