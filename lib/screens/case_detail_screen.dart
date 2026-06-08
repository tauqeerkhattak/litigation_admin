import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/case_model.dart';
import '../utils/constants.dart';

class CaseDetailScreen extends StatefulWidget {
  final CaseData caseData;

  const CaseDetailScreen({super.key, required this.caseData});

  @override
  State<CaseDetailScreen> createState() => _CaseDetailScreenState();
}

class _CaseDetailScreenState extends State<CaseDetailScreen> {
  late TextEditingController _titleController;
  late TextEditingController _clientController;
  late TextEditingController _descriptionController;
  late String _status;
  late DateTime _hearingDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.caseData.title);
    _clientController = TextEditingController(text: widget.caseData.clientName);
    _descriptionController = TextEditingController(
      text: widget.caseData.description,
    );
    _status = widget.caseData.status;
    _hearingDate = widget.caseData.hearingDate;
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

  void _saveCase() {
    // In UI-only version, we update the local object
    widget.caseData.title = _titleController.text;
    widget.caseData.clientName = _clientController.text;
    widget.caseData.hearingDate = _hearingDate;
    widget.caseData.status = _status;
    widget.caseData.description = _descriptionController.text;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Case updated successfully (UI Only)')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Case Details'),
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: _saveCase),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Case ID: ${widget.caseData.caseNumber}',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.muted,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Case Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _clientController,
              decoration: const InputDecoration(
                labelText: 'Client Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _status,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(),
                    ),
                    items: ['Pending', 'In Progress', 'Closed']
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) setState(() => _status = value);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: () => _selectDate(context),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Hearing Date',
                        border: OutlineInputBorder(),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(DateFormat('MMM dd, yyyy').format(_hearingDate)),
                          const Icon(Icons.calendar_today, size: 18),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveCase,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.navy,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
