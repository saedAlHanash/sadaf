part of 'my_location_cubit.dart';

class MyLocationInitial {
  final LatLng result;
  final CubitStatuses state;
  final String name;
  final bool moveMap;

  const MyLocationInitial({
    required this.result,
    required this.name,
    required this.moveMap,
    required this.state,
  });

  factory MyLocationInitial.initial() {
    return MyLocationInitial(
      result: LatLng(0, 0),
      name: '',
      moveMap: false,
      state: CubitStatuses.init,
    );
  }

  MyLocationInitial copyWith({
    LatLng? result,
    CubitStatuses? state,
    String? name,
    bool? moveMap,
  }) {
    return MyLocationInitial(
      result: result ?? this.result,
      state: state ?? this.state,
      name: name ?? this.name,
      moveMap: moveMap ?? this.moveMap,
    );
  }
}
