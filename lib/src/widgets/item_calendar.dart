import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/utils/utils.dart';
import 'package:table_calendar/table_calendar.dart';

class ItemCalendar extends StatelessWidget {
  final double h;
  final double w;
  final DateTime selectedDay;
  final Function(DateTime dateTime1,DateTime dateTime2) onSelectedDay;
  final Function(DateTime day) change;

  const ItemCalendar({
    Key? key,
    required this.h,
    required this.w,
    required this.selectedDay,
    required this.onSelectedDay,
    required this.change,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 8 * w, vertical: 16 * h),
      padding: EdgeInsets.symmetric(horizontal: 8 * w, vertical: 8 * h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(21 * h),
        color: AppTheme.lightGray,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16 * w, vertical: 32 * h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(21),
          color: AppTheme.white,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 12 * h,
                ),
                GestureDetector(
                  onTap: () {
                    change(DateTime.now().isBefore(DateTime(selectedDay.year,
                            selectedDay.month - 1, selectedDay.day))
                        ? DateTime(selectedDay.year, selectedDay.month - 1,
                            selectedDay.day)
                        : DateTime.now());
                  },
                  child: SizedBox(
                    height: 24 * h,
                    width: 24 * w,
                    child: const Icon(
                      Icons.navigate_before,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  "${getMonth(selectedDay.month)} ${selectedDay.year} г.",
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 18 * h,
                    height: 21 / 18 * h,
                    letterSpacing: 0.4,
                    color: AppTheme.black,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    change(selectedDay.add(
                      const Duration(days: 30),
                    ));
                  },
                  child: SizedBox(
                    height: 24 * h,
                    width: 24 * w,
                    child: const Icon(
                      Icons.navigate_next,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8 * h,
            ),
            TableCalendar(
              daysOfWeekVisible: false,
              headerVisible: false,
              rowHeight: 32,
              onPageChanged: (day) {
                change(DateTime.now().isBefore(day) ? day : DateTime.now());
              },
              selectedDayPredicate: (day) => isSameDay(selectedDay, day),
              focusedDay: selectedDay,
              onDaySelected: onSelectedDay,
              firstDay: DateTime(2021, 12, 12),
              lastDay: DateTime(2099, 12, 21),
              calendarStyle: CalendarStyle(
                cellMargin: const EdgeInsets.all(4),
                todayDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.blue.withOpacity(0.4),
                ),
                selectedDecoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
