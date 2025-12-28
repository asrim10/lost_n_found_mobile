import 'package:either_dart/src/either.dart';
import 'package:equatable/equatable.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/core/usecases/app_usecase.dart';
import 'package:lost_n_found/features/batch/domain/repositories/batch_repository.dart';

class DeleteBatchUsecaseParams extends Equatable {
  final String batchId;

  const DeleteBatchUsecaseParams({required this.batchId});
  @override
  List<Object?> get props => [];
}

class DeleteBatchUsecase
    implements UsecaseWithParams<bool, DeleteBatchUsecaseParams> {
  final IBatchRepository _batchRepository;

  DeleteBatchUsecase(this._batchRepository);

  @override
  Future<Either<Failures, bool>> call(DeleteBatchUsecaseParams params) {
    return _batchRepository.deleteBatch(params.batchId);
  }
}
