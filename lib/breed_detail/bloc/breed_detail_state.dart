part of 'breed_detail_bloc.dart';

abstract class DogDetailState {}

class DogBreedInitial extends DogDetailState {}

class DogBreedImagesLoading extends DogDetailState {}

class DogBreedImagesLoaded extends DogDetailState {
  final String breed;
  final List<String> images;

  DogBreedImagesLoaded(this.breed, this.images);
}

class DogBreedError extends DogDetailState {
  final String error;

  DogBreedError(this.error);
}