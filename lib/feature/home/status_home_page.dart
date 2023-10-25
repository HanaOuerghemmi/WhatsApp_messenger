import 'package:flutter/material.dart';

class StatusHomePage extends StatelessWidget {
  const StatusHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("status home page  ")
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){},
        child: const Icon(Icons.edit),
        
         ),
    );
  }
}