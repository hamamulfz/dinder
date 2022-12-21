

import 'package:dinder/breed_detail/view/breed_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:dog_ceo_api/dog_ceo_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/breed_list_bloc.dart';

class BreedListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final breedListBloc = BlocProvider.of<DogBreedBloc>(context);
    // Dispatch a fetch event to the BLoC to load the list of breeds.
    // Create a Dio instance that will be used to make HTTP requests.
    final dio = Dio();
    // breedListBloc.add(DogBreedFetch());

    // Create the repository and BLoC.
    final repository = DogCeoApi(dio);
    final bloc = BreedListBloc(repository);
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => bloc..add(DogBreedFetch()),
        child: DogBreedList(),
      ),
    );
  }
}

class DogBreedList extends StatelessWidget {
  const DogBreedList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BreedListBloc, BreedListState>(
      builder: (context, state) {
        if (state is DogBreedLoaded) {
          // Display the list of breeds.
          return ListView.builder(
            itemCount: state.breeds.length,
            itemBuilder: (context, index) {
              final breed = state.breeds[index];
              return ListTile(
                title: Text(breed),
                onTap: () {
                  // Navigate to the breed images screen and dispatch a
                  // select event to the BLoC to load the images.

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BreedDetailScreen(breed
                          // , breedListBloc
                          ),
                    ),
                  );
                },
              );
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
    );
  }
}