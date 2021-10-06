class ErrorModel {
  final String status, message;

  ErrorModel({
    required this.status,
    required this.message,
  });
  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      status: json['status'] ?? '',
      message: json['msg'] ?? '',
    );
  }
  bool hasData() => status != '' && message != '';
}
