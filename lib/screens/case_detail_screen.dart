import 'package:control_room/control_room.dart';
import 'package:flutter/material.dart';

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
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _clientController;
  late TextEditingController _descriptionController;
  late String _status;
  late DateTime _hearingDate;

  @override
  void initState() {
    super.initState();
    _initFields();
  }

  void _initFields() {
    _titleController = TextEditingController(text: widget.caseData.title);
    _clientController = TextEditingController(text: widget.caseData.clientName);
    _descriptionController = TextEditingController(text: widget.caseData.notes);
    _status = widget.caseData.status;
    _hearingDate = widget.caseData.nextHearingDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _clientController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _hearingDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _hearingDate) {
      setState(() {
        _hearingDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StateListener<CaseController, CaseState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Case Details'),
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _initFields();
                  });
                },
              ),
            ],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Case ID: ${widget.caseData.caseNo ?? 'N/A'}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.muted,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _titleController,
                        enabled: false,
                        decoration: const InputDecoration(
                          labelText: 'Case Title',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter case title'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _clientController,
                        enabled: false,
                        decoration: const InputDecoration(
                          labelText: 'Client Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter client name'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _descriptionController,
                        enabled: false,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
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
}
