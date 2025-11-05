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
      Uri.parse('ws://localhost:56277/ws'),
    );

    _channel.sink.add('What is the weather in Amsterdam');

    _channel.stream.listen(
      (message) {
        log('Received: $message');
        setState(() {
          _berichten.add(message.toString().trim());
        });
      },
      onError: (error) {
        log('Error: $error');
        setState(() {
          _berichten.add('Error: $error');
        });
      },
      onDone: () {
        log('Connection closed');
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
        child: GlowText(_berichten.join(" "))
      ),
    );
  }
}
