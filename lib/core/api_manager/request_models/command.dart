import 'package:sadaf/core/extensions/extensions.dart';

class Command {
  Command({
    this.pag,
    this.perPage,
    this.minimal,
  });

  int? pag;
  int? perPage;
  int? minimal;

  factory Command.initial() {
    return Command(pag: 1, perPage: 10);
  }

  factory Command.noPagination() {
    return Command(perPage: 1.max, pag: 1);
  }

  factory Command.minimal() {
    return Command(perPage: 1.max, pag: 1, minimal: 1);
  }

  Map<String, dynamic> toJson() {
    return {
      'page': pag,
      'perPage': perPage,
      'Minimal': minimal,
    };
  }

  factory Command.fromJson(Map<String, dynamic> map) {
    return Command(
      pag: map['pag'] ?? 1,
      perPage: map['perPage'] ?? 15,
    );
  }
}
