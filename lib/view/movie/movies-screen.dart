import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/const/colors.dart';
import 'package:movie/view/movie/cubit.dart';
import 'item.dart';
import 'model.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  late List <ViewModel> allMovies;
  late List <ViewModel> searchForMovies;
  bool isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchFailed(){
    return TextField(
      controller: _searchTextController,
      cursorColor: Colors.grey,
      decoration: const InputDecoration(
          hintText: "Search Movie",
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.grey,fontSize: 18)
      ),
      style: const TextStyle(color: Colors.grey,fontSize: 18),
      onChanged: (searchForMoviesCharacter){
        addSearchedForItemToSearchedList(searchForMoviesCharacter);
      },
    );
  }
  void addSearchedForItemToSearchedList(String searchForMoviesCharacter){
    searchForMovies =allMovies.where((character) =>
        character.title.toLowerCase().
        startsWith(searchForMoviesCharacter)).toList();
    setState(() {

    });
  }
  List<Widget> _buildAppBarAction(){
    if(isSearching)
    {
      return [
        IconButton(onPressed: (){
          _clearSearch();
          Navigator.pop(context);},
            icon: const Icon(Icons.clear,color: Colors.grey,))
      ];

    }else{
      return [
        IconButton(onPressed: _startSearch,
            icon: const Icon(Icons.search_outlined,color: Colors.grey,))
      ];
    }
  }

  void _startSearch(){
    ModalRoute.of(context)?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));
    setState(() {
      isSearching = true;
    });
  }

  void _stopSearch(){
    _clearSearch();
    setState(() {
      isSearching = true;
    });
  }
  void _clearSearch(){
    _searchTextController.clear();
  }

  Text _buildAppBarTitle(){
    return const Text("Movie");
  }

  @override
  void initState() {
    super.initState();
    //  BlocProvider.of<MoviesCubit>(context).getData();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => MoviesCubit()..getData(),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colours.scafolldBgColor,
              leading:isSearching?BackButton(color: Colors.grey,):Container() ,
              elevation: 0,
              title: isSearching? _buildSearchFailed():_buildAppBarTitle(),
              actions: _buildAppBarAction(),
              centerTitle: true,

            ),
            body: BlocBuilder<MoviesCubit,MoviesStates>(
              buildWhen: (previous ,current )=> current is !GetMoviesFromPaginationLoadingState && current is !GetMoviesFromPaginationFailedState,
              builder: (context,state){
                if (state is GetMoviesLoadingState)
                {
                  return const Center(child: CircularProgressIndicator());
                } else if(state is GetMoviesFailedState)
                {
                  return  Center(child: Text(state.msg));
                }else if(state is GetMoviesSuccessState)
                {
                  allMovies = state.list;
                  return Column(
                    children: [
                      //   const SizedBox(height: 20,),
                      Expanded(
                        child: Container(
                          //  height: 600,
                          child: NotificationListener<ScrollNotification>(
                            onNotification: (notification){
                              // print(notification);
                              if(notification.metrics.pixels == notification.metrics.maxScrollExtent && notification is ScrollUpdateNotification){
                                print("loading");
                                MoviesCubit cubit = BlocProvider.of(context);
                                cubit.getData();
                              }
                              return true;
                            },
                            child: ListView.separated(
                                padding: EdgeInsets.all(12),
                                itemBuilder: (context,index) => item(model:_searchTextController.text.isEmpty? state.list[index] : searchForMovies[index],),
                                separatorBuilder: (context,index) => const SizedBox(height: 16,),
                                itemCount:_searchTextController.text.isEmpty? state.list.length:searchForMovies.length),
                          ),
                        ),
                      ),
                    ],
                  );
                }else{
                  return const Text("Un Handel State");
                }
              },
            ),
            bottomNavigationBar: SafeArea(
              child: SizedBox(
                height: 50,
                child: BlocBuilder<MoviesCubit,MoviesStates>(
                  buildWhen: (previous , current)=>current is GetMoviesFromPaginationLoadingState ||current is GetMoviesSuccessState || current is GetMoviesFromPaginationFailedState ,
                  builder: (context,state){
                    if(state is GetMoviesFromPaginationLoadingState){
                      return const Center(child: CircularProgressIndicator(),);

                    }else if (state is GetMoviesFromPaginationFailedState)
                    {
                      return Center(child: Text(state.msg),);

                    }else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ) ,
        ),
        );
    }
}
