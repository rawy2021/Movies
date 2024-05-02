part of 'cubit.dart';

class MoviesStates{}

class GetMoviesLoadingState extends MoviesStates{}
class GetMoviesFromPaginationLoadingState extends MoviesStates{}
class GetMoviesSuccessState extends MoviesStates
{
   final List<ViewModel> list;
   GetMoviesSuccessState({required this.list});
}
class GetMoviesFailedState extends MoviesStates
{
  final String msg;
  GetMoviesFailedState({required this.msg});
}
class GetMoviesFromPaginationFailedState extends MoviesStates
{
  final String msg;
  GetMoviesFromPaginationFailedState({required this.msg});
}