import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class homePage_c extends GetxController{PageController homePageEvent_c=PageController(initialPage: 0);
PageController homePageView_c = PageController(initialPage: 0);
 PageController pages_c = PageController(initialPage: 0);
 PageController mapPage_c = PageController(initialPage: 0);
 PageController reelPage_c = PageController(initialPage: 0);

 static RxInt currentPage = 0.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    homePageEvent_c=PageController();
    currentPage.value=0;
  }
}