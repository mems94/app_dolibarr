import 'package:app_dolibarr/services/product_service.dart';
import 'package:stacked/stacked.dart';

class ProductViewModel extends BaseViewModel {
  ProductService _productService = ProductService();
  String _ref;
  String _label;
  String _price;

  String get ref => _ref;
  String get label => _label;
  String get price => _price;

  void setRef(String value) {
    _ref = value;
  }

  void setLabel(String value) {
    _label = value;
  }

  void setPrice(String value) {
    _price = price;
  }

  void saveProduct() {
    _productService.saveProduct(_label, _ref, _price);
  }
}
