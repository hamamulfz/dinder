library dog_ceo_api;

// This is the repository that will be used to fetch data from the API.
import 'package:dio/dio.dart';

class DogCeoApi {
  final Dio _dio;

  DogCeoApi(this._dio);

  // Fetch the list of all dog breeds from the API.
  Future<List<String>> getBreeds() async {
    final response = await _dio.get('https://dog.ceo/api/breeds/list/all');
    print(response.data);

    List<String> list = (response.data['message'] as Map<String, dynamic>)
        .keys
        .map((e) => e)
        .toList();
    print(list);
    return list;
  }

  // Fetch the images for a specific breed from the API.
  Future<List<String>> getBreedImages(String breed) async {
    final response =
        await _dio.get('https://dog.ceo/api/breed/$breed/images/random/10');
    List<String> listImage = [];
    (response.data['message'] as List).forEach((element) {
      listImage.add(element);
    });
    return listImage;
  }
}
