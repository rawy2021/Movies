import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model.dart';
part 'states.dart';

class MoviesCubit extends Cubit<MoviesStates>
{
  MoviesCubit():super(MoviesStates());

  final List<ViewModel> _list=[];
  int pageNumber =1;

  void getData({bool fromLoading = false}) async {
    if(fromLoading){
      emit(GetMoviesFromPaginationLoadingState());
    }else{
      emit(GetMoviesLoadingState());

    }

    try{
      var response = await Dio().get("https://api.themoviedb.org/3/discover/movie?api_key=2001486a0f63e9e4ef9c4da157ef37cd&page=$pageNumber");
      var model = MoviesData.fromJson(response.data);
      if(model.results.isNotEmpty){
        pageNumber++;
        _list.addAll(model.results);

      }
      emit(GetMoviesSuccessState(list: _list));
    }on DioException catch(ex){
      if (fromLoading){
        emit(GetMoviesFromPaginationFailedState(msg: ex.toString()));
      }
      emit(GetMoviesFailedState(msg: ex.toString()));
      
    }
  }

}