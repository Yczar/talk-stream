import 'package:get_it/get_it.dart';
import 'package:talk_stream/app/core/services/services.dart';

final locator = GetIt.instance;
void setupLocator() {
  locator
    ..registerSingleton<HttpService>(
      HttpService(
        baseUrl: 'http://127.0.0.1:8080',
      ),
    )
    ..registerSingleton<WebSocketService>(
      WebSocketService(),
    )
    ..registerLazySingleton<GoRouterService>(
      GoRouterService.new,
    );
}
