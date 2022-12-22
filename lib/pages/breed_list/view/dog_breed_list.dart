
import 'package:dinder/pages/breed_list/widgets/paws_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils.dart';
import '../../breed_detail/view/breed_detail_screen.dart';
import '../bloc/breed_list_bloc.dart';

class DogBreedList extends StatelessWidget {
  const DogBreedList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<BreedListBloc, BreedListState>(
      listener: (context, state) {
        if (state is BreedListError)
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
          if (state is BreedListLoaded) {
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
          } else if (state is BreedListError) {
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
