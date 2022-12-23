
import 'package:dinder/pages/breed_detail/widgets/image_unloaded.dart';
import 'package:flutter/material.dart';

class DogBreedImage extends StatelessWidget {
  const DogBreedImage({
    Key? key, required this.imageUrl, required this.isReachMax,
  }) : super(key: key);

  final String imageUrl;
  final bool isReachMax;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.725,
      width: MediaQuery.of(context).size.width * 0.85,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: isReachMax
            ? Container(
                color: Colors.grey.withOpacity(0.1),
                child: const Center(child: Text("Thats all for today")),
              )
            : Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder:
                    (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                      color: Colors.black.withOpacity(0.1),
                      child: const Center(
                          child: CircularProgressIndicator()));
                },
                errorBuilder: (context, err, s) {
                  return const ImageUnloaded();
                },
              ),
      ),
    );
  }
}
