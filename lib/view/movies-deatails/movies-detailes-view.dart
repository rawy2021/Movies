import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/view/movies-deatails/cubit.dart';
import '../../const/colors.dart';
class MoviesDetailsView extends StatelessWidget {
  const MoviesDetailsView({super.key, required this.id});
  final int id;

  @override

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> MoviesDetailsCubit()..getData(id),
      child: Scaffold(
        appBar: AppBar(title:  const Text("Movies Details"),
        centerTitle: true,),
      body:BlocBuilder<MoviesDetailsCubit,GetMoviesDetailsStatus>(
        builder: (context,state){
          if(state is GetMoviesDetailsFailedState)
          {
            return const Center(child: Text("Failed"));
          }else if(state is GetMoviesDetailsSuccessState)
            {
              MoviesDetails model = state.model;
              return ListView(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Column(
                      children: [
                        Container(
                          height : 200,
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            model.backdropPath,
                            height: 160,
                            fit:BoxFit.cover ,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(model.title,
                                style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colours.ratingColor),),
                              const SizedBox(height: 5,),
                              Text(
                                model.originalTitle,
                                style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w300,color: Colours.ratingColor),),
                              const SizedBox(height: 5,),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(width: 5,),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.star_sharp,color: Colours.ratingColor ,),

                                        Text(model.voteAverage.toString(),
                                          style: TextStyle(fontWeight: FontWeight.w500,color: Colours.ratingColor),),
                                      ],
                                    ),
                                    const SizedBox(height: 5,),
                                    Text(model.releaseDate,
                                      style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colours.ratingColor),

                              ),
                                    const SizedBox(height: 5,),
                                    Text(model.budget.toString(),style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colours.ratingColor),),
                                    const SizedBox(height: 5,),
                                    Text(model.revenue.toString(),style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colours.ratingColor),),
                                    const SizedBox(height: 5,),
                                    Text(model.runtime.toString(),style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colours.ratingColor),),
                                    const SizedBox(height: 5,),
                                    Text(model.status.toString(),style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colours.ratingColor),),
                                    const SizedBox(height: 15,),

                                    Image.network(
                                      model.posterPath,
                                      height: 160,
                                      fit:BoxFit.cover ,),

                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              );

            }else
            {
              return const Center(child: CircularProgressIndicator());


            }
        },
      )
      ),
    );
  }

  TextStyle? _textWidget(){
      TextStyle(fontSize: 16,fontWeight: FontWeight.w300,color: Colours.ratingColor);
  }
}
