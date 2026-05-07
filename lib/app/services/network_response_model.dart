class NetworkResponseModel {
  final bool isSuccess;
  final int statusCode;
  final dynamic responseData;
  final String? message;

  NetworkResponseModel({
    required this.isSuccess,
    required this.statusCode,
    required this.responseData,
    required this.message,
  });
}
