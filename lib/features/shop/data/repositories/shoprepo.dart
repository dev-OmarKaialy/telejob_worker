import 'package:dartz/dartz.dart';
import 'package:worker/core/error/failures.dart';
import 'package:worker/core/unified_api/handling_exception_manager.dart';
import 'package:worker/features/shop/data/datasources/shopdatasource.dart';
import 'package:worker/features/shop/data/models/shopmodel.dart';

import '../models/shop_products.dart';

class ShopRepo with HandlingExceptionManager {
  Future<Either<Failure, ShopModel>> getshop() async {
    return wrapHandling(tryCall: () async {
      return Right(await Shopdatasource().getshop());
    });
  }

  Future<Either<Failure, GetShopProducts>> getShopProducts(String id) async {
    return wrapHandling(tryCall: () async {
      return Right(await Shopdatasource().shopProducts(id));
    });
  }
}
