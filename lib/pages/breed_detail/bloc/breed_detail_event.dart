part of 'breed_detail_bloc.dart';

@immutable
abstract class BreedDetailEvent extends Equatable {
  
}

class DogBreedImageFetch extends BreedDetailEvent {
  final String breed;

  DogBreedImageFetch(this.breed);

  @override
  List<Object> get props => [breed];
}

class DogBreedButtonLikeTapped extends BreedDetailEvent {
  final List<String> images;
  final int currentIndex;
  DogBreedButtonLikeTapped(this.images, this.currentIndex);

  @override
  List<Object> get props => [images, currentIndex];
}

class DogBreedButtonDislikeTapped extends BreedDetailEvent {
  final List<String> images;
  final int currentIndex;
  DogBreedButtonDislikeTapped(this.images, this.currentIndex);


  @override
  List<Object> get props => [images, currentIndex];
}
