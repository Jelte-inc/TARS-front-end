import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:developer';

class Terminal extends StatefulWidget {
  const Terminal({super.key});

  @override
  State<Terminal> createState() => _TerminalState();
}

class _TerminalState extends State<Terminal> {
  late WebSocketChannel _channel;
  final List<String> _berichten = [];

  @override
  void initState() {
    super.initState();

    _channel = WebSocketChannel.connect(
      Uri.parse('ws://localhost:56277/ws'), // vervang door jouw adres
    );

    // Stuur een eerste bericht zodra de verbinding open is
    _channel.sink.add('Client verbonden: hallo server!');

    _channel.stream.listen(
      (message) {
        log('Ontvangen: $message');
        setState(() {
          _berichten.add(message.toString().trim());
        });
      },
      onError: (error) {
        log('Fout: $error');
        setState(() {
          _berichten.add('Fout: $error');
        });
      },
      onDone: () {
        log('Verbinding gesloten');
        setState(() {
          _berichten.add('Verbinding gesloten');
        });
      },
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(_berichten.toString())
      ),
    );
  }
}
