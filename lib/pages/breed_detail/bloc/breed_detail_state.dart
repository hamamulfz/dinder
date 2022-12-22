part of 'breed_detail_bloc.dart';

abstract class BredDetailState {}

class DogBreedInitial extends BredDetailState {}

class DogBreedImagesLoading extends BredDetailState {}

class DogBreedImagesLoaded extends BredDetailState {
  // final String breed;
  final int index;
  final bool isReachMax;
  final List<String> images;

  DogBreedImagesLoaded(
    // this.breed,
    this.images,
    this.index,
    this.isReachMax,
  );

  DogBreedImagesLoaded.newIndex(oldImages, currentIndex)
      : images = oldImages,
        index = currentIndex + 1,
        isReachMax = currentIndex >= oldImages.length-1;
}

class DogBreedDetailError extends BredDetailState {
  final String error;

  DogBreedDetailError(this.error);
}
