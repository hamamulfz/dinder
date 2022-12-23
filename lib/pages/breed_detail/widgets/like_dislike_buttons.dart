
import 'package:dinder/widgets/rounded_icon.dart';
import 'package:flutter/material.dart';

class LikeDislikeButton extends StatelessWidget {
  const LikeDislikeButton({
    Key? key,
    this.onLike,
    this.onDislike,
  }) : super(key: key);

  final Function()? onLike;
  final Function()? onDislike;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: Row(
        children: [
          RoundedIcon(
            color: Colors.white,
            icon: Icons.clear,
            iconColor: Colors.red,
            onTap: onDislike,
          ),
          const Spacer(),
          RoundedIcon(
            color: Colors.white,
            icon: Icons.favorite,
            iconColor: Colors.teal,
            onTap: onLike,
          ),
        ],
      ),
    );
  }
}
