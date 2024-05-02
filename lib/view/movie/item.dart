import 'package:flutter/material.dart';
import 'package:movie/const/colors.dart';
import 'package:movie/view/movie/model.dart';
import 'package:movie/view/movies-deatails/movies-detailes-view.dart';

class item extends StatelessWidget {
  final ViewModel model;
  const item({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colours.ratingColor
      ),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MoviesDetailsView(id: model.id,)));
        },
        child: Row(
          children: [
            Expanded(
              child: Image.network(
                model.image,
                height: 160,
                fit:BoxFit.cover ,),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(model.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,

                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colours.scafolldBgColor),),
                    const SizedBox(height: 5,),
                    Text(
                      model.originalTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300,color: Colours.scafolldBgColor),),
                    SizedBox(height: 5,),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star_sharp,color: Colours.ratingColor ,),
                        SizedBox(width: 5,),
                        Text(model.voteAverage.toString(),
                          style: TextStyle(fontWeight: FontWeight.w500,color: Colours.ratingColor),)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}