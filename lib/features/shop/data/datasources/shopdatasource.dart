import 'package:worker/core/unified_api/api_variables.dart';
import 'package:worker/core/unified_api/get_api.dart';
import 'package:worker/features/shop/data/models/shopmodel.dart';

class Shopdatasource {
  Future<ShopModel> getshop() async {
    final getApi =
        GetApi(uri: ApiVariables().shops(), fromJson: shopModelFromJson);
    return await getApi.callRequest();
  }
}
