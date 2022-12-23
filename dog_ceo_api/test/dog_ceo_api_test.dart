import 'package:flutter_test/flutter_test.dart';

import 'package:dog_ceo_api/dog_ceo_api.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  test('Test getBreeds()', () async {
    final dio = Dio(BaseOptions());
    final dioAdapter = DioAdapter(dio: dio);

    const path = 'https://dog.ceo/api/breeds/list/all';
    final breedsMap = {'breed1': [], 'breed2': [], 'breed3': []};

    dioAdapter.onGet(
      path,
      (server) => server.reply(
        200,
        {'message': breedsMap},
        delay: const Duration(seconds: 1),
      ),
    );
    final api = DogCeoApi(dio);
    final response = await api.getBreeds();
    
    expect(response, equals(breedsMap.keys.toList()));
  });

  test('Test getBreedImages()', () async {
    final dio = Dio(BaseOptions());
    final dioAdapter = DioAdapter(dio: dio);
    const breed = 'breed1';
    const path = 'https://dog.ceo/api/breed/$breed/images/random/10';
    final images = ['image1', 'image2', 'image3'];

    dioAdapter.onGet(
      path,
      (server) => server.reply(
        200,
        {'message': images},
        delay: const Duration(seconds: 1),
      ),
    );
    final api = DogCeoApi(dio);

    final result = await api.getBreedImages('breed1');
    expect(result, equals(images));
  });
}
