import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skeleton/core/theme/AppColors.dart';

class CalendarWidget extends StatefulWidget {
  static const String name = 'CalendarScreen';

  const CalendarWidget({super.key});
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime _selectedDate = DateTime.now();
  late DateTime _displayedMonth;

  @override
  void initState() {
    super.initState();
    _displayedMonth = DateTime(_selectedDate.year, _selectedDate.month);
  }

  void _onDaySelected(DateTime selectedDay) {
    setState(() {
      _selectedDate = selectedDay;
    });
  }

  void _moveMonth(int monthsToAdd) {
    setState(() {
      _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month + monthsToAdd);
      if (_selectedDate.year != _displayedMonth.year || _selectedDate.month != _displayedMonth.month) {
        _selectedDate = DateTime(_displayedMonth.year, _displayedMonth.month, 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryDarkColor, // 전체 배경색을 검은색으로
      child: SingleChildScrollView(
        child: SafeArea( // SafeArea 추가
          child: Padding( // Container 대신 Padding 사용
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildCalendar(),
                const SizedBox(height: 20),
                _buildEventList(),
                // 하단 여백 추가
                const SizedBox(height: kBottomNavigationBarHeight),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat('yyyy').format(_displayedMonth),
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const Row(
              children: [
                Icon(Icons.search, color: Colors.white, size: 20),
                SizedBox(width: 20),
                Icon(Icons.add, color: Colors.white, size: 20),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left, color: Colors.white),
              onPressed: () => _moveMonth(-1),
            ),
            Text(
              DateFormat('MMMM').format(_displayedMonth),
              style: const TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right, color: Colors.white),
              onPressed: () => _moveMonth(1),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCalendar() {
    final daysInMonth = DateTime(_displayedMonth.year, _displayedMonth.month + 1, 0).day;
    final firstDayOfMonth = DateTime(_displayedMonth.year, _displayedMonth.month, 1);
    final dayOfWeekOfFirstDay = firstDayOfMonth.weekday % 7;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT']
              .map((day) => Expanded(
            child: Center(
              child: Text(day, style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          ))
              .toList(),
        ),
        const SizedBox(height: 4),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1,
          ),
          itemCount: 42, // 6 weeks * 7 days
          itemBuilder: (context, index) {
            final dayNumber = index - dayOfWeekOfFirstDay + 1;
            if (dayNumber < 1 || dayNumber > daysInMonth) {
              return Container();
            }

            final currentDate = DateTime(_displayedMonth.year, _displayedMonth.month, dayNumber);
            final isSelected = currentDate.year == _selectedDate.year &&
                currentDate.month == _selectedDate.month &&
                currentDate.day == _selectedDate.day;
            final isSunday = currentDate.weekday == DateTime.sunday;
            final isSaturday = currentDate.weekday == DateTime.saturday;

            return GestureDetector(
              onTap: () => _onDaySelected(currentDate),
              behavior: HitTestBehavior.opaque,
              child: Container(
                alignment: Alignment.center,
                decoration: isSelected
                    ? const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                )
                    : null,
                child: Text(
                  '$dayNumber',
                  style: TextStyle(
                    color: isSunday
                        ? Colors.red
                        : isSaturday
                        ? Colors.blue
                        : isSelected
                        ? Colors.black
                        : Colors.white,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildEventList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat('EEEE, d MMMM').format(_selectedDate),
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
        Text(
          _selectedDate.day == DateTime.now().day &&
              _selectedDate.month == DateTime.now().month &&
              _selectedDate.year == DateTime.now().year
              ? 'Today'
              : '',
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildEventItem("Valentine's Day", "All Day", "New York, New York"),
        _buildEventItem("By Gifts", "10:30 AM", "Central Mall"),
        _buildEventItem("House Cleaning", "4:00 PM", "Home"),
        _buildEventItem("Romantic Dinner with Maria", "9:00 PM", "Black Pearl Restaurant"),
      ],
    );
  }

  Widget _buildEventItem(String title, String time, String location) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 14)),
              Text('$time • $location', style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}