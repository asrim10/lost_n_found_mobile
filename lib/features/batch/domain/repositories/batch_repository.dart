import 'package:either_dart/either.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/features/batch/domain/entities/batch_entity.dart';

abstract interface class IBatchRepository {
  Future<Either<Failures, List<BatchEntity>>> getAllBatches();
  Future<Either<Failures, List<BatchEntity>>> getBatchById(String batchId);
  Future<Either<Failures, bool>> createBatch(BatchEntity batch);
  Future<Either<Failures, bool>> updateBatch(BatchEntity batch);
  Future<Either<Failures, bool>> deleteBatch(String batchId);
}
