import 'package:bloc_test/bloc_test.dart';
import 'package:dinder/pages/breed_list/breed_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: depend_on_referenced_packages
import 'package:mocktail/mocktail.dart';

class MockBreedListBloc extends MockBloc<BreedListEvent, BreedListState>
    implements BreedListBloc {}

extension on WidgetTester {
  Future<void> pumpPostsList(BreedListBloc postBloc) {
    return pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: postBloc,
          child: const Scaffold(body: DogBreedList()),
        ),
      ),
    );
  }
}

void main() {

  late BreedListBloc breedBloc;

  setUp(() {
    breedBloc = MockBreedListBloc();
  });

  group('BreedList', () {
    testWidgets(
        'renders CircularProgressIndicator '
        'when post status is initial', (tester) async {
      when(() => breedBloc.state).thenReturn(BreedListInitial());
      await tester.pumpPostsList(breedBloc);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'renders listTile '
        'when data returned successfully', (tester) async {
      when(() => breedBloc.state).thenReturn(
        BreedListLoaded(const ["afgan", 'african', "akita"]),
      );
      await tester.pumpPostsList(breedBloc);
      expect(find.byType(ListTile), findsNWidgets(3));
    });
  });
}
