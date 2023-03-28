import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:path_provider/path_provider.dart';

class DownloadingDialog extends StatefulWidget {
  String url,type;

  DownloadingDialog(this.url,this.type);

  @override
  _DownloadingDialogState createState() => _DownloadingDialogState();
}

class _DownloadingDialogState extends State<DownloadingDialog> {
  Dio dio = Dio();
  double progress = 0.0;

  void startDownloading(String url) async {

     String fileName = "download--${Random().nextInt(1111111)}${widget.type}";
     final dir=Directory(await ExternalPath.getExternalStoragePublicDirectory(
         ExternalPath.DIRECTORY_DOWNLOADS));
    String path = "${dir.path}/${fileName}";
File file=File(path);
    await dio.download(
      url,
      path,
      onReceiveProgress: (recivedBytes, totalBytes) {
        setState(() {
          progress = recivedBytes / totalBytes;
        });

        print(progress);
      },
      deleteOnError: true,
    ).then((_) async {
      if(widget.type==".jpg")
        {

          await GallerySaver.saveImage(path,albumName: "Mandir Darshan");
          file.delete();
        }
      else{
        await GallerySaver.saveVideo(path,albumName: "Mandir Reels");
        file.delete();
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("File Saved in Gallery")));
      Navigator.pop(context);
    });
  }


  @override
 void initState() {
    super.initState();

    startDownloading(widget.url);

  }

  @override
  Widget build(BuildContext context) {
    String downloadingprogress = (progress * 100).toInt().toString();

    return AlertDialog(
      backgroundColor: Colors.black,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator.adaptive(),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Downloading: $downloadingprogress%",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}