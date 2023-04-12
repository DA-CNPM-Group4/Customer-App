
class UserSettings {
  String name;
  String icons;
  String page;
  Function()? ontap;

  UserSettings(
      {required this.name,
      required this.icons,
      required this.page,
      this.ontap});
}
