import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  final String message;
  final bool errOrEmpty;

  const MessageDisplay(
      {super.key, required this.message, required this.errOrEmpty});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        child: Center(
          child: SingleChildScrollView(
            child: Text(
              errOrEmpty ? "❌ $message" : "👋 $message",
              style: const TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }
}
