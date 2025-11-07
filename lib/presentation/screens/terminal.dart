import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:tars_front_end/core/services/listener.dart';

class Terminal extends StatefulWidget {
  const Terminal({super.key});

  @override
  State<Terminal> createState() => _TerminalState();
}

class _TerminalState extends State<Terminal> {
  final List<String> _berichten = [];
  final _service = ListenerService();

  @override
  void initState() {
    super.initState();
    // _service.startAiWebsocket(
    //   onMessage: (msg) {
    //     setState(() => _berichten.add(msg));
    //   },
    //   onError: (err) {
    //     setState(() => _berichten.add('Error: $err'));
    //   },
    // );
    _service.startStreaming();
  }

  @override
  void dispose() {
    super.dispose();
    _service.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GlowText(_berichten.join(" ")),
      ),
    );
  }
}
