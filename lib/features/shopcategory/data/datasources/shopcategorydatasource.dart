import 'package:worker/core/unified_api/api_variables.dart';
import 'package:worker/core/unified_api/get_api.dart';
import 'package:worker/features/shopcategory/data/models/shopcategorymodel.dart';

class Shopcategorydatasource {
  Future<ShopCategoryModel> getshopCategories() async {
    final getApi = GetApi(
        uri: ApiVariables().shopCategories(),
        fromJson: shopCategoryModelFromJson);
    return await getApi.callRequest();
  }
}
