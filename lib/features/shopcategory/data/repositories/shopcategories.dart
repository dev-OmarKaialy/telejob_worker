import 'package:dartz/dartz.dart';
import 'package:worker/core/error/failures.dart';
import 'package:worker/core/unified_api/handling_exception_manager.dart';
import 'package:worker/features/shopcategory/data/datasources/shopcategorydatasource.dart';
import 'package:worker/features/shopcategory/data/models/shopcategorymodel.dart';

class Shopcategoriesrepo with HandlingExceptionManager {
  Future<Either<Failure, ShopCategoryModel>> getshopCategories() async {
    return wrapHandling(tryCall: () async {
      return Right(await Shopcategorydatasource().getshopCategories());
    });
  }
}
