
import 'package:dinder/pages/breed_list/breed_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Breed List Event', () {
    test('supports value comparison', () {
      expect(DogBreedFetch(), DogBreedFetch());
      expect(
        DogBreedFetch().toString(),
        DogBreedFetch().toString(),
      );
    });
  });
}