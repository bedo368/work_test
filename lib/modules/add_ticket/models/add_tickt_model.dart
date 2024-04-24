class AddTicktRequestModel {
  final String perToken;
  final int perUserID;
  final int perRoleID;
  final String degreeID;
  final String description;
  final String commentAR;
  final String correctiveEN;
  final String correctiveAR;
  final String referenceNo;

  factory AddTicktRequestModel({
    required String perToken,
    required int perUserID,
    required int perRoleID,
    String? degreeID,
    String? description,
    String? commentAR,
    String? correctiveEN,
    String? correctiveAR,
    String? referenceNo,
  }) {
    return AddTicktRequestModel._(
      perToken: perToken,
      perUserID: perUserID,
      perRoleID: perRoleID,
      degreeID: degreeID ?? '',
      description: description ?? '',
      commentAR: commentAR ?? '',
      correctiveEN: correctiveEN ?? '',
      correctiveAR: correctiveAR ?? '',
      referenceNo: referenceNo ?? '',
    );
  }

  AddTicktRequestModel._({
    required this.perToken,
    required this.perUserID,
    required this.perRoleID,
    required this.degreeID,
    required this.description,
    required this.commentAR,
    required this.correctiveEN,
    required this.correctiveAR,
    required this.referenceNo,
  });

  Map<String, dynamic> toJson() {
    return {
      "PerToken": perToken,
      "PerUserID": perUserID,
      "PerRoleID": perRoleID,
      "DegreeID": degreeID,
      "Description": description,
      "CommentAR": commentAR,
      "CorrectiveEN": correctiveEN,
      "CorrectiveAR": correctiveAR,
      "ReferenceNo": referenceNo,
    };
  }
}
