import 'package:worker/core/unified_api/api_variables.dart';
import 'package:worker/core/unified_api/get_api.dart';
import 'package:worker/features/shop/data/models/shopmodel.dart';

import '../models/shop_products.dart';

class Shopdatasource {
  Future<ShopModel> getshop() async {
    final getApi =
        GetApi(uri: ApiVariables().shops(), fromJson: shopModelFromJson);
    return await getApi.callRequest();
  }

  Future<GetShopProducts> shopProducts(String id) async {
    final getApi = GetApi(
        uri: ApiVariables().shopProducts(id),
        fromJson: getShopProductsFromJson);
    return await getApi.callRequest();
  }
}
