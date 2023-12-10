part of 'select_option_cubit.dart';

class SelectOptionInitial extends Equatable {
  final String selectedSize;

  final String selectedColor;

  final String image;

  final int selectedProductId;

  final Product product;

  const SelectOptionInitial({
    required this.selectedSize,
    required this.selectedColor,
    required this.image,
    required this.selectedProductId,
    required this.product,
  });

  factory SelectOptionInitial.initial() {
    return SelectOptionInitial(
      selectedSize: '',
      selectedColor: '',
      image: '',
      selectedProductId: 0,
      product: Product.fromJson({}),
    );
  }

  @override
  List<Object> get props => [selectedSize, selectedColor,selectedProductId,product];

  SelectOptionInitial copyWith({
    String? selectedSize,
    String? selectedColor,
    String? image,
    int? selectedProductId,
    Product? product,
  }) {
    return SelectOptionInitial(
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
      image: image ?? this.image,
      selectedProductId: selectedProductId ?? this.selectedProductId,
      product: product ?? this.product,
    );
  }
}
