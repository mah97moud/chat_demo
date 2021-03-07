import 'package:flutter/material.dart';

class ViewImageScreen extends StatelessWidget {
  final image;

  const ViewImageScreen({this.image});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: InteractiveViewer(
              constrained: true,
              child: Image(
                image: NetworkImage(image),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
