import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/constants/storage_keys.dart';
import 'package:happiness_club/modules/aboutUs/model/about_us_model.dart';
import 'package:happiness_club/modules/aboutUs/video_player_screen.dart';



class VideoCard extends StatelessWidget {
  AboutUsModelDataVideos videoModel;
  VideoCard({required this.videoModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (_)=>VideoPlayerScreen(videoUrl: videoModel.videoLink ?? "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4")));
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: CachedNetworkImageProvider(videoModel.videoImage ?? Constants.NOT_FOUND_IMAGE_URL),
            fit: BoxFit.cover
          )
        ),
      ),
    );
  }
}