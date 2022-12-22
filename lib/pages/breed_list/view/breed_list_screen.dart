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

class DogBreedList extends StatelessWidget {
  const DogBreedList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<BreedListBloc, BreedListState>(
      listener: (context, state) {
        if (state is DogBreedError)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Color.fromRGBO(76, 175, 80, 1),
              content: Text(state.error),
              duration: Duration(seconds: 5),
            ),
          );
      },
      child: BlocBuilder<BreedListBloc, BreedListState>(
        builder: (context, state) {
          if (state is DogBreedLoaded) {
            // Display the list of breeds.
            return ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: state.breeds.length,
              itemBuilder: (context, index) {
                final breed = state.breeds[index];
                return ListTile(
                  leading: PawsIcon(),
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text(
                    breed,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
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
            );
          } else if (state is DogBreedError) {
            // Display an error message.
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.error,
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<BreedListBloc>(context)
                          .add(DogBreedFetch());
                    },
                    child: Text("Try Again"))
              ],
            );
          } else {
            // Display a loading indicator.
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class PawsIcon extends RoundedIcon {
  PawsIcon({super.key})
      : super(
          color: Utils.getRandomColor(),
          icon: Icons.pets,
        );
}

class RoundedIcon extends StatelessWidget {
  const RoundedIcon({
    Key? key,
    required this.color,
    required this.icon,
    this.onTap,
    this.iconColor,
  }) : super(key: key);
  final Color color;
  final Color? iconColor;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 20,
                  color: Colors.black.withOpacity(0.2)),
            ],
            shape: BoxShape.circle,
            color: color,
          ),
          child: Icon(
            icon,
            color: iconColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
