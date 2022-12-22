
import 'package:dinder/pages/breed_list/breed_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PostState', () {
    test('supports value comparison', () {
      expect(BreedListInitial(), BreedListInitial());
      expect(
        BreedListInitial().toString(),
        BreedListInitial().toString(),
      );
    });
  });
}