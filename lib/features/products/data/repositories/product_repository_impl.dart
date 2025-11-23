import 'package:dartz/dartz.dart';
import 'package:bizniz_tracker/core/failure.dart';
import 'package:bizniz_tracker/features/products/domain/product.dart';
import 'package:bizniz_tracker/features/products/domain/repositories.dart';
import 'package:bizniz_tracker/features/products/data/datasources/product_local_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource local;

  ProductRepositoryImpl({required this.local});

  @override
  Future<Either<Failure, ProductModel>> addProduct(ProductModel product) async {
    try {
      final added = await local.addProduct(product);
      return Right(added);
    } catch (e) {
      return Left(Failure('Failed to add product: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteProduct(String id) async {
    try {
      final deleted = await local.deleteProduct(id);
      return Right(deleted);
    } catch (e) {
      return Left(Failure('Failed to delete product: $e'));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getAllProducts() async {
    try {
      final list = await local.getAllProducts();
      return Right(list);
    } catch (e) {
      return Left(Failure('Failed to fetch products: $e'));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> getProductById(String id) async {
    try {
      final item = await local.getProductById(id);
      if (item == null) return Left(Failure('Product not found'));
      return Right(item);
    } catch (e) {
      return Left(Failure('Failed to get product: $e'));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> updateProduct(
    ProductModel product,
  ) async {
    try {
      final updated = await local.updateProduct(product);
      return Right(updated);
    } catch (e) {
      return Left(Failure('Failed to update product: $e'));
    }
  }
}
