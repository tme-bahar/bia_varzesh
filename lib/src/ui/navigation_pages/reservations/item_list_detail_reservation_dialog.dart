import 'package:bia_varzesh/src/ui/tools/text_style.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../size_config.dart';

class ItemListDetailReservationDialog extends StatelessWidget {
  Map data;
  ItemListDetailReservationDialog(this.data);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var dateTimeStamp = new DateTime.fromMillisecondsSinceEpoch(data["created_att"]*1000);
    Jalali jalaliDate = Jalali.fromDateTime(dateTimeStamp);
    String showDate = "${jalaliDate.year}/${jalaliDate.month}/${jalaliDate.day}";
    String clock = dateTimeStamp.toString();
    String realClock = clock.substring(11,16);
    print("$dateTimeStamp");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.safeBlockHorizontal ! * 3,
              vertical: SizeConfig.safeBlockVertical ! * 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                "$realClock-$showDate ",
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: txtStyle(Color(0xFf707070), "VazirBold",
                    SizeConfig.safeBlockHorizontal ! * 3.7),
              ),
              Text(
                "تاریخ و ساعت:  ",
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: txtStyle(Color(0xFf707070), "Vazir",
                    SizeConfig.safeBlockHorizontal ! * 3.7),
              )
            ],
          ),
        ),
//        Padding(
//          padding:  EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal! *3),
//          child: Text(
//            "شماره پیگیری: 123548",
//            textDirection: TextDirection.rtl,
//            textAlign: TextAlign.center,
//            style: txtStyle(
//                Colors.green, "Vazir", SizeConfig.safeBlockHorizontal ! * 3.3),
//          ),
//        ),
        Padding(
          padding:  EdgeInsets.only(left: SizeConfig.safeBlockHorizontal ! * 3,
              right: SizeConfig.safeBlockHorizontal ! * 3,
              bottom: SizeConfig.safeBlockVertical ! * 1),
          child: Text(
            "مبلغ پرداختی: ${formatMony(data["amount"])} تومان",
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: txtStyle(
                Colors.green, "Vazir", SizeConfig.safeBlockHorizontal ! * 3.3),
          ),
        ),
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
