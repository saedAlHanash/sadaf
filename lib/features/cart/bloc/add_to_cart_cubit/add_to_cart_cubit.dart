import 'package:bloc/bloc.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartInitial> {
  AddToCartCubit() : super(AddToCartInitial.initial());

  void addToCart() {
    emit(state.copyWith(result: state.result + 1));
  }

  void goToCart(bool c) {
    emit(state.copyWith(goToCart: c));
  }
}
