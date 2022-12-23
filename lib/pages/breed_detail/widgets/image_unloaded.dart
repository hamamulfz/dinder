
import 'package:flutter/material.dart';

class ImageUnloaded extends StatelessWidget {
  const ImageUnloaded({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          Icon(Icons.warning),
          Text("Could not load image")
        ],
      ),
    );
  }
}
