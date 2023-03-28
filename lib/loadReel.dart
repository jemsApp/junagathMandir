

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class loadReel extends StatefulWidget {
  String? src;
  int mainIndex;

  loadReel(this.src, this.mainIndex);

  @override
  State<loadReel> createState() => _loadReelState();
}

class _loadReelState extends State<loadReel> {
  ChewieController? chewie_c;
  late VideoPlayerController reelsVideo_c;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializePlayer();
  }

  // Future downloadFile(String ref) async {
  //  // log("Call downlod");
  //   final dir = Directory(await ExternalPath.getExternalStoragePublicDirectory(
  //       ExternalPath.DIRECTORY_DOWNLOADS));
  //  // log("got directory");
  //   final file = File("${dir.path}/reel-${Random().nextInt(100)}");
  //
  // }
  Future initializePlayer() async {
    reelsVideo_c = VideoPlayerController.network(widget.src!);
     await Future.wait([reelsVideo_c.initialize()]);

    chewie_c = ChewieController(
      videoPlayerController: reelsVideo_c,
      autoPlay: true,
      allowFullScreen: true,
      // overlay: reelsVideo_c.value.isPlaying
      //     ? SizedBox()
      //     : Container(
      //         height: double.infinity,
      //         width: double.infinity,
      //         color: Colors.black.withOpacity(0.5),
      //        // child: Icon(Icons.play_circle_outline),
      //       ),
      // fullScreenByDefault: true,
      //cupertinoProgressColors: ChewieProgressColors(playedColor: appcolor.basic[4],handleColor:appcolor.basic[4],backgroundColor: appcolor.basic[4] )
      looping: true,
      showControls: false,
      placeholder: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
      ),
    );
    setState(() {});
  }

  @override
  void dispose() {
    reelsVideo_c.dispose();
   chewie_c!.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        reelsVideo_c.value.isPlaying?reelsVideo_c.pause():reelsVideo_c.play();
     //   setState(() {});
      },
        child://VideoPlayer(reelsVideo_c)

        chewie_c != null &&
            reelsVideo_c !=null
            ? Chewie(controller:chewie_c!)
            : Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              )
    );
  }
}
///////////////////////////////////
/*
*
* */
