import 'package:dartz/dartz.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/features/batch/domain/entities/category_entity.dart';

abstract interface class ICategoryRepository {
  Future<Either<Failures, List<CategoryEntity>>> getAllCategory();
  Future<Either<Failures, CategoryEntity>> getCategoryById(String categoryId);
  Future<Either<Failures, bool>> createCategory(CategoryEntity category);
  Future<Either<Failures, bool>> updateCategory(CategoryEntity category);
  Future<Either<Failures, bool>> deleteCategory(String category);
}
