class Voucher {
  int? discountId;
  String? discountName;
  double? discountPercent;
  String? startDate;
  String? endDate;
  int? quantity;

  Voucher(
      {this.discountId,
      this.discountName,
      this.discountPercent,
      this.startDate,
      this.endDate,
      this.quantity});

  Voucher.fromJson(Map<String, dynamic> json) {
    discountId = json['discountId'];
    discountName = json['discountName'];
    discountPercent = json['discountPercent'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['discountId'] = discountId;
    data['discountName'] = discountName;
    data['discountPercent'] = discountPercent;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['quantity'] = quantity;
    return data;
  }
}
