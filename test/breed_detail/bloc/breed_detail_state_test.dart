import 'package:dinder/pages/breed_detail/breed_detail.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Breed Detail State', () {
    test(' initial statesupports value comparison', () {
      expect(DogBreedDetailInitial(), DogBreedDetailInitial());
      expect(
        DogBreedDetailInitial().toString(),
        DogBreedDetailInitial().toString(),
      );
    });

    test('loading supports value comparison', () {
      expect(DogBreedImagesLoading(), DogBreedImagesLoading());
      expect(
        DogBreedImagesLoading().toString(),
        DogBreedImagesLoading().toString(),
      );
    });

    test('image loaded value changes', () {
      final images = ["some_hhtp1", "some_hhtp2"];
      expect(DogBreedImagesLoaded(images), DogBreedImagesLoaded(images));
      
      int currentIndex = 0;
      final newState = DogBreedImagesLoaded.newIndex(images, currentIndex);
      currentIndex++;
      expect(newState.index, currentIndex);

      final lastState = DogBreedImagesLoaded.newIndex(images, currentIndex);
      currentIndex++;
      expect(lastState.index, currentIndex);
      expect(lastState.isReachMax, true);

    });

    test('error value comparison', () {
      const error = "no internet connection";
      final breedErrorText = DogBreedDetailError(error);
      expect(DogBreedDetailError(error), breedErrorText);
      expect(breedErrorText.error, error);
    });
  });
}
