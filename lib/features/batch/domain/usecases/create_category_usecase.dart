import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/core/usecases/app_usecase.dart';
import 'package:lost_n_found/features/batch/domain/entities/category_entity.dart';
import 'package:lost_n_found/features/batch/domain/repositories/category_repository.dart';

class CreateCategoryUsecaseParams extends Equatable {
  final String categoryName;
  final String categoryDesc;
  const CreateCategoryUsecaseParams({
    required this.categoryName,
    required this.categoryDesc,
  });

  @override
  List<Object?> get props => [categoryName];
}

class CreateCategoryUsecase
    implements UsecaseWithParams<bool, CreateCategoryUsecaseParams> {
  final ICategoryRepository _categoryRepository;
  CreateCategoryUsecase(this._categoryRepository);

  @override
  Future<Either<Failures, bool>> call(CreateCategoryUsecaseParams params) {
    final category = CategoryEntity(
      categoryName: params.categoryName,
      categoryDesc: params.categoryDesc,
    );
    return _categoryRepository.createCategory(category);
  }
}
