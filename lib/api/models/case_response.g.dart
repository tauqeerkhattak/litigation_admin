// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaseDocument _$CaseDocumentFromJson(Map<String, dynamic> json) => CaseDocument(
  id: json['id'] as String,
  type: $enumDecode(_$DocumentTypeEnumMap, json['type']),
  name: json['name'] as String?,
  url: json['url'] as String?,
  uploadedAt: json['uploaded_at'] as String?,
);

Map<String, dynamic> _$CaseDocumentToJson(CaseDocument instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$DocumentTypeEnumMap[instance.type]!,
      'name': instance.name,
      'url': instance.url,
      'uploaded_at': instance.uploadedAt,
    };

const _$DocumentTypeEnumMap = {
  DocumentType.plaint: 'plaint',
  DocumentType.parawiseComments: 'parawiseComments',
  DocumentType.writtenStatement: 'writtenStatement',
  DocumentType.complianceReport: 'complianceReport',
  DocumentType.orderSheet: 'orderSheet',
  DocumentType.judgement: 'judgement',
  DocumentType.other: 'other',
};

CaseHearing _$CaseHearingFromJson(Map<String, dynamic> json) => CaseHearing(
  id: json['id'] as String?,
  caseId: json['case_id'] as String?,
  date: json['date'] as String?,
  submitted: json['submitted'] as String,
  happened: json['happened'] as String,
  order: json['order'] as String,
  nextDate: json['next_date'] as String?,
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
      id: json['id'] as String?,
      userId: json['user_id'] as String?,
      caseNo: json['case_no'] as String?,
      year: (json['year'] as num?)?.toInt(),
      court: $enumDecodeNullable(_$CourtEnumMap, json['court']),
      bench: $enumDecodeNullable(_$BenchEnumMap, json['bench']),
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
      status: $enumDecode(_$CaseStatusEnumMap, json['status']),
      notes: json['notes'] as String,
      caseNature: $enumDecodeNullable(_$CaseNatureEnumMap, json['case_nature']),
      department: $enumDecodeNullable(_$DepartmentEnumMap, json['department']),
      taluka: $enumDecodeNullable(_$TalukaEnumMap, json['taluka']),
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
      'court': _$CourtEnumMap[instance.court],
      'bench': _$BenchEnumMap[instance.bench],
      'title': instance.title,
      'plaintiffs': instance.plaintiffs,
      'respondents': instance.respondents,
      'first_hearing': instance.firstHearing,
      'last_hearing': instance.lastHearing,
      'next_hearing': instance.nextHearing,
      'status': _$CaseStatusEnumMap[instance.status]!,
      'notes': instance.notes,
      'case_nature': _$CaseNatureEnumMap[instance.caseNature],
      'department': _$DepartmentEnumMap[instance.department],
      'taluka': _$TalukaEnumMap[instance.taluka],
      'documents': instance.documents,
      'hearings': instance.hearings,
    };

const _$CourtEnumMap = {
  Court.highCourt: 'highCourt',
  Court.civilCourt: 'civilCourt',
  Court.sessionsCourt: 'sessionsCourt',
  Court.antiCorruptionCourt: 'antiCorruptionCourt',
  Court.serviceTribunal: 'serviceTribunal',
  Court.federalShariatCourt: 'federalShariatCourt',
  Court.supremeCourt: 'supremeCourt',
  Court.other: 'other',
};

const _$BenchEnumMap = {
  Bench.singleBench: 'singleBench',
  Bench.divisionBench: 'divisionBench',
  Bench.fullBench: 'fullBench',
};

const _$CaseStatusEnumMap = {
  CaseStatus.active: 'active',
  CaseStatus.stayGranted: 'stayGranted',
  CaseStatus.decided: 'decided',
  CaseStatus.dismissed: 'dismissed',
};

const _$CaseNatureEnumMap = {
  CaseNature.revenue: 'revenue',
  CaseNature.generalRecruitment: 'generalRecruitment',
  CaseNature.disabledQuota: 'disabledQuota',
  CaseNature.generalAdministration: 'generalAdministration',
  CaseNature.serviceMatter: 'serviceMatter',
  CaseNature.contemptCase: 'contemptCase',
  CaseNature.other: 'other',
};

const _$DepartmentEnumMap = {
  Department.educationLiteracy: 'educationLiteracy',
  Department.health: 'health',
  Department.irrigation: 'irrigation',
  Department.agriculture: 'agriculture',
  Department.revenue: 'revenue',
  Department.policeHome: 'policeHome',
  Department.localGovernment: 'localGovernment',
  Department.worksServices: 'worksServices',
  Department.socialWelfare: 'socialWelfare',
  Department.other: 'other',
};

const _$TalukaEnumMap = {
  Taluka.sukkurCity: 'sukkurCity',
  Taluka.newSukkur: 'newSukkur',
  Taluka.rohri: 'rohri',
  Taluka.panoAqil: 'panoAqil',
  Taluka.salehPat: 'salehPat',
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
