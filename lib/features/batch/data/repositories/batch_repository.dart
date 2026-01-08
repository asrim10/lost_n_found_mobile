import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/features/batch/data/datasources/batch_datasource.dart';
import 'package:lost_n_found/features/batch/data/datasources/local/batch_local_datasource.dart';
import 'package:lost_n_found/features/batch/data/models/batch_hive_model.dart';
import 'package:lost_n_found/features/batch/domain/entities/batch_entity.dart';
import 'package:lost_n_found/features/batch/domain/repositories/batch_repository.dart';

final batchRepositoryProvider = Provider<IBatchRepository>((ref) {
  return BatchRepository(
    batchDatasource: ref.read(batchLocalDatasourceProvider),
  );
});

class BatchRepository implements IBatchRepository {
  final IBatchLocalDatasource _batchDatasource;

  BatchRepository({required IBatchLocalDatasource batchDatasource})
    : _batchDatasource = batchDatasource;

  @override
  Future<Either<Failures, bool>> createBatch(BatchEntity batch) async {
    try {
      // conversion
      // entity lai model ma convert gara
      final batchModel = BatchHiveModel.fromEntity(batch);
      final result = await _batchDatasource.createBatch(batchModel);
      if (result) {
        return const Right(true);
      }
      return const Left(
        LocalDatabaseFailure(message: "Failed to create a batch"),
      );
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, bool>> deleteBatch(String batchId) async {
    try {
      final result = await _batchDatasource.deleteBatch(batchId);
      if (result) {
        return Right(true);
      }

      return Left(LocalDatabaseFailure(message: ' Failed to delete batch'));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<BatchEntity>>> getAllBatches() async {
    try {
      final models = await _batchDatasource.getAllBatches();
      final entities = BatchHiveModel.toEntityList(models);
      return Right(entities);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, BatchEntity>> getBatchById(String batchId) async {
    try {
      final model = await _batchDatasource.getBatchById(batchId);
      if (model != null) {
        final entity = model.toEntity();
        return Right(entity);
      }
      return Left(LocalDatabaseFailure(message: 'Batch not found'));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, bool>> updateBatch(BatchEntity batch) async {
    try {
      final model = BatchHiveModel.fromEntity(batch);
      final result = await _batchDatasource.updateBatch(model);
      if (result) {
        return const Right(true);
      }
      return const Left(
        LocalDatabaseFailure(message: 'Failed to update batch'),
      );
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}
