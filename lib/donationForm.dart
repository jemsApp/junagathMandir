import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mandir2/appcolor.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class donationForm extends StatefulWidget {
  const donationForm({Key? key}) : super(key: key);

  @override
  State<donationForm> createState() => _donationFormState();
}

class _donationFormState extends State<donationForm> {
  List<String> donationTitle = [
    "શ્રધ્દ્ધા અને ભાવના મુજબ",
    "શ્રી મહાપુજા",
    "શ્રી સિધ્ધેશ્વર મહાદેવ",
    "ઉજવણાં",
    "ગૌ સેવા ",
    "અન્ય"
  ];
  List donatinName = [
    [
      "શ્રી થાળના",
      "શ્રી ભેટ ના",
      "શ્રી ધર્માદા ના ( ૧૦% , ૫% અથવા યથાશક્તિ )",
      "શ્રી માનતા ના",
    ],
    [
      "એક દિવસના",
      "એક માસના",
      "એક વર્ષના",
      "આજીવન મહાપુજા (૨૦ વર્ષ)",
      "આજીવન મહાપુજા (કાયમી)",
    ],
    [
      "રુદ્રી (એક દિવસના )",
      "બીલીપત્ર (એક દિવસના)",
      "દૂધ (એક દિવસના )",
      "થાળ",
      "અભિષેક (ઓનલાઇન)",
      "અભિષેક",
      "અભિષેક (મશિવરાત્રિ તથ્ય શ્રાવણ મહિના ના સોમવાર )",
      "મૂર્તિ અભિષેક",
      "માનતાના",
    ],
    [
      "અગિયારસ ",
      "પૂનમ ",
      "નોમ ",
      "ઋષિ પંચમી ",
      "અમાસ ના ",
      "ધર્મરાજાના ",
      "સૂર્યનારાયણના",
    ],
    [
      "એક ગૌ ના ઘાસચારાના",
      "બધી ગાયો ના ઘાસચારાના ",
      "કપાસિયા ખોળ ગુણીના એકના ",
      "ગૌદાનના",
      "ગૌસેવાના ",
    ],
    [
      "જપાત્મક લઘુરુદ્ર",
      "હોમાત્મક લઘુરુદ્ર",
      "દેવોના પાંચ શિખરે ધજાના",
      "દેવોના એક શિખરે ધજાના",
      "શ્રી ગણપતિ પૂજન",
      "શ્રી હનુમાજી નું પૂજન",
    ]
  ];

  List donationPrice = [
    [0, 0, 0, 0],
    [02, 60, 730, 7300, 11000],
    [15, 15, 20, 500, 1100, 2500, 300, 25000, 0],
    [501, 501, 501, 501, 501, 551, 551],
    [100, 5000, 100, 2500, 0],
    [11000, 21000, 21000, 15000, 251, 251]
  ];

  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;

    makeEpandedTile(index, i) {
      return ListTile(
        minLeadingWidth: _w * 0.16,
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
              //padding: EdgeInsets.symmetric(vertical: _h(context)*0.007,horizontal: double.infinity),
              minimumSize: Size(_w * 0.07, _h * 0.04),
              primary: appcolor.basic[4],
              shape: StadiumBorder(side: BorderSide(width: 2))),
          child: Text(
            "Donate",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: _h * 0.02),
          ),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return formPage(donationPrice[index][i], donatinName[index][i]);
              },
            ));
          },
        ),
        title: Text(
          donatinName[index][i],
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange),
        ),
        leading: Text(
          donationPrice[index][i] != 0
              ? "${donationPrice[index][i]} Rs"
              : " યથાશક્તિ",
          style: TextStyle(fontSize: _w * 0.035, fontWeight: FontWeight.bold),
        ),
      );
    }

    return Scaffold(
      backgroundColor: appcolor.basic[0],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appcolor.appbarColor,
        title: Text("Donation"),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SizedBox(
          height: _h * 0.9,
          child: ListView.builder(
            itemCount: donationTitle.length,
            itemBuilder: (context, index) {
              int i = 0;
              return Card(
                color: appcolor.basic[1],
                child: ExpansionTile(
                  //collapsedTextColor: Colors.orange,
                  textColor: Color(0xFFAD4F04),
//collapsedBackgroundColor: appcolor.basic[0],
                  backgroundColor:appcolor.basic[0],
                  //childrenPadding: EdgeInsets.all(_w*0.02),

                  children: donatinName[index].map<ListTile>((e) {
                    return makeEpandedTile(index, i++);
                  }).toList(),
                  title: Text(
                    donationTitle[index],
                    style: TextStyle(
                      fontSize: _w * 0.05,
                    ),
                  ),
                  leading: Image(
                    image: AssetImage("img/donation.png"),
                    height: _h * 0.040,
                    width: _h * 0.04,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class formPage extends StatefulWidget {
  int price;
  String donationName;

  formPage(this.price, this.donationName);

  @override
  State<formPage> createState() => _formPageState();
}

class _formPageState extends State<formPage> {
  TextEditingController donationPrice_Tc = TextEditingController();
  TextEditingController yourName_Tc = TextEditingController();
  TextEditingController cityName_Tc = TextEditingController();
  TextEditingController mobile_Tc = TextEditingController();
  TextEditingController addres_Tc = TextEditingController();
  File? _file;
  String _fileName = "";
  bool isFilled = false;
  String mandirWhatsappNumber = "919879551680";

  @override
  Widget build(BuildContext context) {
    bool isPriceFix = widget.price != 0 ? true : false;
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: appcolor.appbarColor,
          title: Text("Donation Form"),
        ),
        backgroundColor: appcolor.basic[0],
        body: SizedBox(
            height: _h,
            width: _w,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(height: 100,),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(width: 2)),
                    //CircleBorder(side: BorderSide(width: 2, color: Colors.black)),
                    elevation: 12,
                    child: Container(
                      //  padding: EdgeInsets.all(100),
                      margin: EdgeInsets.all(10),
                      height: _h * 0.24,
                      width: _w * 0.45,
                      decoration: BoxDecoration(
                          color: Colors.white,
                        //  shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("img/payqr.jpeg"),
                              fit: BoxFit.contain)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Swaminarayan Mandir-Junagadh",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Text(
                    "Step-1 : Fill details\nStep-2 : Choose payment Screenshort\nStep-3 : Send to Whatsapp $mandirWhatsappNumber",
                    style: TextStyle(fontSize: _w * 0.04, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(14)),
                    child: TextField(
                      controller: yourName_Tc,
                      onChanged: (v) {
                        check();
                      },
                      // enableInteractiveSelection: false,
                      decoration: InputDecoration(
                        hintText: "Full Name",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(14)),
                    child: TextField(
                      controller: mobile_Tc,
                      keyboardType: TextInputType.number,
                      onChanged: (v) {
                        check();
                      },
                      // enableInteractiveSelection: false,
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  widget.price == 0
                      ? Container(
                          margin:
                              EdgeInsets.only(bottom: 20, right: 20, left: 20),
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(14)),
                          child: TextField(
                            controller: mobile_Tc,
                            keyboardType: TextInputType.number,
                            onChanged: (v) {
                              check();
                            },
                            // enableInteractiveSelection: false,
                            decoration: InputDecoration(
                              hintText: "Donation Amount",
                              border: InputBorder.none,
                            ),
                          ),
                        )
                      : SizedBox(
                          height: _h * 0.001,
                        ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(14)),
                    child: TextField(
                      controller: cityName_Tc,
                      onChanged: (v) {
                        check();
                      },
                      // enableInteractiveSelection: false,
                      decoration: InputDecoration(
                        hintText: "City",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(14)),
                    child: TextField(
                      controller: addres_Tc,
                      onChanged: (v) {
                        check();
                      },
                      // enableInteractiveSelection: false,
                      decoration: InputDecoration(
                        hintText: "Full address",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  //  SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      getFile();
                    },
                    icon: _fileName==""?
                    Icon(Icons.remove_done,color:Colors.white,)
                    :Icon(Icons.done_outline_rounded,color:Colors.green,),
                    label: Text("Choose Payment Screenshort",style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(_w*0.85, _h*0.05),
                        primary: Color(0xFFFFC88C)),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                      onPressed: () async {
                       if(isFilled)
                         {

                           Share.shareXFiles([XFile(_file!.path)],text:"દાન નું નામ -- ${widget.donationName}\n\nરકમ રૂપિયા -- ${widget.price}\n\nમારુ નામ -- ${yourName_Tc.text}\n\nશહેર / ગામ નું નામ -- ${cityName_Tc.text}\n\nમોબાઈલ નં -- ${mobile_Tc.text}\n\nપૂરું સરનામું -- ${addres_Tc.text}"
                           );
                         }
                       else
                         {
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                               content: Text("Please Fill all Detail")));
                         }

                      },
                      style: ElevatedButton.styleFrom(
                          primary: appcolor.basic[0], elevation: 0),
                      child: Container(
                        child: Center(
                            child: Text("Send To Whatsapp",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ))),
                        width: 350,
                        height: 50,
                        decoration: (BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: isFilled
                                ? Color(0xFDFA9745)
                                : appcolor.basic[2]

                        )),
                      )),
                  // Container(
                  //   width: double.infinity,
                  //   margin: EdgeInsets.all(_w * 0.03),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(20),
                  //       color: appcolor.basic[2]),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       Text(
                  //         "Choose Payment Screenshort",
                  //         style: TextStyle(
                  //             fontSize: 18,
                  //             fontWeight: FontWeight.w600,
                  //             color: appcolor.basic[4]),
                  //       ),
                  //       Text(
                  //         "${_fileName}",
                  //         style: TextStyle(fontSize: 17, color: Colors.grey),
                  //         textAlign: TextAlign.start,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            )));
  }

  Future getFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) {
      return;
    }

    final file1 = result.files.single.path!;
    File file = File(file1);
    _fileName = result.files.first.name;
    //  Share.shareXFiles([XFile(file.path)]);
    setState(() {
      _file = file;
      check();
    });
  }
  lounchWhatsapp()async{
  if (isFilled) {
    //  insertIt();
    //  var whatsApp_androidUrl=Uri.parse("whatsapp://send?phone="+mandirWhatsappNumber+"&text=hello");
    var ios_url = Uri.parse(
        "https://wa.me/$mandirWhatsappNumber?&text=${Uri.parse("")}");
    var android_url = Uri.parse("whatsapp://send/?phone=" +
        mandirWhatsappNumber +
        "&text=દાન નું નામ -- ${widget.donationName}\nરકમ રૂપિયા -- ${widget.price}\nમારુ નામ -- ${yourName_Tc.text}\nશહેર / ગામ નું નામ -- ${cityName_Tc.text}\nમોબાઈલ નં -- ${mobile_Tc.text}\nપૂરું સરનામું -- ${addres_Tc.text}"
    );
    // "&text=${Uri.parse("hello")}";

    if (Platform.isAndroid) {
      if (!await launchUrl(android_url)) {
        throw 'Could not launch $android_url';
      }
    } else {
      if (!await launchUrl(ios_url)) {
        throw 'Could not launch $android_url';
      }
    }
    // yourName_Tc.text = "";
    // mobile_Tc.text = "";
    // cityName_Tc.text = "";
    // addres_Tc.text = "";
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please Fill all Detail")));
  }
}
  check() {
    if (yourName_Tc.text == "") {
      isFilled = false;
    } else if (mobile_Tc.text == "") {
      isFilled = false;
    } else if (cityName_Tc.text == "") {
      isFilled = false;
    } else if (addres_Tc.text == "") {
      isFilled = false;
    }
    else if(_fileName==""){
      isFilled=false;
    }
    else {
      setState(() {
        isFilled = true;
      });
    }
  }
}
