import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/case_model.dart';
import '../utils/constants.dart';
import 'case_detail_screen.dart';

class CaseListScreen extends StatefulWidget {
  const CaseListScreen({super.key});

  @override
  State<CaseListScreen> createState() => _CaseListScreenState();
}

class _CaseListScreenState extends State<CaseListScreen> {
  // Mock data for UI-only version
  final List<CaseData> _allCases = [
    CaseData(
      id: '1',
      title: 'State vs. Anderson',
      caseNumber: 'CR-2023-001',
      clientName: 'Alice Anderson',
      status: 'In Progress',
      hearingDate: DateTime.now().add(const Duration(days: 2)),
      description: 'Criminal defense case regarding alleged trespassing.',
    ),
    CaseData(
      id: '2',
      title: 'Miller Marriage Dissolution',
      caseNumber: 'FAM-2023-045',
      clientName: 'Robert Miller',
      status: 'Pending',
      hearingDate: DateTime.now().add(const Duration(days: 5)),
      description: 'Divorce proceedings and asset division.',
    ),
    CaseData(
      id: '3',
      title: 'TechCorp Patent Dispute',
      caseNumber: 'CIV-2023-112',
      clientName: 'TechCorp Solutions',
      status: 'Closed',
      hearingDate: DateTime.now().subtract(const Duration(days: 10)),
      description: 'Intellectual property litigation.',
    ),
  ];

  List<CaseData> _filteredCases = [];
  String _searchQuery = '';
  String _selectedStatus = 'All';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _filterCases();
  }

  void _filterCases() {
    setState(() {
      _filteredCases = _allCases.where((caseItem) {
        final matchesSearch =
            caseItem.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            caseItem.caseNumber.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            ) ||
            caseItem.clientName.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            );

        final matchesStatus =
            _selectedStatus == 'All' || caseItem.status == _selectedStatus;

        return matchesSearch && matchesStatus;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Cases')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
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
                            _searchQuery = value;
                            _filterCases();
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      DropdownButton<String>(
                        value: _selectedStatus,
                        items: ['All', 'Pending', 'In Progress', 'Closed']
                            .map(
                              (status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedStatus = value;
                              _filterCases();
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _filteredCases.isEmpty
                      ? const Center(child: Text('No cases found.'))
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          itemCount: _filteredCases.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final caseItem = _filteredCases[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CaseDetailScreen(caseData: caseItem),
                                  ),
                                ).then((_) => setState(() {}));
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              ).withAlpha(25),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              caseItem.status,
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
                                        'Case #: ${caseItem.caseNumber}',
                                        style: const TextStyle(
                                          color: AppColors.muted,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Client: ${caseItem.clientName}',
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
                                            'Hearing: ${DateFormat('MMM dd, yyyy').format(caseItem.hearingDate)}',
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
          // Add new case UI logic
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add Case functionality (UI Only)')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColors.gold;
      case 'in progress':
        return Colors.blue;
      case 'closed':
        return AppColors.green;
      default:
        return AppColors.muted;
    }
  }
}
