import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  WebSocketService({
    this.url = 'ws://127.0.0.1:8080/chat/ws',
  }) : channel = WebSocketChannel.connect(
          Uri.parse(url),
        );
  final String url;
  final WebSocketChannel channel;

  Stream<dynamic> get stream => channel.stream;

  void send(dynamic data) {
    final message = jsonEncode(data);
    channel.sink.add(message);
  }

  void dispose() {
    channel.sink.close();
    channel.stream.drain();
  }
}
