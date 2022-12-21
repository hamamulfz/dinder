import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dog_ceo_api/dog_ceo_api.dart';
import 'package:meta/meta.dart';

part 'breed_detail_event.dart';
part 'breed_detail_state.dart';

class BreedDetailBloc extends Bloc<BreedDetailEvent, DogDetailState> {
  final DogCeoApi _repository;

  BreedDetailBloc(this._repository) : super(DogBreedInitial()) {
    on<DogBreedImageFetch>(_onDogSelect);
  }

  Future<FutureOr<void>> _onDogSelect(
      DogBreedImageFetch event, Emitter<DogDetailState> emit) async {
    emit(DogBreedImagesLoading());
    try {
      final images = await _repository.getBreedImages(event.breed);
      emit(DogBreedImagesLoaded(event.breed, images));
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.other:
          if (e.error is SocketException) {
            emit(DogBreedError(
              "Socket Exception. Do you have active internet connection?",
            ));
          } else {
            emit(DogBreedError(
              "Cannot identify errors.",
            ));
          }
          break;
        case DioErrorType.connectTimeout:
        case DioErrorType.receiveTimeout:
          emit(DogBreedError("Connection Timeout"));

          break;
        case DioErrorType.response:
          emit(DogBreedError("Fail to fetch data"));
          break;
        default:
      }
    } catch (e) {
      emit(DogBreedError("Fail to fetch data"));
    }
  }
}
