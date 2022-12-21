
import 'package:dio/dio.dart';
import 'package:dog_ceo_api/dog_ceo_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/breed_detail_bloc.dart';

class BreedDetailScreen extends StatelessWidget {
  final String breed;
  // final DogBreedBloc bloc;
  BreedDetailScreen(
    this.breed,
    // this.bloc,
  );

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    // breedListBloc.add(DogBreedFetch());

    // Create the repository and BLoC.
    final repository = DogCeoApi(dio);
    final bloc = BreedDetailBloc(repository);
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => bloc..add(DogBreedImageFetch(breed)),
        child: BlocBuilder<BreedDetailBloc, DogDetailState>(
          builder: (context, state) {
            if (state is DogBreedImagesLoaded) {
              // Display the images for the selected breed.
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: state.images.length,
                itemBuilder: (context, index) {
                  final imageUrl = state.images[index];
                  return Image.network(imageUrl);
                },
              );
            } else if (state is DogBreedError) {
              // Display an error message.
              return Center(
                child: Text(state.error),
              );
            } else {
              // Display a loading indicator.
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
