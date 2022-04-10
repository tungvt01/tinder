import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:tinder/core/error/exceptions.dart';
import 'package:tinder/core/error/failures.dart';

abstract class BaseUseCase<T> {
  Future<Either<Failure, T>> execute() async {
    try {
      final res = await main();
      return Right(res);
    } on RemoteException catch (ex) {
      return Left(RemoteFailure(
          msg: ex.errorMessage, code: ex.httpStatusCode.toString()));
    } on CacheException catch (ex) {
      return Left(CacheFailure(msg: ex.errorMessage));
    } on PlatformException catch (ex) {
      return Left(CacheFailure(msg: ex.message));
    } on Exception {
      return Left(UnknownFailure(msg: SERVER_ERROR_MESSAGE));
    } on Error catch (ex) {
      return Left(UnknownFailure(msg: ex.toString()));
    }
  }

  Future<T> main();
}
