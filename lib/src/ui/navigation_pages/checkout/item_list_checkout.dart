import 'package:bia_varzesh/src/ui/tools/text_style.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../size_config.dart';

class ItemListCheckOut extends StatelessWidget {
  Map data;
  ItemListCheckOut(this.data);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    int date = data["created_at"];
    var dateTimeStamp = new DateTime.fromMillisecondsSinceEpoch(date*1000);
    Jalali jalaliDate = Jalali.fromDateTime(dateTimeStamp);
    String showDate = "${jalaliDate.year}/${jalaliDate.month}/${jalaliDate.day}";
  return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal! *6,vertical: SizeConfig.safeBlockVertical! *2),
          child: Text(
            "مبلغ پرداختی : ${formatMony(data["amount"])} تومان",
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: txtStyle(Colors.green, "Vazir",
                SizeConfig.safeBlockHorizontal ! * 3.5),
          ),
        ),
       Padding(
         padding:  EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal! *6),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Text(
               "$showDate",
               textDirection: TextDirection.rtl,
               textAlign: TextAlign.center,
               style: txtStyle(Color(0xFF707070), "VazirBold",
                   SizeConfig.safeBlockHorizontal ! * 4),
             ),
             Text(
               "تاریخ پرداخت: ",
               textDirection: TextDirection.rtl,
               textAlign: TextAlign.center,
               style: txtStyle(Color(0xFF707070), "Vazir",
                   SizeConfig.safeBlockHorizontal ! * 4),
             ),
           ],
         ),
       ),

        Padding(
          padding:  EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal! *6,vertical: SizeConfig.safeBlockVertical! *2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "${data["system_track_code"]}",
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: txtStyle(Color(0xFF707070), "VazirBold",
                    SizeConfig.safeBlockHorizontal ! * 4),
              ),
              Text(
                "شماره پیگیری: ",
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: txtStyle(Color(0xFF707070), "Vazir",
                    SizeConfig.safeBlockHorizontal ! * 4),
              ),
            ],
          ),
        ),

        Padding(
          padding:  EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal! *6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "${data["shaba_code"]}",
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: txtStyle(Color(0xFF707070), "VazirBold",
                    SizeConfig.safeBlockHorizontal ! * 3.2),
              ),
              Text(
                "شماره شبا واریز شده: ",
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: txtStyle(Color(0xFF707070), "Vazir",
                    SizeConfig.safeBlockHorizontal ! * 3.2),
              ),
            ],
          ),
        ),
        Container(
          height: SizeConfig.safeBlockVertical! *2,
        )

      ],
    );
  }

  String formatMony(inputAmount) {
    int check;
    if (inputAmount is String) {
      check = int.parse(inputAmount);
    } else
      check = inputAmount;
    double check2 = check.toDouble();
    //FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
    //  amount: check2,
    //);
    String temp = "";//fmf.output.nonSymbol.toString();
    return temp.substring(0, (temp.length) - 3);
  }
}
