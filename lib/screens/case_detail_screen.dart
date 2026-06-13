import 'package:control_room/control_room.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/models/case_response.dart';
import '../controllers/case_controller.dart';
import '../utils/constants.dart';

class CaseDetailScreen extends StatefulWidget {
  final CaseDataResponse caseData;

  const CaseDetailScreen({super.key, required this.caseData});

  @override
  State<CaseDetailScreen> createState() => _CaseDetailScreenState();
}

class _CaseDetailScreenState extends State<CaseDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final caseData = widget.caseData;

    return StateListener<CaseController, CaseState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Case Details'),
            backgroundColor: AppColors.navy,
            foregroundColor: Colors.white,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(caseData),
                    const SizedBox(height: 16),
                    _buildSectionHeader('Basic Information'),
                    _buildDetailRow(
                      'Case No',
                      '${caseData.caseNo ?? 'N/A'} / ${caseData.year ?? 'N/A'}',
                    ),
                    _buildDetailRow('Court', caseData.court?.displayName),
                    _buildDetailRow('Bench', caseData.bench?.displayName),
                    _buildDetailRow('Nature', caseData.caseNature?.displayName),
                    _buildDetailRow(
                      'Department',
                      caseData.department?.displayName,
                    ),
                    _buildDetailRow('Taluka', caseData.taluka?.displayName),

                    _buildSectionHeader('Parties'),
                    _buildDetailRow(
                      'Plaintiffs',
                      caseData.plaintiffs.isEmpty
                          ? 'N/A'
                          : caseData.plaintiffs.join('\n'),
                    ),
                    _buildDetailRow(
                      'Respondents',
                      caseData.respondents.isEmpty
                          ? 'N/A'
                          : caseData.respondents.join('\n'),
                    ),

                    _buildSectionHeader('Hearings Schedule'),
                    _buildDetailRow('First Hearing', caseData.firstHearing),
                    _buildDetailRow('Last Hearing', caseData.lastHearing),
                    _buildDetailRow('Next Hearing', caseData.nextHearing),

                    _buildSectionHeader('Notes'),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.cream,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        caseData.notes.isEmpty
                            ? 'No notes available'
                            : caseData.notes,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.text,
                        ),
                      ),
                    ),

                    if (caseData.documents.isNotEmpty) ...[
                      _buildSectionHeader('Documents'),
                      ...caseData.documents.map(
                        (doc) => Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: const Icon(
                              Icons.description,
                              color: AppColors.gold,
                            ),
                            title: Text(doc.name ?? doc.type.displayName),
                            subtitle: Text(
                              'Uploaded: ${doc.uploadedAt ?? 'N/A'}',
                            ),
                            trailing: const Icon(Icons.open_in_new, size: 20),
                            onTap: () {
                              if (doc.url != null) {
                                launchUrl(Uri.parse(doc.url!));
                              }
                            },
                          ),
                        ),
                      ),
                    ],

                    if (caseData.hearings.isNotEmpty) ...[
                      _buildSectionHeader('Hearing History'),
                      ...caseData.hearings.map(
                        (hearing) => Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Hearing Date: ${hearing.date ?? 'N/A'}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.navy,
                                      ),
                                    ),
                                    if (hearing.nextDate != null)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.green.withValues(
                                            alpha: 0.1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: Text(
                                          'Next: ${hearing.nextDate}',
                                          style: const TextStyle(
                                            color: AppColors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const Divider(),
                                _buildHearingInfo('Happened', hearing.happened),
                                _buildHearingInfo('Order', hearing.order),
                                _buildHearingInfo(
                                  'Submitted',
                                  hearing.submitted,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 40),
                  ],
                ),
              ),
              if (state.isLoading)
                const Center(child: CircularProgressIndicator()),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(CaseDataResponse caseData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                caseData.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.navy,
                ),
              ),
            ),
            _buildStatusChip(caseData.status.displayName),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'System ID: ${caseData.id ?? 'N/A'}',
          style: const TextStyle(color: AppColors.muted, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildStatusChip(String status) {
    final bool isActive = status.toLowerCase() == 'active';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.green.withValues(alpha: 0.1)
            : AppColors.muted.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isActive ? AppColors.green : AppColors.muted),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: isActive ? AppColors.green : AppColors.muted,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.navyMid,
            ),
          ),
          const SizedBox(height: 4),
          const Divider(color: AppColors.gold, thickness: 2),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.muted,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value == null || value.isEmpty ? 'N/A' : value,
              style: const TextStyle(
                color: AppColors.text,
                fontSize: 16,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHearingInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.muted,
            ),
          ),
          Text(
            value.isEmpty ? 'N/A' : value,
            style: const TextStyle(fontSize: 14, color: AppColors.text),
          ),
        ],
      ),
    );
  }
}
