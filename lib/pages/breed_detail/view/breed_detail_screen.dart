import 'package:dinder/pages/breed_detail/view/dog_matchng.dart';
import 'package:dio/dio.dart';
import 'package:dog_ceo_api/dog_ceo_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../breed_list/view/breed_list_screen.dart';
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
      appBar: AppBar(
        title: Text(breed),
      ),
      body: BlocProvider(
        create: (context) => bloc..add(DogBreedImageFetch(breed)),
        child: DogMatching(
          breed: breed,
        ),
      ),
    );
  }
}
