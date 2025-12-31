import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_n_found/features/batch/domain/usecases/create_batch_usecase.dart';
import 'package:lost_n_found/features/batch/domain/usecases/delete_batch_usecase.dart';
import 'package:lost_n_found/features/batch/domain/usecases/get_all_batch_usecase.dart';
import 'package:lost_n_found/features/batch/domain/usecases/update_batch_usecase.dart';
import 'package:lost_n_found/features/batch/presentation/state/batch_state.dart';

final batchViewModelProvider = NotifierProvider<BatchViewmodel, BatchState>(() {
  return BatchViewmodel();
});

class BatchViewmodel extends Notifier<BatchState> {
  late final GetAllBatchUsecase _getAllBatchUsecase;
  late final CreateBatchUsecase _createBatchUsecase;
  late final UpdateBatchUsecase _updateBatchUsecase;
  late final DeleteBatchUsecase _deleteBatchUsecase;

  @override
  BatchState build() {
    // Initialize the usecases here using ref, which we will do later
    _getAllBatchUsecase = ref.read(getAllBatchUsecaseProvider);
    _updateBatchUsecase = ref.read(updateBatchUsecaseProvider);
    _createBatchUsecase = ref.read(createBatchUsecaseProvider);
    return const BatchState();
  }

  Future<void> getAllBatches() async {
    state = state.copyWith(status: BatchStatus.loading);

    //Wait for 2 seconds
    await Future.delayed(Duration(seconds: 2));
    final result = await _getAllBatchUsecase();

    result.fold(
      (failure) => state = state.copyWith(
        status: BatchStatus.error,
        errorMessage: failure.message,
      ),
      (batches) =>
          state = state.copyWith(status: BatchStatus.loaded, batches: batches),
    );
  }

  Future<void> createBatch(String batchName) async {
    state = state.copyWith(status: BatchStatus.loading);

    final result = await _createBatchUsecase(
      CreateBatchUsecaseParams(batchName: batchName),
    );
    result.fold(
      (failure) => state = state.copyWith(
        status: BatchStatus.error,
        errorMessage: failure.message,
      ),
      (_) {
        state = state.copyWith(status: BatchStatus.created);
        getAllBatches();
      },
    );
  }

  Future<void> updateBatch({
    required String batchId,
    required String batchName,
    String? status,
  }) async {
    state = state.copyWith(status: BatchStatus.loading);

    final result = await _updateBatchUsecase(
      UpdateBatchUsecaseParams(
        batchId: batchId,
        batchName: batchName,
        status: status,
      ),
    );

    result.fold(
      (failure) => state = state.copyWith(
        status: BatchStatus.error,
        errorMessage: failure.message,
      ),
      (_) {
        state = state.copyWith(status: BatchStatus.updated);
        getAllBatches();
      },
    );
  }

  Future<void> deleteBranch(String batchId) async {
    state = state.copyWith(status: BatchStatus.loading);

    final result = await _deleteBatchUsecase(
      DeleteBatchUsecaseParams(batchId: batchId),
    );

    result.fold(
      (failure) => state = state.copyWith(
        status: BatchStatus.error,
        errorMessage: failure.message,
      ),
      (_) {
        state = state.copyWith(status: BatchStatus.deleted);
        getAllBatches();
      },
    );
  }
}
