import 'package:app_dolibarr/services/product_service.dart';
import 'package:stacked/stacked.dart';

class ProductViewModel extends BaseViewModel {
  ProductService _productService = ProductService();
  String _ref;
  String _label;

  String get ref => _ref;
  String get label => _label;

  void setRef(String value) {
    _ref = value;
  }

  void setLabel(String value) {
    _label = value;
  }

  void saveProduct() {
    _productService.saveProduct(_label, _ref);
  }
}
