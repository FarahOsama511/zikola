import"package:dartz/dartz.dart";
import "package:zikola/core/networking/api_error_model.dart";

typedef RepoResult<T> = Either<ApiErrorModel, T>;
