import 'package:customer_app/data/models/requests/get_chatmessage_history_response.dart';
import 'package:customer_app/data/providers/api_provider.dart';
import 'package:customer_app/core/exceptions/bussiness_exception.dart';
import 'package:customer_app/core/exceptions/unexpected_exception.dart';

class ChatAPIService {
  Future<ChatMessageHistoryResponseBody> getChatLog(
      {required String tripId}) async {
    try {
      var body = {"tripId": tripId};
      var response = await APIHandlerImp.instance.post(
        body,
        '/Chat/Chat/GetChats',
      );
      if (response.data["status"]) {
        return ChatMessageHistoryResponseBody.fromJson(response.data['data']);
      } else {
        return Future.error(IBussinessException(response.data['message']));
      }
    } catch (e) {
      return Future.error(UnexpectedException(
          context: "Trip-GetIncome", debugMessage: e.toString()));
    }
  }
}
