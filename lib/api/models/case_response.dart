import 'package:json_annotation/json_annotation.dart';

import '../../utils/constants.dart';

part 'case_response.g.dart';

@JsonSerializable()
class CaseDocument {
  final String id;
  final DocumentType type;
  final String? name;
  final String? url;
  final String? uploadedAt;

  CaseDocument({
    required this.id,
    required this.type,
    this.name,
    this.url,
    this.uploadedAt,
  });

  factory CaseDocument.fromJson(Map<String, dynamic> json) =>
      _$CaseDocumentFromJson(json);
  Map<String, dynamic> toJson() => _$CaseDocumentToJson(this);
}

@JsonSerializable()
class CaseHearing {
  final String? id;
  final String? caseId;
  final String? date;
  final String submitted;
  final String happened;
  final String order;
  final String? nextDate;

  CaseHearing({
    required this.id,
    required this.caseId,
    required this.date,
    required this.submitted,
    required this.happened,
    required this.order,
    this.nextDate,
  });

  factory CaseHearing.fromJson(Map<String, dynamic> json) =>
      _$CaseHearingFromJson(json);
  Map<String, dynamic> toJson() => _$CaseHearingToJson(this);
}

@JsonSerializable()
class CaseDataResponse {
  final String? id;
  final String? userId;
  final String? caseNo;
  final int? year;
  final Court? court;
  final Bench? bench;
  final String title;
  final List<String> plaintiffs;
  final List<String> respondents;
  final String? firstHearing;
  final String? lastHearing;
  final String? nextHearing;
  final CaseStatus status;
  final String notes;
  final CaseNature? caseNature;
  final Department? department;
  final Taluka? taluka;
  final List<CaseDocument> documents;
  final List<CaseHearing> hearings;

  String get clientName => plaintiffs.isNotEmpty ? plaintiffs.first : 'N/A';

  DateTime get nextHearingDate =>
      nextHearing != null ? DateTime.parse(nextHearing!) : DateTime.now();

  CaseDataResponse copyWith({
    String? id,
    String? userId,
    String? caseNo,
    int? year,
    Court? court,
    Bench? bench,
    String? title,
    List<String>? plaintiffs,
    List<String>? respondents,
    String? firstHearing,
    String? lastHearing,
    String? nextHearing,
    CaseStatus? status,
    String? notes,
    CaseNature? caseNature,
    Department? department,
    Taluka? taluka,
    List<CaseDocument>? documents,
    List<CaseHearing>? hearings,
  }) {
    return CaseDataResponse(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      caseNo: caseNo ?? this.caseNo,
      year: year ?? this.year,
      court: court ?? this.court,
      bench: bench ?? this.bench,
      title: title ?? this.title,
      plaintiffs: plaintiffs ?? this.plaintiffs,
      respondents: respondents ?? this.respondents,
      firstHearing: firstHearing ?? this.firstHearing,
      lastHearing: lastHearing ?? this.lastHearing,
      nextHearing: nextHearing ?? this.nextHearing,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      caseNature: caseNature ?? this.caseNature,
      department: department ?? this.department,
      taluka: taluka ?? this.taluka,
      documents: documents ?? this.documents,
      hearings: hearings ?? this.hearings,
    );
  }

  CaseDataResponse({
    this.id,
    this.userId,
    this.caseNo,
    this.year,
    this.court,
    this.bench,
    required this.title,
    required this.plaintiffs,
    required this.respondents,
    this.firstHearing,
    this.lastHearing,
    this.nextHearing,
    required this.status,
    required this.notes,
    this.caseNature,
    this.department,
    this.taluka,
    required this.documents,
    required this.hearings,
  });

  factory CaseDataResponse.fromJson(Map<String, dynamic> json) =>
      _$CaseDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CaseDataResponseToJson(this);
}

@JsonSerializable()
class CaseListResponse {
  final List<CaseDataResponse> data;
  final String message;
  final int status;

  CaseListResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  factory CaseListResponse.fromJson(Map<String, dynamic> json) =>
      _$CaseListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CaseListResponseToJson(this);
}
