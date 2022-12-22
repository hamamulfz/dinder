

import 'package:dinder/pages/breed_list/view/breed_list_screen.dart';
import 'package:dinder/pages/breed_list/view/dog_breed_list.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BreedLisScreen', () {
    testWidgets('renders PostList', (tester) async {
      await tester.pumpWidget(MaterialApp(home: BreedListScreen()));
      await tester.pumpAndSettle();
      expect(find.byType(DogBreedList), findsOneWidget);
    });
  });
}