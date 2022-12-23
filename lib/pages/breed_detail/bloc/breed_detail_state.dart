part of 'breed_detail_bloc.dart';

abstract class BredDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class DogBreedDetailInitial extends BredDetailState {}

class DogBreedImagesLoading extends BredDetailState {}

class DogBreedImagesLoaded extends BredDetailState {
  // final String breed;
  final int index;
  final bool isReachMax;
  final List<String> images;

  DogBreedImagesLoaded(
    // this.breed,
    this.images, {
    this.index = 0,
    this.isReachMax = false,
  });

  DogBreedImagesLoaded.newIndex(List<String> oldImages, currentIndex)
      : images = oldImages,
        index = currentIndex + 1,
        isReachMax = currentIndex >= oldImages.length - 1;

  @override
  List<Object> get props => [index, isReachMax, images];
}

class DogBreedDetailError extends BredDetailState {
  final String error;

  DogBreedDetailError(this.error);

  @override
  List<Object> get props => [error];
}
