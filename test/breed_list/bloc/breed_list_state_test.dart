
import 'package:dinder/pages/breed_list/breed_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Breed List State', () {
    test('supports value comparison', () {
      expect(BreedListInitial(), BreedListInitial());
      expect(
        BreedListInitial().toString(),
        BreedListInitial().toString(),
      );
    });

    test('loaded value comparison', () {
      const breeds = ["eskimo", "akita", "african"];
      final breedList = BreedListLoaded(breeds);
      expect(BreedListLoaded(breeds), breedList);
      expect(
        breedList.breeds.length,
        breeds.length,
      );
    });

    test('error value comparison', () {
      const error = "no internet connection";
      final breedErrorText = BreedListError(error);
      expect(BreedListError(error), breedErrorText);
      expect(
        breedErrorText.error,
        error,
      );
    });
  });
}