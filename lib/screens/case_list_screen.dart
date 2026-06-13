import 'package:control_room/control_room.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controllers/case_controller.dart';
import '../utils/constants.dart';
import 'case_detail_screen.dart';

class CaseListScreen extends StatefulWidget {
  const CaseListScreen({super.key});

  @override
  State<CaseListScreen> createState() => _CaseListScreenState();
}

class _CaseListScreenState extends State<CaseListScreen> {
  String _searchQuery = '';
  CaseStatus? _selectedStatus;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ControlRoom.get<CaseController>(context).fetchCases();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StateListener<CaseController, CaseState>(
      builder: (context, state) {
        final filteredCases = state.cases.where((caseItem) {
          final matchesSearch =
              caseItem.title.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
              (caseItem.caseNo?.toLowerCase() ?? '').contains(
                _searchQuery.toLowerCase(),
              ) ||
              caseItem.plaintiffs.any(
                (p) => p.toLowerCase().contains(_searchQuery.toLowerCase()),
              );

          final matchesStatus =
              _selectedStatus == null || caseItem.status == _selectedStatus;

          return matchesSearch && matchesStatus;
        }).toList();

        return Scaffold(
          appBar: AppBar(title: const Text('All Cases')),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search cases...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    DropdownButton<CaseStatus?>(
                      value: _selectedStatus,
                      items: [null, ...CaseStatus.values]
                          .map(
                            (status) => DropdownMenuItem(
                              value: status,
                              child: Text(status?.displayName ?? 'All'),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedStatus = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: state.isLoading && state.cases.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : filteredCases.isEmpty
                    ? const Center(child: Text('No cases found.'))
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        itemCount: filteredCases.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final caseItem = filteredCases[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CaseDetailScreen(caseData: caseItem),
                                ),
                              ).then(
                                (_) => ControlRoom.get<CaseController>(
                                  context,
                                ).fetchCases(),
                              );
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            caseItem.title,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.navy,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _getStatusColor(
                                              caseItem.status,
                                            ).withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Text(
                                            caseItem.status.displayName,
                                            style: TextStyle(
                                              color: _getStatusColor(
                                                caseItem.status,
                                              ),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Case #: ${caseItem.caseNo}',
                                      style: const TextStyle(
                                        color: AppColors.muted,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Plaintiffs: ${caseItem.plaintiffs.join(', ')}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Divider(height: 24),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_today,
                                          size: 16,
                                          color: AppColors.gold,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          caseItem.nextHearing != null
                                              ? 'Next Hearing: ${DateFormat('MMM dd, yyyy').format(DateTime.parse(caseItem.nextHearing!))}'
                                              : 'No upcoming hearing',
                                          style: const TextStyle(
                                            color: AppColors.navyMid,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Add Case functionality (Coming Soon)'),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Color _getStatusColor(CaseStatus status) {
    switch (status) {
      case CaseStatus.active:
        return AppColors.gold;
      case CaseStatus.stayGranted:
        return Colors.blue;
      case CaseStatus.decided:
        return AppColors.green;
      case CaseStatus.dismissed:
        return Colors.red;
    }
  }
}
