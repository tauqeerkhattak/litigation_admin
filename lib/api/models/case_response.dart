import 'package:json_annotation/json_annotation.dart';

part 'case_response.g.dart';

@JsonSerializable()
class CaseDocument {
  final String id;
  final String type;
  final String name;
  final String url;
  @JsonKey(name: 'uploaded_at')
  final String uploadedAt;

  CaseDocument({
    required this.id,
    required this.type,
    required this.name,
    required this.url,
    required this.uploadedAt,
  });

  factory CaseDocument.fromJson(Map<String, dynamic> json) =>
      _$CaseDocumentFromJson(json);
  Map<String, dynamic> toJson() => _$CaseDocumentToJson(this);
}

@JsonSerializable()
class CaseHearing {
  final String id;
  @JsonKey(name: 'case_id')
  final String caseId;
  final String date;
  final String submitted;
  final String happened;
  final String order;
  @JsonKey(name: 'next_date')
  final String nextDate;

  CaseHearing({
    required this.id,
    required this.caseId,
    required this.date,
    required this.submitted,
    required this.happened,
    required this.order,
    required this.nextDate,
  });

  factory CaseHearing.fromJson(Map<String, dynamic> json) =>
      _$CaseHearingFromJson(json);
  Map<String, dynamic> toJson() => _$CaseHearingToJson(this);
}

@JsonSerializable()
class CaseDataResponse {
  final String id;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'case_no')
  final String caseNo;
  final int year;
  final String court;
  final String bench;
  final String title;
  final List<String> plaintiffs;
  final List<String> respondents;
  @JsonKey(name: 'first_hearing')
  final String? firstHearing;
  @JsonKey(name: 'last_hearing')
  final String? lastHearing;
  @JsonKey(name: 'next_hearing')
  final String? nextHearing;
  final String status;
  final String notes;
  @JsonKey(name: 'case_nature')
  final String? caseNature;
  final String? department;
  final String? taluka;
  final List<CaseDocument> documents;
  final List<CaseHearing> hearings;

  CaseDataResponse({
    required this.id,
    required this.userId,
    required this.caseNo,
    required this.year,
    required this.court,
    required this.bench,
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
