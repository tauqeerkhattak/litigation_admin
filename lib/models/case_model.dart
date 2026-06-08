class CaseData {
  final String id;
  String title;
  final String caseNumber;
  String clientName;
  DateTime hearingDate;
  String status;
  String description;

  CaseData({
    required this.id,
    required this.title,
    required this.caseNumber,
    required this.clientName,
    required this.hearingDate,
    required this.status,
    this.description = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'caseNumber': caseNumber,
      'clientName': clientName,
      'hearingDate': hearingDate.toIso8601String(),
      'status': status,
      'description': description,
    };
  }

  factory CaseData.fromMap(Map<String, dynamic> map) {
    return CaseData(
      id: map['id'],
      title: map['title'],
      caseNumber: map['caseNumber'],
      clientName: map['clientName'],
      hearingDate: DateTime.parse(map['hearingDate']),
      status: map['status'],
      description: map['description'] ?? '',
    );
  }
}
