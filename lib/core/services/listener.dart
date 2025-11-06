import 'dart:developer';
import 'package:web_socket_channel/web_socket_channel.dart';

class ListenerService {
  late final WebSocketChannel _channel;

  void start({
    required void Function(String) onMessage,
    required void Function(Object) onError,
  }) {
    _channel = WebSocketChannel.connect(
      Uri.parse('ws://localhost:56277/ws'),
    );

    _channel.sink.add('What is the weather in Amsterdam');

    _channel.stream.listen(
      (msg) => onMessage(msg.toString().trim()),
      onError: (err) => onError(err),
      onDone: () => log('Connection closed'),
    );
  }

  void dispose() {
    _channel.sink.close();
  }
}
