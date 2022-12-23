import 'package:dinder/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../breed_detail/view/breed_detail_screen.dart';
import '../bloc/breed_list_bloc.dart';
import '../widgets/breed_name_card.dart';

class DogBreedList extends StatelessWidget {
  const DogBreedList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<BreedListBloc, BreedListState>(
      listener: (context, state) {
        if (state is BreedListError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: const Color.fromRGBO(76, 175, 80, 1),
              content: Text(state.error),
              duration: const Duration(seconds: 5),
            ),
          );
        }
      },
      child: BlocBuilder<BreedListBloc, BreedListState>(
        builder: (context, state) {
          if (state is BreedListLoaded) {
            
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                
                itemCount: state.breeds.length,
                itemBuilder: (context, index) {
                  final breed = state.breeds[index];
                  return BreedNameCard(
                    breed: breed,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BreedDetailScreen(breed),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          } else if (state is BreedListError) {
            return CustomErrorWidget(
              error: state.error,
              onTap: () {
                BlocProvider.of<BreedListBloc>(context).add(DogBreedFetch());
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
