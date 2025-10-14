import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductApi {
  static const _base = 'https://dummyjson.com';

  Future<Map<String, dynamic>> fetchProducts({
    int limit = 30,
    int skip = 0,
  }) async {
    final uri = Uri.parse('$_base/products?limit=$limit&skip=$skip');
    final res = await http.get(uri);
    if (res.statusCode != 200) {
      throw Exception('Failed to load products (${res.statusCode})');
    }
    return jsonDecode(res.body) as Map<String, dynamic>;
  }
}
