import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:dog_ceo_api/dog_ceo_api.dart';
import 'package:equatable/equatable.dart';

part 'breed_list_event.dart';
part 'breed_list_state.dart';


class BreedListBloc extends Bloc<BreedListEvent, BreedListState> {
  final DogCeoApi _repository;

  BreedListBloc(this._repository) : super(BreedListInitial()) {
    on<DogBreedFetch>(_onDogFetch);
  }

  _onDogFetch(event, emit) async {
    emit(BreedListLoading());
    try {
      final breeds = await _repository.getBreeds();
      emit(BreedListLoaded(breeds));
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.other:
          if (e.error is SocketException) {
            emit(BreedListError(
              "Socket Exception. Do you have active internet connection?",
            ));
          } else {
            emit(BreedListError(
              "Cannot identify errors.",
            ));
          }
          break;
        case DioErrorType.connectTimeout:
        case DioErrorType.receiveTimeout:
          emit(BreedListError("Connection Timeout"));

          break;
        case DioErrorType.response:
          emit(BreedListError("Fail to fetch data"));
          break;
        default:
      }
    } catch (e) {
      emit(BreedListError(e.toString()));
    }
  }
}
