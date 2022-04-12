import 'dart:convert';

class SendMoneyReqModel {
  String? sendMoneyId;
  String? amount;
  String? type;
  String? notes;
  String? tokenId;
  String? sn;
  String? list;

  SendMoneyReqModel(
      {this.sn,
      this.sendMoneyId,
      this.amount,
      this.type,
      this.list,
      this.notes,
      this.tokenId});
  Map<String, dynamic> toJson() {
    return {"dataArray": list};
  }
}
