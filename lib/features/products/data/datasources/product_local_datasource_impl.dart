import 'package:hive/hive.dart';
import 'package:bizniz_tracker/features/products/domain/product.dart';
import 'product_local_datasource.dart';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final Box<ProductModel> productsBox;

  ProductLocalDataSourceImpl({required this.productsBox});

  @override
  Future<ProductModel> addProduct(ProductModel product) async {
    // store by id so we can lookup/delete by id
    await productsBox.put(product.id, product);
    return product;
  }

  @override
  Future<bool> deleteProduct(String id) async {
    await productsBox.delete(id);
    return true;
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    return productsBox.values.cast<ProductModel>().toList();
  }

  @override
  Future<ProductModel?> getProductById(String id) async {
    return productsBox.get(id);
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    await productsBox.put(product.id, product);
    return product;
  }
}
