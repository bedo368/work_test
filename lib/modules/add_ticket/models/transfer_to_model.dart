class TransferToModel {
  final String resourceId;
  final String name;

  TransferToModel({required this.resourceId, required this.name});

  factory TransferToModel.fromJson(Map<String, dynamic> json) =>
      TransferToModel(
        resourceId: json["ResourceID"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "ResourceID": resourceId,
        "Name": name,
      };
}

class TransferToListModel {
  final Map<String, TransferToModel> list;

  TransferToListModel({
    required this.list,
  });

  factory TransferToListModel.fromJson(Map<String, dynamic> json) {
    Map<String, TransferToModel> resourcesMap = {};
    json.forEach((key, value) {
      if (key != 'error') {
        resourcesMap[key] = TransferToModel.fromJson(value);
      }
    });
    return TransferToListModel(
      list: resourcesMap,
    );
  }
}
