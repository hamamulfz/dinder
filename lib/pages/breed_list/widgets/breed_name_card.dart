

import 'package:flutter/material.dart';

import 'paws_icon.dart';

class BreedNameCard extends StatelessWidget {
  const BreedNameCard({
    Key? key,
    required this.breed,
    this.onTap,
  }) : super(key: key);

  final String breed;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: PawsIcon(),
        trailing: const Icon(Icons.arrow_forward_ios),
        title: Text(
          breed,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
