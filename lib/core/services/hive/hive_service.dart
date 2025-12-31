import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:lost_n_found/core/constants/hive_table_constant.dart';
import 'package:lost_n_found/features/batch/data/models/batch_hive_model.dart';
import 'package:lost_n_found/features/batch/data/models/category_hive_model.dart';
import 'package:path_provider/path_provider.dart';

final hiveServiceProvider = Provider<HiveService>((ref) {
  return HiveService();
});

class HiveService {
  //Initialize Hive
  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/${HiveTableConstant.dbName}';
    Hive.init(path);
    _registerAdapters();
    await _openBoxes;
    await insertDummybatches();
  }

  Future<void> insertDummybatches() async {
    final box = await Hive.openBox<BatchHiveModel>(
      HiveTableConstant.batchTable,
    );
    if (box.isNotEmpty) {
      return;
    }

    final dummyBatches = [
      BatchHiveModel(batchName: '35-A'),
      BatchHiveModel(batchName: '35-B'),
      BatchHiveModel(batchName: '35-C'),
      BatchHiveModel(batchName: '35-D'),
      BatchHiveModel(batchName: '35-E'),
    ];
    for (var batch in dummyBatches) {
      await box.put(batch.batchId, batch);
    }
  }

  //Register all type adapters
  void _registerAdapters() {
    if (!Hive.isAdapterRegistered(HiveTableConstant.batchTypeId)) {
      Hive.registerAdapter(BatchHiveModelAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveTableConstant.categoryTypeId)) {
      Hive.registerAdapter(CategoryHiveModelAdapter());
    }
  }

  //Open all boxes
  Future<void> _openBoxes() async {
    await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchTable);
    await Hive.openBox<CategoryHiveModel>(HiveTableConstant.categoryTable);
  }

  //Delete all batches
  Future<void> deleteAllBatches() async {
    await _batchBox.clear();
  }

  //Delete all categories
  Future<void> deleteAllCategories() async {
    await _categoryBox.clear();
  }

  //close all boxes
  Future<void> close() async {
    await Hive.close();
  }

  // =============== Batch CRUD Operations ====================

  //Get batch box
  Box<BatchHiveModel> get _batchBox =>
      Hive.box<BatchHiveModel>(HiveTableConstant.batchTable);

  // Get category box
  Box<CategoryHiveModel> get _categoryBox =>
      Hive.box<CategoryHiveModel>(HiveTableConstant.categoryTable);

  // Create a new batch
  Future<BatchHiveModel> createBatch(BatchHiveModel batch) async {
    await _batchBox.put(batch.batchId, batch);
    return batch;
  }

  //Get all batches
  List<BatchHiveModel> getAllBatches() {
    return _batchBox.values.toList();
  }

  //Get batch by ID
  BatchHiveModel? getBatchById(String batchId) {
    return _batchBox.get(batchId);
  }

  //Update a batch
  Future<void> updateBatch(BatchHiveModel batch) async {
    await _batchBox.put(batch.batchId, batch);
  }

  //Delete a batch
  Future<void> deleteBatch(String batchId) async {
    await _batchBox.delete(batchId);
  }

  // =============== Category CRUD Operations ====================

  // Create a new category
  Future<CategoryHiveModel> createCategory(CategoryHiveModel category) async {
    await _categoryBox.put(category.categoryId, category);
    return category;
  }

  //Get all categories
  List<CategoryHiveModel> getAllCategories() {
    return _categoryBox.values.toList();
  }

  //Get category by ID
  CategoryHiveModel? getCategoryById(String categoryId) {
    return _categoryBox.get(categoryId);
  }

  //Update a category
  Future<void> updateCategory(CategoryHiveModel category) async {
    await _categoryBox.put(category.categoryId, category);
  }

  //Delete a category
  Future<void> deleteCategory(String categoryId) async {
    await _categoryBox.delete(categoryId);
  }
}
