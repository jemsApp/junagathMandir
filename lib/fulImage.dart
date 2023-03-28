
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mandir2/appcolor.dart';

import 'download_file.dart';

_h(BuildContext context) => MediaQuery.of(context).size.height;

_w(BuildContext context) => MediaQuery.of(context).size.width;

class fullImage extends StatefulWidget {
  String? url, todayDate;
  List<String> allPhoto;
  int mainIndex;

  fullImage(this.url, this.todayDate, this.mainIndex, this.allPhoto);

  @override
  State<fullImage> createState() => _fullImageState();
}

class _fullImageState extends State<fullImage> {
  PageController dailyDarshan_c = PageController();

  @override
  void initState() {
    super.initState();
    dailyDarshan_c = PageController(initialPage: widget.mainIndex);
  }


  @override
  Widget build(BuildContext context) {
    int currIndex = widget.mainIndex;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => DownloadingDialog(widget.url!,".jpg"),
          );
        },
        child: Icon(Icons.download),
        backgroundColor: appcolor.basic[4],
      ),
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: appcolor.appbarColor,
          title: Text("Daily Darshan ( ${widget.todayDate})")),
      body: SafeArea(
        child: Container(
          //padding: EdgeInsets.all(4),
          // margin: EdgeInsets.all(4),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(color: appcolor.basic[0]),
          child: PageView.builder(
            onPageChanged: (ind) {
              currIndex = ind;
            },
            //  scrollDirection: Axis.vertical,
            itemCount: widget.allPhoto.length,
            controller: dailyDarshan_c,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(4),
                height: _h(context) * 1,
                width: _w(context) * 1,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(widget.allPhoto[index]),
                        fit: BoxFit.contain)),
              );
            },
          ),
        ),
        // Container(
        //   height: double.infinity,
        //   width: double.infinity,
        //   child: Image(image: NetworkImage(widget.url)),
        // ),
      ),
    );
  }
}
