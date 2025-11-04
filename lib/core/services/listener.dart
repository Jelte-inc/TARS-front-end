import 'dart:developer';
import 'package:web_socket_channel/web_socket_channel.dart';

void listener() {
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://localhost:56277/ws'),
  );

  channel.stream.listen(
    (message) {
      log('Ontvangen: $message');
    },
    onError: (error) {
      log('Fout: $error');
    },
    onDone: () {
      log('Verbinding gesloten');
    },
  );
}
