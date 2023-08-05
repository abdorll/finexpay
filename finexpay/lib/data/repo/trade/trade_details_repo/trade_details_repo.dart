import 'package:http/http.dart';
import 'package:local_coin/data/model/global/response_model/response_model.dart';
import 'package:local_coin/data/model/trade/FileChooserModel.dart';
import 'package:local_coin/data/services/api_service.dart';

import '../../../../constants/method.dart';
import '../../../../core/utils/url_container.dart';

class TradeDetailsRepo {
  ApiClient apiClient;

  TradeDetailsRepo({required this.apiClient});

  Future<dynamic> getTradeDetailsData(int page, String trxId) async {
    String url =
        '${UrlContainer.baseUrl}${UrlContainer
        .tradeDetailsEndPoint}$trxId?page=$page';
    final response =
    await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return response;
  }

  Future<dynamic> storeChat(String message, int tradeDetailsId,
      {FileChooserModel? file}) async {
    apiClient.initToken();
    String url =
        '${UrlContainer.baseUrl}${UrlContainer
        .storeChatEndPoint}$tradeDetailsId';
    var request = MultipartRequest('POST', Uri.parse(url));
    request.headers
        .addAll(<String, String>{'Authorization': 'Bearer ${apiClient.token}'});
    Map<String, String> map = {'message': message};
    if (file != null && file.choosenFile != null) {
      request.files.add(MultipartFile(
          'file',
          file.choosenFile!.readAsBytes().asStream(),
          file.choosenFile!.lengthSync(),
          filename: file.choosenFile!
              .path
              .split('/')
              .last));
    }
    request.fields.addAll(map);


    StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String jsonResponse = await response.stream.bytesToString();
      return ResponseModel(true, 'success', 200, jsonResponse);
    } else {
      String jsonResponse = await response.stream.bytesToString();
      return ResponseModel(
          false, 'Chat storing failed', response.statusCode, jsonResponse);
    }
  }


  Future<dynamic> changeStatus(String tradeId, String endpoint) async {
    String url = '${UrlContainer.baseUrl}api/trade/${endpoint}';
    Map<String, String>map = {'trade_id': tradeId};
    ResponseModel model = await apiClient.request(
        url, Method.postMethod, map, passHeader: true);
    return model;
  }

  Future<dynamic> storeReview(String tradeId,String type,String feedback) async {

    String url = '${UrlContainer.baseUrl}${UrlContainer.storeReviewEndPoint}/${tradeId}';
    Map<String, String>map =
    {
      'uid': tradeId,
      'type': type,
      'feedback': feedback,
    };

    ResponseModel model = await apiClient.request(
        url, Method.postMethod, map, passHeader: true);


    return model;
  }

}
