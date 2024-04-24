class DegreeModel {
  final String degreeID;
  final String name;
  final String category;
  final String createdAt;

  DegreeModel({
    required this.degreeID,
    required this.name,
    required this.category,
    required this.createdAt,
  });

  factory DegreeModel.fromJson(Map<String, dynamic> json) {
    return DegreeModel(
      degreeID: json['DegreeID'],
      name: json['Name'],
      category: json['Category'],
      createdAt: json['CreatedAt'],
    );
  }
}

class DegreeListModel {
  final Map<String, DegreeModel> degrees;

  DegreeListModel({required this.degrees});

  factory DegreeListModel.fromJson(Map<String, dynamic> json) {
    Map<String, DegreeModel> degreesMap = {};
    json.forEach((key, value) {
      if (key != 'error') {
        degreesMap[key] = DegreeModel.fromJson(value);
      }
    });
    return DegreeListModel(degrees: degreesMap);
  }
}
