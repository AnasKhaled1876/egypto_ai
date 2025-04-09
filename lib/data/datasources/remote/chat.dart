import 'package:egypto_ai/domain/responses/chat/get_chat.dart';
import 'package:egypto_ai/domain/responses/chat/send_message.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'chat.g.dart';

@RestApi(baseUrl: '', parser: Parser.MapSerializable)
abstract class ChatApiService {
  factory ChatApiService(Dio dio, {String baseUrl}) = _ChatApiService;

  @GET('')
  Future<HttpResponse<GetChatResponse>> getChat();

  @GET('/')
  Future<HttpResponse<SendMessageResponse>> sendMessage({
    @Query('message') required String message,
  });


}
