import 'dart:developer';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:io';

class ListenerService {
  late final WebSocketChannel _channel;

  void startAiWebsocket({
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

  Future<void> startStreaming() async {
    final socket = await Socket.connect("localhost", 5005);
    socket.write("START");
    await socket.flush();
    socket.destroy();
  }

  Future<void> stopStreaming() async {
    final socket = await Socket.connect("localhost", 5005);
    socket.write("STOP");
    await socket.flush();
    socket.destroy();
  }

  void dispose() {
    _channel.sink.close();
    stopStreaming();
  }
}
