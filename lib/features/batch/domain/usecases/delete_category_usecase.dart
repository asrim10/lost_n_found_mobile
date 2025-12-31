import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/core/usecases/app_usecase.dart';
import 'package:lost_n_found/features/batch/domain/repositories/category_repository.dart';

class DeleteCategoryUsecaseParams extends Equatable {
  final String categoryId;
  const DeleteCategoryUsecaseParams({required this.categoryId});

  @override
  List<Object?> get props => [];
}

class DeleteCategoryUsecase
    implements UsecaseWithParams<bool, DeleteCategoryUsecaseParams> {
  final ICategoryRepository _categoryRepository;

  DeleteCategoryUsecase(this._categoryRepository);

  @override
  Future<Either<Failures, bool>> call(DeleteCategoryUsecaseParams params) {
    return _categoryRepository.deleteCategory(params.categoryId);
  }
}
