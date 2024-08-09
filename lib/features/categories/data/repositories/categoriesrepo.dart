import 'package:dartz/dartz.dart';
import 'package:worker/core/error/failures.dart';
import 'package:worker/core/unified_api/handling_exception_manager.dart';
import 'package:worker/features/categories/data/datasources/categories_datasource.dart';
import 'package:worker/features/categories/data/models/categoriesmodel.dart';

class Categoriesrepo with HandlingExceptionManager {
  Future<Either<Failure, CatiegoresModel>> getCategories() async {
    return wrapHandling(tryCall: () async {
      return Right(await CategoriesDatasource().getCategories());
    });
  }
}
