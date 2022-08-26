class CardDetail {
  final String nickName;
  final int billingDate;
  final double currentAmount;
  final double cashLimit;

  CardDetail(
      {required this.nickName,
      required this.billingDate,
      required this.currentAmount,
      required this.cashLimit});

  Map<String, dynamic> toMap() {
    return {
      'nickName': nickName,
      'billingDate': billingDate,
      'currentAmount': currentAmount,
      'cashLimit': cashLimit
    };
  }

  CardDetail.fromMap(Map<String, dynamic> res)
      : nickName = res["nickName"],
        billingDate = res["billingDate"],
        currentAmount = res["currentAmount"],
        cashLimit = res["cashLimit"];

  @override
  String toString() {
    return 'Card{nickName:$nickName, billingDate: $billingDate,'
        ' currentAmount:$currentAmount, cashLimit:$cashLimit}';
  }
}
