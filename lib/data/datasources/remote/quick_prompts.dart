import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../domain/responses/quick_prompts.dart';

part 'quick_prompts.g.dart';

@RestApi(parser: Parser.MapSerializable)
abstract class QuickPromptsApiService {
  factory QuickPromptsApiService(Dio dio, {String baseUrl}) = _QuickPromptsApiService;

  @GET('')
  Future<HttpResponse<GetQuickPromptsResponse>> getQuickPrompts();

}
