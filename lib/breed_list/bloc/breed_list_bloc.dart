import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dog_ceo_api/dog_ceo_api.dart';
import 'package:meta/meta.dart';

part 'breed_list_event.dart';
part 'breed_list_state.dart';

// This is the BLoC that manages the state of the app.
class BreedListBloc extends Bloc<BreedListEvent, BreedListState> {
  final DogCeoApi _repository;

  BreedListBloc(this._repository) : super(DogBreedInitial()) {
    on<DogBreedFetch>(_onDogFetch);
  }

  _onDogFetch(event, emit) async {
    emit(DogBreedLoading());
    try {
      final breeds = await _repository.getBreeds();
      emit(DogBreedLoaded(breeds));
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
      emit(DogBreedError(e.toString()));
    }
  }
}
