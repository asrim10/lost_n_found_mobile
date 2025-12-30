import 'package:dartz/dartz.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/features/batch/data/datasources/category_datasource.dart';
import 'package:lost_n_found/features/batch/data/models/category_hive_model.dart';
import 'package:lost_n_found/features/batch/domain/entities/category_entity.dart';
import 'package:lost_n_found/features/batch/domain/repositories/category_repository.dart';

class CategoryRepository implements ICategoryRepository {
  final ICatregoryDataSource _categoryDataSource;

  CategoryRepository({required ICatregoryDataSource categoryDatasource})
    : _categoryDataSource = categoryDatasource;

  @override
  Future<Either<Failures, bool>> createCategory(CategoryEntity category) async {
    try {
      final categoryModel = CategoryHiveModel.fromEntity(category);
      final result = await _categoryDataSource.createCategory(categoryModel);
      if (result) {
        return const Right(true);
      }
      return const Left(
        LocalDatabaseFailure(message: "Failed to create a category"),
      );
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, bool>> deleteCategory(String categoryId) async {
    try {
      final result = await _categoryDataSource.deleteCategory(categoryId);
      if (result) {
        return Right(true);
      }
      return const Left(
        LocalDatabaseFailure(message: "Failed to delete category"),
      );
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<CategoryEntity>>> getAllCategory() async {
    try {
      final models = await _categoryDataSource.getAllCategory();
      final entities = CategoryHiveModel.toEntityList(models);
      return Right(entities);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, CategoryEntity>> getCategoryById(
    String categoryId,
  ) async {
    try {
      final model = await _categoryDataSource.getCategoryById(categoryId);
      if (model != null) {
        final entity = model.toEntity();
        return Right(entity);
      }
      return Left(LocalDatabaseFailure(message: 'Category not found'));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, bool>> updateCategory(CategoryEntity category) async {
    try {
      final model = CategoryHiveModel.fromEntity(category);
      final result = await _categoryDataSource.updateCategory(model);
      if (result) {
        return const Right(true);
      }
      return const Left(
        LocalDatabaseFailure(message: 'Failed to update category'),
      );
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}
