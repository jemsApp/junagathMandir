import 'dart:async';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mandir2/aboutus.dart';
import 'package:mandir2/appcolor.dart';
import 'package:mandir2/donationForm.dart';
import 'package:mandir2/controller/homePageSlider.dart';
import 'package:mandir2/fulImage.dart';
import 'package:mandir2/yotube.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'download_file.dart';
import 'loadReel.dart';


class home extends StatefulWidget {
  List<String> reelsUrl1;
  List<String> darshanUrl1;
  String ytUrl, ytImageUrl;

  home(this.reelsUrl1, this.darshanUrl1, this.ytUrl, this.ytImageUrl);

  @override
  State<home> createState() => _homeState();
}

_h(BuildContext context) => MediaQuery.of(context).size.height;

_w(BuildContext context) => MediaQuery.of(context).size.width;

Future<String> _saveDeviceToken() async {
  var dio = Dio();
  String? _deviceToken = "@";

  try {
    _deviceToken = await FirebaseMessaging.instance.getToken();
  } catch (e) {
    log("not get Firebase token");
    log("error == ${e}");
  }

  if (_deviceToken != null) {
    log("token added");
    var responce = await dio.get(
        "https://jemsdesai.000webhostapp.com/addUserToken.php?token=$_deviceToken");
  }

  return _deviceToken!;
}

class _homeState extends State<home> {
  final homeState_c = Get.put(homePage_c());
  List<String> reelsUrl = [];

  List<String> dailyDarshanUrl = [];
  int bottomBarIndex = 0;
  String todayDate = "";
  Timer? _timer;
  int curr_reel_index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          // LocalNotificationService.display(message);

        }
      },
    );

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
        }
      },
    );
    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
    _saveDeviceToken();
    _deleteImageFromCache();
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    todayDate = "${date.day}-${date.month}-${date.year}";
    //date.toString().replaceAll("00:00:00.000", "");
    log("Date = ${todayDate}");
    _timer = Timer.periodic(Duration(seconds: 8), (Timer timer) {
      if (homePage_c.currentPage.value < 2) {
        homePage_c.currentPage.value++;
      } else {
        homePage_c.currentPage.value = 0;
      }

      homeState_c.homePageEvent_c.animateToPage(
        homePage_c.currentPage.value,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
    reelsUrl = widget.reelsUrl1;
    dailyDarshanUrl = widget.darshanUrl1;
  }

  Future _deleteImageFromCache() async {
    String url = "https://jemsdesai.000webhostapp.com/dd/dd111.jpeg";
    await CachedNetworkImage.evictFromCache(url);
  }

  Widget makeMapButton(String url, String text) {
    return Row(
      children: [
        Expanded(
            flex: 7,
            child: InkWell(
              onTap: () async {
                var urllaunchable = await canLaunch(
                    url); //canLaunch is from url_launcher package
                if (urllaunchable) {
                  await launch(
                      url); //launch is from url_launcher package to launch URL
                } else {
                  print("URL can't be launched.");
                }
              },
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(7),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: appcolor.basic[0],
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: Image(image: AssetImage("img/mapicon2.png"))),
                    Expanded(child: SizedBox()),
                    Expanded(
                      flex: 8,
                      child: Text(
                        text,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 25,
                            color: appcolor.basic[5],
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }

  changePage(int selectedindex) {
    homeState_c.pages_c.jumpToPage(selectedindex);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //  log( "${dailyDarshanUrl[1]}");
    List mapPageWidgets = [
      Container(
        height: _h(context) * 0.6,
        width: _w(context) * 0.8,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/map1.jpg"), fit: BoxFit.fill)),
      ),
      Container(
          child: SizedBox(
        height: _h(context) * 0.87,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: _h(context) * 0.06,
                width: double.infinity,
                margin: EdgeInsets.all(_w(context) * 0.03),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff601212)),
                child: Text(
                  "Click to Open in Map",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffe5e2e2)),
                  // textAlign: TextAlign.center,
                ),
              ),
              makeMapButton("https://maps.app.goo.gl/1wnAaQ93ok5WnWuu6",
                  "જુનાગઢ થી દ્વારકા"),
              makeMapButton("https://maps.app.goo.gl/y5oadbXHtcX4skeH7",
                  "જુનાગઢ થી માંગરોળ"),
              makeMapButton("https://maps.app.goo.gl/T6t7rdiDugP3SoBz5",
                  "જુનાગઢ થી લોએજ"),
              makeMapButton("https://maps.app.goo.gl/c2xhn9LLH1V1qECg9",
                  "જુનાગઢ થી સોમનાથ"),
              makeMapButton("https://maps.app.goo.gl/H9Vv4c54Q7a22YWA8",
                  "જુનાગઢ થી કાલવાણી"),
              makeMapButton("https://maps.app.goo.gl/H9Xfg1skS3VGYdRb6",
                  "જુનાગઢ થી પંચાળા"),
              makeMapButton("https://maps.app.goo.gl/9RnXVEmMkhndGy4E7",
                  "જુનાગઢ થી પીપલાણા"),
              makeMapButton("https://maps.app.goo.gl/uvh9Rj21Y2SdiLYB6",
                  "જુનાગઢ થી સરધાર"),
            ],
          ),
        ),
      ))
    ];

    List<Widget> pages = [
      Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(7),
                height: _h(context) * 0.33,
                width: _w(context) * 1,
                decoration: BoxDecoration(
                    //border: Border.all(color:appcolor.basic[3],width: 10),
                    image: DecorationImage(
                        image: AssetImage("img/bk2.jpg"), fit: BoxFit.fill)),
                child: PageView.builder(
                  onPageChanged: (ind) {
                    homePage_c.currentPage.value = ind;
                  },
                  padEnds: true,
                  //     scrollDirection: Axis.vertical,
                  itemCount: 3,
                  controller: homeState_c.homePageEvent_c,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(_w(context) * 0.01),
                      height: _h(context) * 1,
                      width: _w(context) * 1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 3.5),
                          image: DecorationImage(
                              image: AssetImage("img/event$index.jpg"),
                              fit: BoxFit.fill)),
                    );
                  },
                ),
              ),
              Obx(() => AnimatedSmoothIndicator(
                  activeIndex: homePage_c.currentPage.value,
                  count: 3,
                  effect: JumpingDotEffect(
                    dotHeight: _h(context) * 0.01,
                    activeDotColor: appcolor.iconColor,
                    dotColor: appcolor.basic[3],
                  ))),
              SizedBox(
                height: _h(context) * 0.010,
              ),
              Container(
                alignment: Alignment.center,
                height: _h(context) * 0.05,
                width: _w(context) * 0.94,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        colors: [Color(0xFFCE6730), Color(0xFFFA894F)])),
                child: Text(
                  "Daily Darshan ( ${todayDate})",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: _h(context) * 0.026),
                ),
              ),
              SizedBox(
                height: _h(context) * 0.012,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFFA894F)),
                padding: EdgeInsets.symmetric(
                    vertical: _h(context) * 0.01,
                    horizontal: _w(context) * 0.04),
                height: _h(context) * 0.26,
                width: _w(context) * 0.94,
                child: SizedBox(
                  height: _h(context) * 0.25,
                  width: _w(context) * 0.87,
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      String url = dailyDarshanUrl[index];
                      log("${url}");
                      return InkWell(
                        onTap: () {
                          Get.to(() => fullImage(
                              url, todayDate, index, dailyDarshanUrl));
                        },
                        child: Card(
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.white)),
                          elevation: 12,
                          child: Container(
                            //  padding: EdgeInsets.all(100),
                            // margin: EdgeInsets.all(20),
                            height: _h(context) * 0.11,
                            width: _w(context) * 0.25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                // shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      dailyDarshanUrl[index],
                                    ),
                                    //NetworkImage(dailyDarshanUrl![index]),
                                    fit: BoxFit.cover)),
                          ),
                        ),

                        //    Container(
                        //      decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(20)
                        //      ),
                        //     height: _h(context)*0.08,
                        //     width: _w(context)*0.25,
                        //     alignment: Alignment.center,
                        //     child:  Image(image:NetworkImage(dailyDarshanUrl![0].toString()),fit: BoxFit.fill,)
                        // ),
                      );
                    },
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => youtubeDirect(widget.ytUrl));
                },
                child: Container(
                  height: _h(context) * 0.3,
                  width: double.infinity,
                  margin: EdgeInsets.all(_w(context) * 0.03),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: appcolor.basic[2]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "🔴Live : Swaminarayan Katha (Click)",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff601212)),
                        // textAlign: TextAlign.center,
                      ),
                      Container(
                        height: _h(context) * 0.25,
                        width: _w(context) * 0.85,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: appcolor.basic[2]),
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,

                          imageUrl: widget.ytImageUrl,
                          //  placeholder: (context, url) => CircularProgressIndicator(),
                          //    errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/bk2.jpg"), fit: BoxFit.fill)),
      ), // home page
      Container(
        child: Stack(
          children: [
            Container(
              color: Colors.black.withOpacity(0.7),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              ),
            ),
            PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: reelsUrl.length,
              controller: homeState_c.reelPage_c,
              onPageChanged: (ind) {
                curr_reel_index = ind;
              },
              itemBuilder: (context, index) {
                log("url == ${reelsUrl[index]}");
                return loadReel(reelsUrl[index], index);
              },
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        DownloadingDialog(reelsUrl[curr_reel_index], ".MP4"),
                  );
                },
                child: Container(
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.5),
                      shape: BoxShape.circle),
                  child: Icon(
                    Icons.download,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            InkWell(
              child: Container(
                height: _h(context) * 0.09,
                decoration: BoxDecoration(shape: BoxShape.circle),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/bk2.jpg"), fit: BoxFit.fill)),
      ), //Reels page
      Container(
        padding: EdgeInsets.all(10),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/bk2.jpg"), fit: BoxFit.fill)),
        child: Column(
          children: [
            Expanded(
              flex: 85,
              child: PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 4,
                controller: homeState_c.homePageView_c,
                itemBuilder: (context, index) {
                  return Container(
                    height: _h(context) * 1,
                    width: _w(context) * 1,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("img/pay${index + 1}.jpeg"),
                            fit: BoxFit.fill)),
                  );
                },
              ),
            ),
            SizedBox(
              height: _h(context) * 0.01,
            ),
            Expanded(
                flex: 8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      //padding: EdgeInsets.symmetric(vertical: _h(context)*0.007,horizontal: double.infinity),
                      minimumSize: Size(double.infinity, _h(context) * 0.007),
                      primary: appcolor.basic[4],
                      shape: StadiumBorder(side: BorderSide(width: 2))),
                  child: Text(
                    "Procced To Donate",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _h(context) * 0.025),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return donationForm();
                      },
                    ));
                  },
                ))
          ],
        ),
      ), //Donation Page
      Container(
        padding: EdgeInsets.all(8),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/bk2.jpg"), fit: BoxFit.fill)),
        child:SingleChildScrollView(
          child: Column(children: [
            Container(
              height: _h(context)*0.6,
              width: _w(context)*0.8,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("img/map1.jpg"), fit: BoxFit.fill)),
            ),
            Container(
                child: SizedBox(
                  height: _h(context)*0.87,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: _h(context)*0.06,
                          width: double.infinity,
                          margin: EdgeInsets.only(top:_w(context) * 0.03),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xff601212)),
                          child: Text(
                            "Open in Map",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffe5e2e2)),
                            // textAlign: TextAlign.center,
                          ),
                        ),
                        makeMapButton(
                            "https://maps.app.goo.gl/1wnAaQ93ok5WnWuu6", "જુનાગઢ થી દ્વારકા"),
                        makeMapButton(
                            "https://maps.app.goo.gl/y5oadbXHtcX4skeH7", "જુનાગઢ થી માંગરોળ"),
                        makeMapButton(
                            "https://maps.app.goo.gl/T6t7rdiDugP3SoBz5", "જુનાગઢ થી લોએજ"),
                        makeMapButton(
                            "https://maps.app.goo.gl/c2xhn9LLH1V1qECg9", "જુનાગઢ થી સોમનાથ"),
                        makeMapButton(
                            "https://maps.app.goo.gl/H9Vv4c54Q7a22YWA8", "જુનાગઢ થી કાલવાણી"),
                        makeMapButton(
                            "https://maps.app.goo.gl/H9Xfg1skS3VGYdRb6", "જુનાગઢ થી પંચાળા"),
                        makeMapButton(
                            "https://maps.app.goo.gl/9RnXVEmMkhndGy4E7", "જુનાગઢ થી પીપલાણા"),
                        makeMapButton(
                            "https://maps.app.goo.gl/uvh9Rj21Y2SdiLYB6", "જુનાગઢ થી સરધાર"),
                      ],
                    ),
                  ),
                ))
          ],),
        )

      ), //Map Page
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: appcolor.basic[3],
          selectedIconTheme: IconThemeData(color: appcolor.iconColor, size: 35),
          unselectedIconTheme: IconThemeData(color: appcolor.basic[3]),
          selectedLabelStyle:
              TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          selectedItemColor: appcolor.basic[4],
          showSelectedLabels: true,
          currentIndex: bottomBarIndex,
          onTap: (v) {
            bottomBarIndex = v;
            changePage(bottomBarIndex);
            //  log("${v}");
          },
          elevation: 10,
          //  type: BottomNavigationBarType.shifting,

          items: [
            BottomNavigationBarItem(
              backgroundColor: appcolor.bottomBarBackGround,
              label: "Home",
              icon: Icon(Icons.home_filled),
            ),
            BottomNavigationBarItem(
                label: "Reels",
                backgroundColor: appcolor.bottomBarBackGround,
                icon: Icon(Icons.play_circle_outline)),
            BottomNavigationBarItem(
                activeIcon: Image(
                  image: AssetImage("img/donation.png"),
                  height: _h(context) * 0.040,
                  width: _h(context) * 0.04,
                  color: appcolor.iconColor,
                ),
                backgroundColor: appcolor.bottomBarBackGround,
                label: "Donation",
                icon: Image(
                  alignment: Alignment.topCenter,
                  image: AssetImage("img/donation.png"),
                  height: _h(context) * 0.040,
                  width: _h(context) * 0.04,
                  color: appcolor.basic[3],
                )),
            BottomNavigationBarItem(
                activeIcon: Image(
                  alignment: Alignment.topCenter,
                  image: AssetImage("img/mapicon1.png"),
                  height: _h(context) * 0.033,
                  width: _h(context) * 0.04,
                  color: appcolor.iconColor,
                ),
                backgroundColor: appcolor.bottomBarBackGround,
                label: "PanchTithi",
                icon: Image(
                  image: AssetImage("img/mapicon1.png"),
                  height: _h(context) * 0.033,
                  width: _h(context) * 0.04,
                  color: appcolor.basic[3],
                ))
          ]),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appcolor.appbarColor,
        title: Text("Swaminarayan Mandir Junagadh"),
      ),
      drawer: Drawer(
        width: _w(context) * 0.67,
        backgroundColor: appcolor.basic[0],
        child: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  shape: CircleBorder(
                      side: BorderSide(width: 2, color: Colors.black)),
                  elevation: 12,
                  child: Container(
                    //  padding: EdgeInsets.all(100),
                    margin: EdgeInsets.all(20),
                    height: _h(context) * 0.20,
                    width: _w(context) * 0.40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image:
                                AssetImage("img/photo_2022-12-08_10-02-00.jpg"),
                            fit: BoxFit.contain)),
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                SizedBox(
                  height: _h(context) * 0.5,
                  width: _w(context) * 1,
                  child: ListView(
                    children: [
                      ListTile(
                        onTap: () {
                          bottomBarIndex = 0;
                          changePage(0);
                          Navigator.pop(context);
                        },
                        leading: Icon(
                          Icons.home_filled,
                          color: appcolor.iconColor,
                        ),
                        title: Text(
                          "Home",
                          style: TextStyle(
                              color: appcolor.basic[5],
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          bottomBarIndex = 1;
                          changePage(1);
                          Navigator.pop(context);
                        },
                        leading: Icon(
                          Icons.play_circle,
                          color: appcolor.iconColor,
                        ),
                        title: Text(
                          "Reels",
                          style: TextStyle(
                              color: appcolor.basic[5],
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          bottomBarIndex = 2;
                          changePage(2);
                          Navigator.pop(context);
                        },
                        leading: Image(
                          image: AssetImage("img/donation.png"),
                          height: _h(context) * 0.040,
                          width: _h(context) * 0.04,
                        ),
                        title: Text(
                          "Donation",
                          style: TextStyle(
                              color: appcolor.basic[5],
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          bottomBarIndex = 3;
                          changePage(3);
                          Navigator.pop(context);
                        },
                        leading: Image(
                          color: appcolor.iconColor,
                          image: AssetImage("img/mapicon1.png"),
                          height: _h(context) * 0.033,
                          width: _h(context) * 0.035,
                        ),
                        title: Text(
                          "Panchtithi Map",
                          style: TextStyle(
                              color: appcolor.basic[5],
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return aboutus();
                            },
                          ));
                        },
                        leading: Icon(
                          Icons.account_box_outlined,
                          color: appcolor.iconColor,
                        ),
                        title: Text(
                          "About Us",
                          style: TextStyle(
                              color: appcolor.basic[5],
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Powered By :",
                      style: TextStyle(fontWeight: FontWeight.w500),
                      textAlign: TextAlign.start,
                    ),
                    Image(
                      image: AssetImage("img/sidhlogo.png"),
                      height: _h(context) * 0.1,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: PageView.builder(
        onPageChanged: (ind) {
          setState(() {
            bottomBarIndex = ind;
          });
        },
        itemCount: 4,
        controller: homeState_c.pages_c,
        itemBuilder: (context, index) {
          return pages[index];
        },
      ),
    );
  }
}
