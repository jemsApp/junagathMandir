import 'package:flutter/material.dart';
import 'package:mandir2/appcolor.dart';

class aboutus extends StatefulWidget {
  const aboutus({Key? key}) : super(key: key);

  @override
  State<aboutus> createState() => _aboutusState();
}

_h(BuildContext context) => MediaQuery.of(context).size.height;

_w(BuildContext context) => MediaQuery.of(context).size.width;

class _aboutusState extends State<aboutus> {
  Widget makeSubRow(mainText, subText) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            mainText,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: _w(context) * 0.045,
                color: Color(0xFFF64B24)),
          ),
        ),
        Expanded(child: Text("-",style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: _w(context) * 0.045,
            color: Color(0xFF916258)),)),
        Expanded(
          flex: 9,
          child: Text(
            subText,
            softWrap: true,
            maxLines: 2,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: _w(context) * 0.043,
                color: Color(0xFFE76A1C)),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: appcolor.appbarColor,
          title: Text("About Us"),
        ),
        body: Container(
        //    height: _h(context) * 1,
         //   width: _w(context) * 1,
          decoration: BoxDecoration(color: appcolor.basic[0]),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        //  padding: EdgeInsets.all(100),
                        //margin: EdgeInsets.all(4),
                        height: _h(context) * 0.1,
                        width: _w(context) * 0.20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                           // shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(
                                    "img/photo_2022-12-08_10-02-00.jpg"),
                                fit: BoxFit.contain)),
                      ),
                      Text(
                        'જૂનાગઢ ધામમાં શ્રીજી મહારાજની પ્રસાદી\nનાં મુખ્ય સ્થળોની યાદી.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: _w(context) * 0.05,
                            color: Color(0xFF621212)),
                      )
                    ],
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Text(
                    "નીચે નાં સ્થળો મંદિર અંદરના છે",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _w(context) * 0.06,
                        color: Color(0xFFE76A1C)),
                  ),
                  Divider(
                    thickness: 3,
                    color: Colors.black,
                  ),
                ],
              ),
              SizedBox(
          height: _h(context)*0.65,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              makeSubRow("બ્રહ્મ કુંડ", "આ કુંડમાં વર્ણી વેશે શ્રી હરી મહારાજે સ્નાન કરેલ."),
              Divider(
                thickness: 2,
                // color: Colors.black,
              ),
              makeSubRow("શ્રી ભૂતનાથ મહાદેવ", "આ મંદિરમાં શ્રીજી મહારાજ એક રાત્રિ રોકાયા હતા."),
              Divider(
                thickness: 2,
                // color: Colors.black,
              ),
              makeSubRow("ધરમ અવેડા વાવ", "શ્રી મહારાજે જલપાન કરી વિસામો લીધેલ. (જફર મેદાન)"),
              Divider(
                thickness: 2,
                // color: Colors.black,
              ),
              makeSubRow("ગોધવાવની જગ્યા", "અહીં શ્રીજી મહારાજ ને જમતા જમતા સાતવાર ઉઠાડેલા અને લીમડા નીચે બ્રહ્મભોજન કરેલ."),
              Divider(
                thickness: 2,
                // color: Colors.black,
              ),
              makeSubRow("રાયણ ઝાડ", " જે અશોક શિલાલેખ પાસે છે તેની દાળ પકડી વિસામો લીધેલ. શ્રીજી મહારાજે વતુ કરાવી સોનરખ નદીમાં સ્નાન કરેલ."),
              Divider(
                thickness: 2,
                // color: Colors.black,
              ),
              makeSubRow("શ્રી રાધા ડેરી", " સોનરખ નદી નાં પુલ પાસે છે ત્યાં સિંહ ને ઓઠીગણ દઈ ત્રણ રાત્રિ નીલકંઠવર્ણી રોકાયા હતા."),
              Divider(
                thickness: 2,
                // color: Colors.black,
              ),
              makeSubRow("શ્રી દામોદર કુંડ", "રેવતી નદીમાં સ્નાન કરી દામોદરજી મંદિર માં ત્રણ રાત્રિ રોકાઈ બ્રાહ્મણોને પુષ્કળ દાન  આપેલી."),
              Divider(
                thickness: 2,
                // color: Colors.black,
              ),
              makeSubRow("નારાયણ ધરો", "અહીં શ્રીજી મહારાજે અનેક વખત સ્નાન કરેલ તેથી મહાપ્રસાદીનું સ્થળ છે."),
              Divider(
                thickness: 2,
                // color: Colors.black,
              ),
              makeSubRow("શ્રી ભવનાથ મહાદેવ", " ગિરનાર તળેટીમાં આવેલ આ મંદિરમાં દર્શન કરેલ તેમજ મૃગી કુંડમાં સ્નાન કરેલ."),
              Divider(
                thickness: 2,
                // color: Colors.black,
              ),
              makeSubRow("ચડાવવાવ", " ગિરનાર પહેલા પગથિયે આ વાવ આવેલ છે. તેમજ હનુમાનજી મંદિર છે તે સ્થળે શ્રીજી મહારાજે સ્નાન તથા  જલપાન કરેલ."),
              Divider(
                thickness: 2,
                // color: Colors.black,
              ),
              makeSubRow("ગિરનાર પર્વત", " અહીં સતદાસ ની જગ્યા, અંબાજી મંદિર, ગોરખ ઘુનો, કમંડલ કુંડ, ગુરુદેવ દતાત્ર્ય, પથ્થર ચટી વગેરે સ્થાનો માં શ્રીજી મહારાજ પધારેલા તેમજ ગિરનાર જતાં જકાતનાકા પાસે પુલ છે ત્યાં ક્ષોર કર્મ કરાવેલ."),
              Divider(
                thickness: 2,
                // color: Colors.black,
              ),
            ],
          ),
          ),
        )
            ],
          ),
        ));
  }
}
