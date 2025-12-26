import 'package:either_dart/src/either.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/features/batch/domain/entities/batch_entity.dart';
import 'package:lost_n_found/features/batch/domain/repositories/batch_repository.dart';

class BatchRepository implements IBatchRepository {
  @override
  Future<Either<Failures, bool>> createBatch(BatchEntity batch) {
    // TODO: implement createBatch
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, bool>> deleteBatch(String batchId) {
    // TODO: implement deleteBatch
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, List<BatchEntity>>> getAllBatches() {
    // TODO: implement getAllBatches
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, List<BatchEntity>>> getBatchById(String batchId) {
    // TODO: implement getBatchById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, bool>> updateBatch(BatchEntity batch) {
    // TODO: implement updateBatch
    throw UnimplementedError();
  }
}
