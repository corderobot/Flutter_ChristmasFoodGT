import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:like_button/like_button.dart';

import  './main.dart';

class MyLikeButton extends StatelessWidget {
  final int nCompanyLike, nElementoLike;
  final Function changeLike;

  MyLikeButton(this.nCompanyLike, this.nElementoLike, this.changeLike);


  @override
  Widget build(BuildContext context) {
    bool second = false;

    return Align(
      alignment: Alignment.centerRight,
      child: LikeButton(
        size: 30,
        circleColor:
            CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
        bubblesColor: BubblesColor(
          dotPrimaryColor: Color(0xff33b5e5),
          dotSecondaryColor: Color(0xff0099cc),
        ),
        isLiked: productos[nCompanyLike-1][nElementoLike]["favorito"],
        likeBuilder: (bool isLiked) {
          if(second){
            productos[nCompanyLike-1][nElementoLike]["favorito"] = isLiked;
          }
          second = true;
          return Icon(
            Icons.favorite,
            color: productos[nCompanyLike-1][nElementoLike]["favorito"] ? Colors.red[800] : Colors.grey,
            size: 30,
          );
        },
      ),
    );
  }
}
