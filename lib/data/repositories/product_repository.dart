import 'package:product_list_app/data/models/product_model.dart';
import 'package:product_list_app/data/services/product_api.dart';

class ProductRepository {
  final ProductApi api;
  ProductRepository(this.api);

  Future<List<ProductModel>> getAll() async {
    final root = await api.fetchProducts(limit: 30, skip: 0);
    final list = (root['products'] as List)
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return list;
  }
}
