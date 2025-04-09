abstract class ChatRepository {
  Future<void> getChat();

  Future<void> sendMessage(String message);
}