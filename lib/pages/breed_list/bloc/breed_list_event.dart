part of 'breed_list_bloc.dart';


// These are the events that can be dispatched to the BLoC.
abstract class BreedListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DogBreedFetch extends BreedListEvent {}


