import 'package:dinder/pages/breed_list/breed_list.dart';
import 'package:dio/dio.dart';
import 'package:dog_ceo_api/dog_ceo_api.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  final dio = Dio(BaseOptions());
  // final dioAdapter = DioAdapter(dio: dio);

  // const path = 'https://dog.ceo/api/breeds/list/all';
  // final breedsMap = {'breed1': [], 'breed2': [], 'breed3': []};
  // final result = ({'message': breedsMap}['message'] as Map<String, dynamic>)
  //     .keys
  //     .map((e) => e)
  //     .toList();

  final api = DogCeoApi(dio);

  test('initial state is PostState()', () {
    expect(BreedListBloc(api).state, BreedListInitial());
  });

  // group('PostFetched', () {
  //   blocTest<BreedListBloc, BreedListState>(
  //     'emits nothing when posts has reached maximum amount',
  //     setUp: () {
  //       dioAdapter.onGet(
  //         path,
  //         (server) => server.reply(
  //           200,
  //           {'message': breedsMap},
  //           delay: const Duration(seconds: 1),
  //         ),
  //       );
  //     },
  //     build: () => BreedListBloc(api),
  //     act: (bloc) => bloc.add(DogBreedFetch()),
  //     expect: () => [BreedListLoading()],
  //     verify: (_) {
  //       verify(() => dio.get(path)).called(1);
  //     },
  //   );
  // });
}
