import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/case_model.dart';
import '../utils/constants.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<CaseData>> _events = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMockEvents();
  }

  void _loadMockEvents() {
    final now = DateTime.now();
    final Map<DateTime, List<CaseData>> newEvents = {
      DateTime(now.year, now.month, now.day): [
        CaseData(
          id: '1',
          title: 'State vs. Anderson',
          caseNumber: 'CR-2023-001',
          clientName: 'Alice Anderson',
          status: 'In Progress',
          hearingDate: DateTime(now.year, now.month, now.day, 10, 30),
          description: 'Criminal defense case regarding alleged trespassing.',
        ),
      ],
      DateTime(now.year, now.month, now.day).add(const Duration(days: 2)): [
        CaseData(
          id: '2',
          title: 'Miller Marriage Dissolution',
          caseNumber: 'FAM-2023-045',
          clientName: 'Robert Miller',
          status: 'Pending',
          hearingDate: DateTime(now.year, now.month, now.day + 2, 14, 0),
          description: 'Divorce proceedings and asset division.',
        ),
      ],
      DateTime(
        now.year,
        now.month,
        now.day,
      ).subtract(const Duration(days: 1)): [
        CaseData(
          id: '3',
          title: 'TechCorp Patent Dispute',
          caseNumber: 'CIV-2023-112',
          clientName: 'TechCorp Solutions',
          status: 'Closed',
          hearingDate: DateTime(now.year, now.month, now.day - 1, 09, 0),
          description: 'Intellectual property litigation.',
        ),
      ],
    };

    setState(() {
      _events = newEvents;
      _isLoading = false;
    });
  }

  List<CaseData> _getEventsForDay(DateTime day) {
    final date = DateTime(day.year, day.month, day.day);
    return _events[date] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Case Calendar')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  eventLoader: _getEventsForDay,
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: AppColors.goldLight,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: AppColors.navy,
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: BoxDecoration(
                      color: AppColors.gold,
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: _selectedDay == null
                      ? const Center(child: Text('Select a day to see cases'))
                      : _buildEventList(_getEventsForDay(_selectedDay!)),
                ),
              ],
            ),
    );
  }

  Widget _buildEventList(List<CaseData> events) {
    if (events.isEmpty) {
      return const Center(child: Text('No cases scheduled for this day'));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final caseItem = events[index];
        return Card(
          child: ListTile(
            title: Text(
              caseItem.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Case #: ${caseItem.caseNumber}'),
            trailing: Text(
              DateFormat('hh:mm a').format(caseItem.hearingDate),
              style: const TextStyle(
                color: AppColors.gold,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
