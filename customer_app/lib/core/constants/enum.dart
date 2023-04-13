enum ComunicationMode {
  ClientDoShit("1"),
  BackDoShit("2");

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
