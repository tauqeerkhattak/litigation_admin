import 'package:control_room/control_room.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../api/models/case_response.dart';
import '../controllers/case_controller.dart';
import '../utils/constants.dart';
import 'case_detail_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ControlRoom.get<CaseController>(context).fetchCases();
    });
  }

  Map<DateTime, List<CaseDataResponse>> _groupCasesByDate(
    List<CaseDataResponse> cases,
  ) {
    final Map<DateTime, List<CaseDataResponse>> events = {};
    for (var caseItem in cases) {
      if (caseItem.nextHearing != null) {
        try {
          final date = DateTime.parse(caseItem.nextHearing!);
          final day = DateTime(date.year, date.month, date.day);
          if (events[day] == null) events[day] = [];
          events[day]!.add(caseItem);
        } catch (_) {
          // Skip invalid dates
        }
      }
    }
    return events;
  }

  List<CaseDataResponse> _getEventsForDay(
    DateTime day,
    Map<DateTime, List<CaseDataResponse>> events,
  ) {
    final date = DateTime(day.year, day.month, day.day);
    return events[date] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return StateListener<CaseController, CaseState>(
      builder: (context, state) {
        final events = _groupCasesByDate(state.cases);

        return Scaffold(
          appBar: AppBar(title: const Text('Case Calendar')),
          body: state.isLoading && state.cases.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    TableCalendar<CaseDataResponse>(
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
                      eventLoader: (day) => _getEventsForDay(day, events),
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
                          ? const Center(
                              child: Text('Select a day to see cases'),
                            )
                          : _buildEventList(
                              _getEventsForDay(_selectedDay!, events),
                            ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildEventList(List<CaseDataResponse> events) {
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CaseDetailScreen(caseData: caseItem),
                ),
              ).then((_) {
                if (mounted) {
                  ControlRoom.get<CaseController>(context).fetchCases();
                }
              });
            },
            title: Text(
              caseItem.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Case #: ${caseItem.caseNo ?? 'N/A'}'),
            trailing: Text(
              caseItem.nextHearing != null
                  ? DateFormat(
                      'hh:mm a',
                    ).format(DateTime.parse(caseItem.nextHearing!))
                  : '',
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
