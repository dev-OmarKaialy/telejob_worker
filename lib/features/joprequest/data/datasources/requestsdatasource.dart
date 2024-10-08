import 'package:worker/core/unified_api/api_variables.dart';
import 'package:worker/core/unified_api/get_api.dart';
import 'package:worker/core/unified_api/put_api.dart';
import 'package:worker/features/joprequest/data/models/requestsmodel.dart';

class Requestsdatasource {
  Future<Joprequests> getreqests() async {
    final getApi =
        GetApi(uri: ApiVariables().requests(), fromJson: joprequestsFromJson);
    return await getApi.callRequest();
  }

  Future<void> toggleRequest(String id, bool status) async {
    final putApi = PutApi(
        uri: ApiVariables().cancelRequest(id),
        body: {"responseType": status ? 'accept' : 'reject'},
        fromJson: (s) {});

    return await putApi.callRequest();
  }
}
