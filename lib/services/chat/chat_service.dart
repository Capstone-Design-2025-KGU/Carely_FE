import 'package:carely/models/chat_message.dart';
import 'package:carely/models/chat_room.dart';
import 'package:carely/services/api_service.dart';
import 'package:carely/utils/logger_config.dart';

class ChatService {
  ChatService._();
  static final ChatService instance = ChatService._();

  Future<List<ChatRoom>> fetchChatRoom(int memberId) async {
    try {
      final response = await APIService.instance.request(
        '/chat/$memberId/rooms',
        DioMethod.get,
      );

      final List<dynamic> data = response.data;
      return data.map((json) => ChatRoom.fromJson(json)).toList();
    } catch (e) {
      logger.w('채팅방 불러오기 실패: $e');
      return [];
    }
  }

  Future<List<ChatMessage>> fetchMessages(int chatRoomId) async {
    final response = await APIService.instance.request(
      '/chat/$chatRoomId/messages',
      DioMethod.get,
    );

    final List<dynamic> data = response.data;
    return data.map((json) => ChatMessage.fromJson(json)).toList();
  }

  Future<bool> deleteChatRoom(int chatRoomId) async {
    try {
      final response = await APIService.instance.request(
        '/chat/$chatRoomId',
        DioMethod.delete,
      );
      return response.data == true;
    } catch (e) {
      logger.w('채팅방 삭제 실패: $e');
      return false;
    }
  }
}
