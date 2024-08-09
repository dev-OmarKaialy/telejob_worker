import 'package:worker/core/unified_api/api_variables.dart';
import 'package:worker/core/unified_api/get_api.dart';

import '../models/categoriesmodel.dart';

class CategoriesDatasource {
  Future<CatiegoresModel> getCategories() async {
    final getApi = GetApi(
        uri: ApiVariables().jobCategories(), fromJson: catiegoresModelFromJson);
    return await getApi.callRequest();
  }
}
