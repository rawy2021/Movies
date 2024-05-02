part of 'cubit.dart';
class GetMoviesDetailsStatus{}

class GetMoviesDetailsLoadingState extends GetMoviesDetailsStatus{}
class GetMoviesDetailsSuccessState extends GetMoviesDetailsStatus
{
  final MoviesDetails model;
  GetMoviesDetailsSuccessState({required this.model});
}
class GetMoviesDetailsFailedState extends GetMoviesDetailsStatus
{
  final String msg;
  GetMoviesDetailsFailedState({required this.msg});
}
