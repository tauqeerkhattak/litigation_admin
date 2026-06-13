// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaseDocument _$CaseDocumentFromJson(Map<String, dynamic> json) => CaseDocument(
  id: json['id'] as String,
  type: json['type'] as String,
  name: json['name'] as String,
  url: json['url'] as String,
  uploadedAt: json['uploaded_at'] as String,
);

Map<String, dynamic> _$CaseDocumentToJson(CaseDocument instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'url': instance.url,
      'uploaded_at': instance.uploadedAt,
    };

CaseHearing _$CaseHearingFromJson(Map<String, dynamic> json) => CaseHearing(
  id: json['id'] as String,
  caseId: json['case_id'] as String,
  date: json['date'] as String,
  submitted: json['submitted'] as String,
  happened: json['happened'] as String,
  order: json['order'] as String,
  nextDate: json['next_date'] as String,
);

Map<String, dynamic> _$CaseHearingToJson(CaseHearing instance) =>
    <String, dynamic>{
      'id': instance.id,
      'case_id': instance.caseId,
      'date': instance.date,
      'submitted': instance.submitted,
      'happened': instance.happened,
      'order': instance.order,
      'next_date': instance.nextDate,
    };

CaseDataResponse _$CaseDataResponseFromJson(Map<String, dynamic> json) =>
    CaseDataResponse(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      caseNo: json['case_no'] as String,
      year: (json['year'] as num).toInt(),
      court: json['court'] as String,
      bench: json['bench'] as String,
      title: json['title'] as String,
      plaintiffs: (json['plaintiffs'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      respondents: (json['respondents'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      firstHearing: json['first_hearing'] as String?,
      lastHearing: json['last_hearing'] as String?,
      nextHearing: json['next_hearing'] as String?,
      status: json['status'] as String,
      notes: json['notes'] as String,
      caseNature: json['case_nature'] as String?,
      department: json['department'] as String?,
      taluka: json['taluka'] as String?,
      documents: (json['documents'] as List<dynamic>)
          .map((e) => CaseDocument.fromJson(e as Map<String, dynamic>))
          .toList(),
      hearings: (json['hearings'] as List<dynamic>)
          .map((e) => CaseHearing.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CaseDataResponseToJson(CaseDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'case_no': instance.caseNo,
      'year': instance.year,
      'court': instance.court,
      'bench': instance.bench,
      'title': instance.title,
      'plaintiffs': instance.plaintiffs,
      'respondents': instance.respondents,
      'first_hearing': instance.firstHearing,
      'last_hearing': instance.lastHearing,
      'next_hearing': instance.nextHearing,
      'status': instance.status,
      'notes': instance.notes,
      'case_nature': instance.caseNature,
      'department': instance.department,
      'taluka': instance.taluka,
      'documents': instance.documents,
      'hearings': instance.hearings,
    };

CaseListResponse _$CaseListResponseFromJson(Map<String, dynamic> json) =>
    CaseListResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => CaseDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String,
      status: (json['status'] as num).toInt(),
    );

Map<String, dynamic> _$CaseListResponseToJson(CaseListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'status': instance.status,
    };
