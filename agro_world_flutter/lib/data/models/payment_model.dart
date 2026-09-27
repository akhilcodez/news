class PaymentModel {
  final String productName;
  final String productImage;
  final double productPrice;
  final String paymentStatus;
  final String paymentID;
  final String paymentDate;

  PaymentModel({
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.paymentStatus,
    required this.paymentID,
    this.paymentDate = "",
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      productName: json['productName']?.toString() ?? '',
      productImage: json['productImage']?.toString() ?? '',
      productPrice: json['productPrice'] != null
          ? double.tryParse(json['productPrice'].toString()) ?? 0.0
          : 0.0,
      paymentStatus: json['paymentStatus']?.toString() ?? 'Success',
      paymentID: json['paymentID']?.toString() ?? '',
      paymentDate: json['paymentDate']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'productImage': productImage,
      'productPrice': productPrice,
      'paymentStatus': paymentStatus,
      'paymentID': paymentID,
      'paymentDate': paymentDate,
    };
  }
}
