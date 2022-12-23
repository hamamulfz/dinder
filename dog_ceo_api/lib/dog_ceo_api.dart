library dog_ceo_api;

// This is the repository that will be used to fetch data from the API.
import 'package:dio/dio.dart';

class DogCeoApi {
  final Dio _dio;

  DogCeoApi(this._dio);

  // Fetch the list of all dog breeds from the API.
  Future<List<String>> getBreeds() async {
    final response = await _dio.get('https://dog.ceo/api/breeds/list/all');
    

    List<String> list = (response.data['message'] as Map<String, dynamic>)
        .keys
        .map((e) => e)
        .toList();
    
    return list;
  }

  // Fetch the images for a specific breed from the API.
  Future<List<String>> getBreedImages(String breed) async {
    final response =
        await _dio.get('https://dog.ceo/api/breed/$breed/images/random/10');
    List<String> listImage = [];
    for (var element in (response.data['message'] as List)) {
      listImage.add(element);
    }
    return listImage;
  }
}
