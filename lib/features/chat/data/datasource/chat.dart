import 'package:egypto/features/chat/data/models/get_chat.dart';
import 'package:egypto/features/chat/data/models/send_message.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'chat.g.dart';

@RestApi(parser: Parser.MapSerializable)
abstract class ChatApiService {
  factory ChatApiService(Dio dio, {String baseUrl}) = _ChatApiService;

  @GET('')
  Future<HttpResponse<GetChatResponse>> getChat();

  @POST('/')
  Future<HttpResponse<SendMessageResponse>> sendMessage({
    @Body() required Map<String, dynamic> body,
  });

  @POST('/title')
  Future<HttpResponse<SendMessageResponse>> generateTitle({
    @Body() required Map<String, dynamic> body,
  });
}
