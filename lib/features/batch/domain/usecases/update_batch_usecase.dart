import 'package:either_dart/src/either.dart';
import 'package:equatable/equatable.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/core/usecases/app_usecase.dart';
import 'package:lost_n_found/features/batch/domain/entities/batch_entity.dart';
import 'package:lost_n_found/features/batch/domain/repositories/batch_repository.dart';

class UpdateBatchUsecaseParams extends Equatable {
  final String batchId;
  final String batchName;
  final String status;

  const UpdateBatchUsecaseParams({
    required this.batchId,
    required this.batchName,
    required this.status,
  });

  @override
  List<Object?> get props => [batchId];
}

class UpdateBatchUsecase
    implements UsecaseWithParams<bool, UpdateBatchUsecase> {
  final IBatchRepository _batchRepository;
  UpdateBatchUsecase(this._batchRepository);

  @override
  Future<Either<Failures, bool>> call(UpdateBatchUsecaseParams params) {
    final batch = BatchEntity(
      batchName: params.batchName,
      batchId: params.batchId,
      status: params.status,
    );
    return _batchRepository.updateBatch(batch);
  }
}
