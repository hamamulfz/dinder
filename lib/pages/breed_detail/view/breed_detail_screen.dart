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
              backgroundColor: Color.fromRGBO(76, 175, 80, 1),
              content: Text(state.error),
              duration: Duration(seconds: 5),
            ),
          );
        }
      },
      child: BlocBuilder<BreedDetailBloc, BredDetailState>(
        builder: (context, state) {
          if (state is DogBreedImagesLoaded) {
            return Container(
              width: double.infinity,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.725,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: state.isReachMax
                          ? Container(
                              color: Colors.grey.withOpacity(0.1),
                              child: Center(child: Text("Thats all for today")),
                            )
                          : Image.network(
                              state.images[state.index],
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                    color: Colors.black.withOpacity(0.1),
                                    child: Center(
                                        child: CircularProgressIndicator()));
                              },
                              errorBuilder: (context, err, s) {
                                return Center(
                                  child: Column(
                                    children: [
                                      Icon(Icons.warning),
                                      Text("Could not load image")
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                  SizedBox(height: 20),
                  if (!state.isReachMax)
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1),
                      child: Row(
                        children: [
                          RoundedIcon(
                            color: Colors.white,
                            icon: Icons.clear,
                            iconColor: Colors.red,
                            onTap: () {
                              BlocProvider.of<BreedDetailBloc>(context).add(
                                DogBreedButtonLikeTapped(
                                    state.images, state.index),
                              );
                            },
                          ),
                          Spacer(),
                          RoundedIcon(
                            color: Colors.white,
                            icon: Icons.favorite,
                            iconColor: Colors.teal,
                            onTap: () {
                              BlocProvider.of<BreedDetailBloc>(context).add(
                                DogBreedButtonDislikeTapped(
                                    state.images, state.index),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                ],
              ),
            );
          } else if (state is DogBreedDetailError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.error,
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<BreedDetailBloc>(context)
                          .add(DogBreedImageFetch(breed));
                    },
                    child: Text("Try Again"))
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
