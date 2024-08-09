import 'package:dartz/dartz.dart';
import 'package:worker/core/error/failures.dart';
import 'package:worker/core/unified_api/handling_exception_manager.dart';
import 'package:worker/features/profile/data/datasources/profiledatasource.dart';
import 'package:worker/features/profile/data/models/profilemodel.dart';

class Profilerepo with HandlingExceptionManager {
  Future<Either<Failure, ProfileModel>> getprofile() async {
    return wrapHandling(tryCall: () async {
      return Right(await Profiledatasource().getprofile());
    });
  }

  Future<Either<Failure, ProfileModel>> putprofile() async {
    return wrapHandling(tryCall: () async {
      return Right(await Profiledatasource().putprofile());
    });
  }
}
