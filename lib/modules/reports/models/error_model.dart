class ErrorModel {
  final bool error;
  final Map<String, dynamic> data;

  ErrorModel({required this.error, required this.data});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      error: json['error'],
      data: json,
    );
  }
}
