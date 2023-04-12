class Wallet {
  int? id;
  String? walletType;
  int? idOwner;
  double? balance;
  String? activeCode;
  bool? status;

  Wallet({id, walletType, idOwner, balance, activeCode, status});

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    walletType = json['walletType'];
    idOwner = json['idOwner'];
    balance = json['balance'];
    activeCode = json['activeCode'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['walletType'] = walletType;
    data['idOwner'] = idOwner;
    data['balance'] = balance;
    data['activeCode'] = activeCode;
    data['status'] = status;
    return data;
  }
}
