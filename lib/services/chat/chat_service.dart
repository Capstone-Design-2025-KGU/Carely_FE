import 'package:carely/models/chat_message.dart';
import 'package:carely/services/api_service.dart';

class ChatService {
  ChatService._();
  static final ChatService instance = ChatService._();

  Future<List<ChatMessage>> fetchMessages(int chatRoomId) async {
    final response = await APIService.instance.request(
      '/chat/$chatRoomId/messages',
      DioMethod.get,
    );

    final List<dynamic> data = response.data;
    return data.map((json) => ChatMessage.fromJson(json)).toList();
  }
}
