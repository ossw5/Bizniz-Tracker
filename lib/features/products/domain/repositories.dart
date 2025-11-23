import 'package:dartz/dartz.dart';
import 'package:bizniz_tracker/core/failure.dart';
import 'package:bizniz_tracker/features/products/domain/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductModel>>> getAllProducts();
  Future<Either<Failure, ProductModel>> getProductById(String id);
  Future<Either<Failure, ProductModel>> addProduct(ProductModel product);
  Future<Either<Failure, ProductModel>> updateProduct(ProductModel product);
  Future<Either<Failure, bool>> deleteProduct(String id);
}
