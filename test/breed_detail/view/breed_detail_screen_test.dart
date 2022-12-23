

import 'package:dinder/pages/breed_detail/view/breed_detail_screen.dart';
import 'package:dinder/pages/breed_detail/view/dog_matching.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Breed Detail Screen', () {
    testWidgets('renders PostList', (tester) async {
      const breed = "african";
      await tester.pumpWidget(const MaterialApp(home: BreedDetailScreen(breed)));
      await tester.pumpAndSettle();
      expect(find.byType(DogMatching), findsOneWidget);
    });
  });
}