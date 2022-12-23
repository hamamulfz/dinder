import 'package:dinder/pages/breed_list/view/dog_breed_list.dart';
import 'package:dio/dio.dart';
import 'package:dog_ceo_api/dog_ceo_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/breed_list_bloc.dart';

class BreedListScreen extends StatelessWidget {
  const BreedListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    final repository = DogCeoApi(dio);
    final bloc = BreedListBloc(repository);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Dog Breed"),
      ),
      body: BlocProvider(
        create: (context) => bloc..add(DogBreedFetch()),
        child: const DogBreedList(),
      ),
    );
  }
}
