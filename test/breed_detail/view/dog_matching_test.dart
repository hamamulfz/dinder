import 'package:bloc_test/bloc_test.dart';
import 'package:dinder/pages/breed_detail/breed_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: depend_on_referenced_packages
import 'package:mocktail/mocktail.dart';

class MockBreedDetailBloc extends MockBloc<BreedDetailEvent, BredDetailState>
    implements BreedDetailBloc {}

extension on WidgetTester {
  Future<void> pumpPostsList(BreedDetailBloc postBloc) {
    const breed = "america";
    return pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: postBloc,
          child: const Scaffold(body: DogMatching(breed: breed)),
        ),
      ),
    );
  }
}

void main() {
  late BreedDetailBloc breedBloc;

  setUp(() {
    breedBloc = MockBreedDetailBloc();
  });

  group('BreedDetail ', () {
    testWidgets(
        'renders CircularProgressIndicator '
        'when post status is initial', (tester) async {
      when(() => breedBloc.state).thenReturn(DogBreedDetailInitial());
      await tester.pumpPostsList(breedBloc);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'renders DogBreedImage '
        'when data returned successfully', (tester) async {
      when(() => breedBloc.state).thenReturn(
        DogBreedImagesLoaded(const [
          "https://images.dog.ceo/breeds/husky/n02110185_10955.jpg",
          "https://images.dog.ceo/breeds/husky/n02110185_120.jpg",
        ]),
      );
      await tester.pumpPostsList(breedBloc);
      expect(find.byType(DogBreedImage), findsOneWidget);

      await tester.tap(find.byIcon(Icons.favorite));
      expect(find.byType(LikeDislikeButton), findsOneWidget);


    });
  });
}
