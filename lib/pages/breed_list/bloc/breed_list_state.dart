part of 'breed_list_bloc.dart';


// These are the states that the BLoC can emit.
abstract class BreedListState {}

class DogBreedInitial extends BreedListState {}

class DogBreedLoading extends BreedListState {}

class DogBreedLoaded extends BreedListState {
  final List<String> breeds;

  DogBreedLoaded(this.breeds);
}

class DogBreedError extends BreedListState {
  final String error;

  DogBreedError(this.error);
}
