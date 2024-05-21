import 'package:flutter/material.dart';

class ImgProcessor extends StatelessWidget {
  const ImgProcessor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imagens'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Processar Imagens",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),

          ],
        ),
      ),
    );
  }
}