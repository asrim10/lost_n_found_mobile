import 'package:lost_n_found/features/batch/data/models/category_hive_model.dart';

abstract interface class ICatregoryDataSource {
  Future<List<CategoryHiveModel>> getAllCategory();
  Future<CategoryHiveModel?> getCategoryById(String categoryId);
  Future<bool> createCategory(CategoryHiveModel category);
  Future<bool> updateCategory(CategoryHiveModel category);
  Future<bool> deleteCategory(String categoryId);
}
