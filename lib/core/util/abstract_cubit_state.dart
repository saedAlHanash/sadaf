import 'package:equatable/equatable.dart';

import '../strings/enum_manager.dart';

abstract class AbstractCubit<T> extends Equatable {
  final CubitStatuses statuses;
  final String error;
  final T result;

  const AbstractCubit({
    this.statuses = CubitStatuses.init,
    this.error = '',
    required this.result,
  });

}
