import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'model.dart';
part 'states.dart';

class MoviesDetailsCubit extends Cubit<GetMoviesDetailsStatus>
{
  MoviesDetailsCubit():super(GetMoviesDetailsStatus());

  Future<void>getData(int id) async{
    emit(GetMoviesDetailsLoadingState());
    try{
      final response = await Dio().get("https://api.themoviedb.org/3/movie/$id?api_key=2001486a0f63e9e4ef9c4da157ef37cd");

      MoviesDetails model = MoviesDetails.fromJson(response.data);
      emit(GetMoviesDetailsSuccessState(model: model));
      print(model.title);
    } on DioException catch(ex){
      emit(GetMoviesDetailsFailedState(msg: ex.message??"Failed"));
    }
  }
}