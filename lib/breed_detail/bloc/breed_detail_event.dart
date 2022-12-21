part of 'breed_detail_bloc.dart';

@immutable
abstract class BreedDetailEvent {}


class DogBreedImageFetch extends BreedDetailEvent {
  final String breed;

  DogBreedImageFetch(this.breed);
}
