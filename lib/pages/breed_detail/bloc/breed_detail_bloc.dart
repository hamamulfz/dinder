import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dog_ceo_api/dog_ceo_api.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'breed_detail_event.dart';
part 'breed_detail_state.dart';

class BreedDetailBloc extends Bloc<BreedDetailEvent, BredDetailState> {
  final DogCeoApi _repository;

  BreedDetailBloc(this._repository) : super(DogBreedInitial()) {
    on<DogBreedImageFetch>(_onDogSelect);
    on<DogBreedButtonLikeTapped>(_onDogLike);
    on<DogBreedButtonDislikeTapped>(_onDogDislikeSelect);
  }

  Future<FutureOr<void>> _onDogLike(
      DogBreedButtonLikeTapped event, Emitter<BredDetailState> emit) async {
    emit(DogBreedImagesLoaded.newIndex(event.images, event.currentIndex));
  }

  Future<FutureOr<void>> _onDogDislikeSelect(
      DogBreedButtonDislikeTapped event, Emitter<BredDetailState> emit) async {
    emit(DogBreedImagesLoaded.newIndex(event.images, event.currentIndex));
  }

  Future<FutureOr<void>> _onDogSelect(
      DogBreedImageFetch event, Emitter<BredDetailState> emit) async {
    emit(DogBreedImagesLoading());
    try {
      final images = await _repository.getBreedImages(event.breed);
      emit(DogBreedImagesLoaded(images, 0, false));
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.other:
          if (e.error is SocketException) {
            emit(DogBreedDetailError(
              "Socket Exception. Do you have active internet connection?",
            ));
          } else {
            emit(DogBreedDetailError(
              "Cannot identify errors.",
            ));
          }
          break;
        case DioErrorType.connectTimeout:
        case DioErrorType.receiveTimeout:
          emit(DogBreedDetailError("Connection Timeout"));

          break;
        case DioErrorType.response:
          emit(DogBreedDetailError("Fail to fetch data"));
          break;
        default:
      }
    } catch (e) {
      emit(DogBreedDetailError("Fail to fetch data"));
    }
  }
}
