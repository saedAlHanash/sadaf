import 'package:equatable/equatable.dart';

import '../api_manager/request_models/command.dart';
import '../strings/enum_manager.dart';

abstract class AbstractCubit<T> extends Equatable {
  final CubitStatuses statuses;
  final String error;
  final T result;
  final Command command;

  const AbstractCubit({
    this.statuses = CubitStatuses.init,
    this.error = '',
    this.command = commandInitial,
    required this.result,
  });
}

abstract class AbstractMeta {
  final Meta meta;

  AbstractMeta({
    required this.meta,
  });
}
