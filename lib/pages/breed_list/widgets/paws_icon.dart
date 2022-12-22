import 'package:dinder/utils.dart';
import 'package:dinder/widgets/rounded_icon.dart';
import 'package:flutter/material.dart';

class PawsIcon extends RoundedIcon {
  PawsIcon({super.key})
      : super(
          color: Utils.getRandomColor(),
          icon: Icons.pets,
        );
}
