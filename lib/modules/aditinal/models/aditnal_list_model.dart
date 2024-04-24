class AVQuotationList {
  final List<AVQuotationVisit> data;
  final int totalPages;

  AVQuotationList({
    required this.data,
    required this.totalPages,
  });

  factory AVQuotationList.fromJson(Map<String, dynamic> json) {
    List<AVQuotationVisit> data = [];

    for (var value in json.values) {
      if (value is Map<String, dynamic>) {
        data.add(AVQuotationVisit.fromJson(value));
      }
    }
    return AVQuotationList(data: data, totalPages: json['TotalPages']);
  }
}

class AVQuotationVisit {
  String quotationID;
  String referenceNo;
  String? ownerName;
  String? ownerPhone;
  String? ownerEmail;
  String? constructorName;
  String? constructorPhone;
  String? constructorEmail;
  String paid;
  String? paymentDate;
  String avTotal;
  String? paymentLink;
  String stage;
  String? ticketID;
  String createdAt;

  AVQuotationVisit({
    required this.quotationID,
    required this.referenceNo,
    this.ownerName,
    this.ownerPhone,
    this.ownerEmail,
    this.constructorName,
    this.constructorPhone,
    this.constructorEmail,
    required this.paid,
    this.paymentDate,
    required this.avTotal,
    this.paymentLink,
    required this.stage,
    this.ticketID,
    required this.createdAt,
  });

  factory AVQuotationVisit.fromJson(Map<String, dynamic> json) {
    return AVQuotationVisit(
      quotationID: json['QuotationID'],
      referenceNo: json['ReferenceNo'],
      ownerName: json['OwnerName'],
      ownerPhone: json['OwnerPhone'],
      ownerEmail: json['OwnerEmail'],
      constructorName: json['ConstructorName'],
      constructorPhone: json['ConstructorPhone'],
      constructorEmail: json['ConstructorEmail'],
      paid: json['Paid'],
      paymentDate: json['PaymentDate'],
      avTotal: json['AVTotal'],
      paymentLink: json['PaymentLink'],
      stage: json['Stage'],
      ticketID: json['TicketID'],
      createdAt: json['CreatedAt'],
    );
  }
}
