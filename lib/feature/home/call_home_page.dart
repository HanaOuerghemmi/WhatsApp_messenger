import 'package:flutter/material.dart';

class CallHomePage extends StatelessWidget {
  const CallHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("call page  ")
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){},
        child: const Icon(Icons.phone),
        
         ),
    );
  }
}