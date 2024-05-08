class StageResponse {
  final String stageId;
  final bool error;
  final bool declaration;
  final String pStageId;
  final DateTime stageDate;
  final String projectId;
  final String referenceNo;
  final String owner;
  final String city;
  final String ownerMobile;
  final String projectName;
  final String categoryName;
  final String cost;
  final String stageName;

  StageResponse({
    required this.stageId,
    required this.error,
    required this.declaration,
    required this.pStageId,
    required this.stageDate,
    required this.projectId,
    required this.referenceNo,
    required this.owner,
    required this.city,
    required this.ownerMobile,
    required this.projectName,
    required this.categoryName,
    required this.cost,
    required this.stageName,
  });

  factory StageResponse.fromJson(Map<String, dynamic> json) {
    return StageResponse(
      stageId: json['StageID'] ?? '',
      error: json['error'] ?? '',
      declaration: json['Declaration'] ?? "",
      pStageId: json['PStageID'],
      stageDate: json['StageDate'] == null
          ? DateTime.now()
          : DateTime.parse(json['StageDate']),
      projectId: json['ProjectID'] ?? '',
      referenceNo: json['ReferenceNo'] ?? '',
      owner: json['Owner'] ?? '',
      city: json['City'] ?? '',
      ownerMobile: json['OwnerMobile'] ?? '',
      projectName: json['ProjectName'] ?? '',
      categoryName: json['CategoryName'] ?? "",
      cost: json['Cost'] ?? '',
      stageName: json['StageName'] ?? '',
    );
  }
}
