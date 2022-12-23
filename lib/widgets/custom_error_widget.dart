
import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    Key? key,
    required this.error,
    this.onTap,
  }) : super(key: key);

  final String error;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/error.png"),
        Text(
          error,
          textAlign: TextAlign.center,
        ),
        ElevatedButton(onPressed: onTap, child: const Text("Try Again"))
      ],
    );
  }
}
