import 'package:dinder/pages/breed_list/view/dog_breed_list.dart';
import 'package:dio/dio.dart';
import 'package:dog_ceo_api/dog_ceo_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils.dart';
import '../../breed_detail/view/breed_detail_screen.dart';
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
      appBar: AppBar(
        title: Text("Choose Dog Breed"),
      ),
      body: BlocProvider(
        create: (context) => bloc..add(DogBreedFetch()),
        child: DogBreedList(),
      ),
    );
  }
}
