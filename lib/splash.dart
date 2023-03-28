import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mandir2/home.dart';
import 'package:permission_handler/permission_handler.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  List<String> reelsUrl=[];
  List<String> darshanUrl=[];
  String ytURL="",ytImageUrl="";

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
   getPermission();
   getImagePath();
  }

  getImagePath()async{
    List<String>darshanName;
    int i=1;
    var dio = Dio();
    final response = await dio.get('https://jemsdesai.000webhostapp.com/getDir.php?dir=dd').then((value){
      String resString=value.data;
      darshanName=resString.split("~");
      darshanName.removeLast();
      darshanName.forEach((e) {
        if(i==7)return;
       // log("${e}");
        darshanUrl.add("https://jemsdesai.000webhostapp.com/dd/${e}");
        i++;
      });
      darshanUrl.removeAt(0);

      getReelPath();
     // log("${darshanUrl}");
    });

  }
  getReelPath()async{
    List<String>reelsName;
    var dio = Dio();
    final response = await dio.get('https://jemsdesai.000webhostapp.com/getDir.php?dir=reels').then((value)
    {
    String resString =value.data;
        reelsName=resString.split("~");
    reelsName.removeLast();
    reelsName.forEach((e) {
      reelsUrl.add("https://jemsdesai.000webhostapp.com/reels/$e");
    });
    reelsUrl.removeAt(0);
    log("${reelsUrl}");
    getYTimage();
    });

  }
  getYTimage()async{

    List<String>reelsName;
    var dio = Dio();
    final response = await dio.get('https://jemsdesai.000webhostapp.com/getDir.php?dir=ytBanner').then((value){
      String ytString =value.data;
      List<String>temp=ytString.split("~");
      List<String>temp2=[];
      temp.removeLast();
      temp.forEach((e) {
        temp2.add("https://jemsdesai.000webhostapp.com/ytBanner/$e");
      });

      ytImageUrl=temp2[1];
      getYtId();
    });

  }

  getYtId()async{
    final dio=Dio();
    final response4 = await dio.get('https://jemsdesai.000webhostapp.com/getytUrl.php').then((value) {
      ytURL=value.data.toString();
     // log("${yturl}");
      redirect();
    });
  }
  redirect()async{
   // await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return home(reelsUrl,darshanUrl,ytURL,ytImageUrl);
    },));
  }

  getPermission()async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await [
        Permission.storage,
      ].request();
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    }
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Padding(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Image(image: AssetImage("img/photo_2022-12-08_10-02-00.jpg")),
        ),
      ),
    );
  }
}
