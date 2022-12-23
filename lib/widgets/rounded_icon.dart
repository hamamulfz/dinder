
import 'package:flutter/material.dart';

class RoundedIcon extends StatelessWidget {
  const RoundedIcon({
    Key? key,
    required this.color,
    required this.icon,
    this.onTap,
    this.iconColor,
  }) : super(key: key);
  final Color color;
  final Color? iconColor;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 20,
                  color: Colors.black.withOpacity(0.2)),
            ],
            shape: BoxShape.circle,
            color: color,
          ),
          child: Icon(
            icon,
            color: iconColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
