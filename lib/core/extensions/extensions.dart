import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../features/product/data/models/product.dart';
import '../../generated/l10n.dart';
import '../strings/enum_manager.dart';
import '../util/snack_bar_message.dart';

extension SplitByLength on String {
  List<String> splitByLength1(int length, {bool ignoreEmpty = false}) {
    List<String> pieces = [];

    for (int i = 0; i < this.length; i += length) {
      int offset = i + length;
      String piece = substring(i, offset >= this.length ? this.length : offset);

      if (ignoreEmpty) {
        piece = piece.replaceAll(RegExp(r'\s+'), '');
      }

      pieces.add(piece);
    }
    return pieces;
  }

  bool get canSendToSearch {
    if (isEmpty) false;

    return split(' ').last.length > 2;
  }

  int get numberOnly {
    final regex = RegExp(r'\d+');

    final numbers = regex.allMatches(this).map((match) => match.group(0)).join();

    try {
      return int.parse(numbers);
    } on Exception {
      return 0;
    }
  }
}

extension FixMobile on String {
  String fixPhone() {
    if (startsWith('0')) return this;

    return '0$this';
  }

  String? checkPhoneNumber(BuildContext context, String phone) {
    if (phone.startsWith('00964') && phone.length > 11) return phone;
    if (phone.length < 10) {
      NoteMessage.showSnakeBar(context: context, message: S.of(context).wrongPhone);
      return null;
    } else if (phone.startsWith("0") && phone.length < 11) {
      NoteMessage.showSnakeBar(context: context, message: S.of(context).wrongPhone);
      return null;
    }

    if (phone.length > 10 && phone.startsWith("0")) phone = phone.substring(1);

    phone = '00964$phone';

    return phone;
  }
}
final oCcy = NumberFormat("#,##", "en_US");
extension MaxInt on num {
  int get max => 2147483647;


  String get formatPrice => 'IQD ${oCcy.format(this)}';
}

extension UpdateTypeHelper on UpdateType {
  String get getName {
    switch (this) {
      case UpdateType.name:
        return 'تغيير الاسم';
      case UpdateType.phone:
        return 'تغير رقم الهاتف';
      case UpdateType.address:
        return 'تغير العنوان';
      case UpdateType.pass:
        return 'تغير كلمه المرور';
    }
  }
}

extension ProductHelper on Product {
  bool get isOffer => offer != 0;

  String get getOfferPrice => isOffer
      ? (isPercentage)
          ? _getPricePercentage.formatPrice
          : _getOfferPrice.formatPrice
      : getPrice;

  num get getOfferPriceNum => isOffer
      ? (isPercentage)
          ? _getPricePercentage
          : _getOfferPrice
      : getPriceNun;

  num get getPriceNun => price;

  String get getPrice => price.formatPrice;

  bool get isPercentage => offerType.contains('نسبة');

  num get _getPricePercentage => (price - (price * (offer) / 100)).roundToDouble();

  num get _getOfferPrice => (price - (offer)).roundToDouble();
}

extension ResponseHelper on http.Response {
  Map<String, dynamic> get jsonBody => jsonDecode(body);
}

extension CubitStatusesHelper on CubitStatuses {
  bool get loading => this == CubitStatuses.loading;

  bool get done => this == CubitStatuses.done;
}

extension FormatDuration on Duration {
  String get format =>
      '${inMinutes.remainder(60).toString().padLeft(2, '0')}:${(inSeconds.remainder(60)).toString().padLeft(2, '0')}';
}

extension ApiStatusCode on int {
  bool get success => (this >= 200 && this <= 210);
}

extension DateUtcHelper on DateTime {
  int get hashDate => (day * 61) + (month * 83) + (year * 23);

  DateTime get getUtc => DateTime.utc(year, month, day);

  String get formatDate => DateFormat('yyyy/MM/dd').format(this);

  String get formatDateAther => DateFormat('yyyy/MM/dd HH:MM').format(this);

  String get formatTime => DateFormat('h:mm a').format(this);

  String get formatDateTime => '$formatTime $formatDate';


  DateTime addFromNow({int? year, int? month, int? day, int? hour}) {
    return DateTime(
      this.year + (year ?? 0),
      this.month + (month ?? 0),
      this.day + (day ?? 0),
      this.hour + (hour ?? 0),
    );
  }

  DateTime initialFromDateTime({required DateTime date, required TimeOfDay time}) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}

extension FirstItem<E> on Iterable<E> {
  E? get firstItem => isEmpty ? null : first;
}

extension GetDateTimesBetween on DateTime {
  List<DateTime> getDateTimesBetween({
    required DateTime end,
    required Duration period,
  }) {
    var dateTimes = <DateTime>[];
    var current = add(period);
    while (current.isBefore(end)) {
      if (dateTimes.length > 24) {
        break;
      }
      dateTimes.add(current);
      current = current.add(period);
    }
    return dateTimes;
  }
}

// /// Returns a list of [DateTime]s between (but not including) [start] and
// /// [end], spaced by [period] intervals.
// List<DateTime> getDateTimesBetween1({
//   required DateTime start,
//   required DateTime end,
//   required Duration period,
// }) {
//   var dateTimes = <DateTime>[];
//   var current = start.add(period);
//   while (current.isBefore(end)) {
//     dateTimes.add(current);
//     current = current.add(period);
//   }
//   return dateTimes;
// }
