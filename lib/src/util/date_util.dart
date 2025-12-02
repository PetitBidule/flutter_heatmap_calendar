class DateUtil {
  static const int DAYS_IN_WEEK = 7;

  static const List<String> MONTH_LABEL = [
    '',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static const List<String> SHORT_MONTH_LABEL = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static const List<String> WEEK_LABEL = [
    '',
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  /// Get start day of month.
  static DateTime startDayOfMonth(final DateTime referenceDate) =>
      DateTime(referenceDate.year, referenceDate.month, 1);

  /// Get last day of month.
  static DateTime endDayOfMonth(final DateTime referenceDate) =>
      DateTime(referenceDate.year, referenceDate.month + 1, 0);

  /// Get exactly one year before of [referenceDate].
  static DateTime oneYearBefore(final DateTime referenceDate) =>
      DateTime(referenceDate.year - 1, referenceDate.month, referenceDate.day);

  /// Separate [referenceDate]'s month to a fixed list of 7 weeks.
  /// This ensures consistent layout regardless of month length.
  /// [startWeekDay] determines the first day of the week (1=Monday, 7=Sunday).
  static List<Map<DateTime, DateTime>> separatedMonthFixed(
      final DateTime referenceDate, final int startWeekDay) {
    DateTime startDate = startDayOfMonth(referenceDate);
    int dayOffset = (startDate.weekday - startWeekDay + 7) % 7;
    DateTime endDate = DateTime(startDate.year, startDate.month,
        startDate.day + DAYS_IN_WEEK - dayOffset - 1);
    List<Map<DateTime, DateTime>> savedMonth = [];

    // Always create exactly 6 weeks for every month.
    for (int i = 0; i < 6; i++) {
      savedMonth.add({startDate: endDate});
      startDate = changeDay(endDate, 1);
      endDate = changeDay(endDate, DAYS_IN_WEEK);
    }
    return savedMonth;
  }

  /// Returns the offset of a weekday relative to the start of the week.
  static int weekdayOffset(int weekday, int startWeekDay) {
    return (weekday - startWeekDay + 7) % 7;
  }

  /// Returns the week labels reordered based on [startWeekDay].
  static List<String> getOrderedWeekLabels(int startWeekDay) {
    // WEEK_LABEL: ['', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
    // Mapping: index 1 = Sunday (weekday 7), index 2 = Monday (weekday 1), etc.
    List<String> orderedLabels = [];
    for (int i = 0; i < 7; i++) {
      int weekday = (startWeekDay + i - 1) % 7 + 1;
      // Convert weekday to WEEK_LABEL index: Sunday(7)->1, Monday(1)->2, etc.
      int labelIndex = weekday == 7 ? 1 : weekday + 1;
      orderedLabels.add(WEEK_LABEL[labelIndex]);
    }
    return orderedLabels;
  }

  /// Change day of [referenceDate].
  static DateTime changeDay(final DateTime referenceDate, final int dayCount) =>
      DateTime(referenceDate.year, referenceDate.month,
          referenceDate.day + dayCount);

  /// Change month of [referenceDate].
  static DateTime changeMonth(final DateTime referenceDate, int monthCount) =>
      DateTime(referenceDate.year, referenceDate.month + monthCount,
          referenceDate.day);
}
