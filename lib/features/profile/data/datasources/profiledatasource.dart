import 'package:worker/core/unified_api/api_variables.dart';
import 'package:worker/core/unified_api/get_api.dart';
import 'package:worker/core/unified_api/put_api.dart';
import 'package:worker/features/profile/data/models/profilemodel.dart';

class Profiledatasource {
  Future<ProfileModel> getprofile() async {
    final getApi =
        GetApi(uri: ApiVariables().profile(), fromJson: profileModelFromJson);
    return await getApi.callRequest();
  }

  Future<ProfileModel> putprofile() async {
    final putApi = PutApi(
        uri: ApiVariables().profile(),
        fromJson: profileModelFromJson,
        body: {});
    return await putApi.callRequest();
  }
}
