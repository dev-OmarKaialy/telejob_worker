import 'package:dartz/dartz.dart';
import 'package:worker/core/error/failures.dart';
import 'package:worker/core/unified_api/handling_exception_manager.dart';
import 'package:worker/features/joprequest/data/datasources/requestsdatasource.dart';
import 'package:worker/features/joprequest/data/models/requestsmodel.dart';

class Requestsrepo with HandlingExceptionManager {
  Future<Either<Failure, Joprequests>> getrequests() async {
    return wrapHandling(tryCall: () async {
      return Right(await Requestsdatasource().getreqests());
    });
  }
}
