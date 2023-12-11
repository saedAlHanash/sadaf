import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sadaf/features/product/data/response/products_response.dart';

part 'select_option_state.dart';

class SelectOptionCubit extends Cubit<SelectOptionInitial> {
  SelectOptionCubit() : super(SelectOptionInitial.initial());

  void selectSize(String size) {
    emit(state.copyWith(selectedSize: size));
  }

  void selectColor(int id, String image, Option option) {
    emit(state.copyWith(
      image: image,
      option: option,
      selectedProductId: id,
    ));
  }

  void setProduct(Product product) {
    emit(
      state.copyWith(
        image: product.thumbnail,
        selectedProductId: product.id,
        product: product,
      ),
    );
  }
}
