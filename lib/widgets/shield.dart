import 'package:flutter/material.dart';

class Shield extends StatelessWidget {
  final String imageSrc;
  final double size;

  const Shield({super.key, required this.imageSrc, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: Hero(
        tag: imageSrc,
        child: Image.network(
          imageSrc,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
