part of 'breed_list_bloc.dart';


abstract class BreedListState extends Equatable {}

class BreedListInitial extends BreedListState {
  @override
  List<Object> get props => [];
}

class BreedListLoading extends BreedListState {
  @override
  List<Object> get props => [];
}

class BreedListLoaded extends BreedListState {
  final List<String> breeds;

  BreedListLoaded(this.breeds);

  @override
  List<Object> get props => [breeds];
}

class BreedListError extends BreedListState {
  final String error;

  BreedListError(this.error);

  @override
  List<Object> get props => [error];
}
