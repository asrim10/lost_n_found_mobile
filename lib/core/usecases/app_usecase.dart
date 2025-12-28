import 'package:either_dart/either.dart';
import 'package:lost_n_found/core/error/failures.dart';

//entity jasko parameter xa tesko lagi //SuccessType=> ReturnType
abstract interface class UsecaseWithParams<SuccessType, Params> {
  Future<Either<Failures, SuccessType>> call(Params params);
}

//entity jasko parameter xainw tesko lagi
abstract interface class UsecaseWithoutParams<SuccessType> {
  Future<Either<Failures, SuccessType>> call();
}
