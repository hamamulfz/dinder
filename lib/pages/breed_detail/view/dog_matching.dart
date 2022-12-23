import 'package:dinder/pages/breed_detail/widgets/like_dislike_buttons.dart';
import 'package:dinder/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/breed_detail_bloc.dart';
import '../widgets/dog_breed_image.dart';

class DogMatching extends StatelessWidget {
  const DogMatching({
    Key? key,
    required this.breed,
  }) : super(key: key);
  final String breed;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BreedDetailBloc, BredDetailState>(
      listener: (context, state) {
        if (state is DogBreedDetailError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: const Color.fromRGBO(76, 175, 80, 1),
              content: Text(state.error),
              duration: const Duration(seconds: 5),
            ),
          );
        }
      },
      child: BlocBuilder<BreedDetailBloc, BredDetailState>(
        builder: (context, state) {
          if (state is DogBreedImagesLoaded) {
            return SizedBox(
              width: double.infinity,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DogBreedImage(
                    imageUrl: state.images[
                        state.isReachMax ? state.index - 1 : state.index],
                    isReachMax: state.index > state.images.length - 1,
                  ),
                  const SizedBox(height: 20),
                  if (!state.isReachMax)
                    LikeDislikeButton(
                      onLike: () {
                        BlocProvider.of<BreedDetailBloc>(context).add(
                          DogBreedButtonLikeTapped(state.images, state.index),
                        );
                      },
                      onDislike: () {
                        BlocProvider.of<BreedDetailBloc>(context).add(
                          DogBreedButtonDislikeTapped(
                              state.images, state.index),
                        );
                      },
                    )
                ],
              ),
            );
          } else if (state is DogBreedDetailError) {
            return CustomErrorWidget(
              error: state.error,
              onTap: () {
                BlocProvider.of<BreedDetailBloc>(context)
                    .add(DogBreedImageFetch(breed));
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
