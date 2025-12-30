import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String? categoryId;
  final String categoryName;
  final String categoryDesc;
  final String? status;

  const CategoryEntity({
    this.categoryId,
    required this.categoryName,
    required this.categoryDesc,
    this.status,
  });

  @override
  List<Object?> get props => [categoryId, categoryName, categoryDesc, status];
}
