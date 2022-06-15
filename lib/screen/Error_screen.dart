import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          const Text('Error! No page found'),
          TextButton(
              onPressed: () {
                return context.go('/');
              },
              child: const Text('Go back to HomePage')),
        ]),
      ),
    );
  }
}
