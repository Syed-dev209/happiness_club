import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happiness_club/constants/images.dart';
import 'package:happiness_club/widgets/snackBars.dart';
import 'package:video_player/video_player.dart';



class VideoPlayerScreen extends StatefulWidget {
  String videoUrl;
  VideoPlayerScreen({required this.videoUrl});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {

  String dummyUrl ="https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4";
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  initializePlayer()async{
    videoPlayerController = VideoPlayerController.network(
        widget.videoUrl);
    await videoPlayerController!.initialize();
    chewieController = ChewieController(
      fullScreenByDefault: true,
      placeholder: Center(
        child: getLoader(),
      ),
      videoPlayerController: videoPlayerController!,
      autoPlay: true,
      looping: false,
    );
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializePlayer();
    setState(() {

    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    videoPlayerController!.dispose();
    chewieController!.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Center(child: SvgPicture.asset(Images.BACK_BUTTON,height: 15,)),
        ),
      ),
      body: SafeArea(
        child: chewieController!=null?  Chewie(
          controller: chewieController!,
        ):getLoader(),
      ),
    );
  }
}
