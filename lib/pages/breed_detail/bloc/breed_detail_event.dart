part of 'breed_detail_bloc.dart';

@immutable
abstract class BreedDetailEvent {}

class DogBreedImageFetch extends BreedDetailEvent {
  final String breed;

  DogBreedImageFetch(this.breed);
}

class DogBreedButtonLikeTapped extends BreedDetailEvent {
  final List<String> images;
  final int currentIndex;
  DogBreedButtonLikeTapped(this.images, this.currentIndex);
}

class DogBreedButtonDislikeTapped extends BreedDetailEvent {
  final List<String> images;
  final int currentIndex;
  DogBreedButtonDislikeTapped(this.images, this.currentIndex);
}
