import 'package:bia_varzesh/src/animation/bouncing_line.dart';
import 'package:bia_varzesh/src/models/general_model.dart';
import 'package:bia_varzesh/src/resources/share_prefs.dart';
import 'package:bia_varzesh/src/ui/navigation_pages/reservations/item_list_detail_reservation_dialog.dart';
import 'package:bia_varzesh/src/ui/tools/show_toast.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:jalali_calendar/jalali_calendar.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:share/share.dart';
import 'package:bia_varzesh/src/resources/api_provider.dart';

import '../../app.dart';
import '../size_config.dart';
import 'custom_button.dart';
import 'text_style.dart';

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
openQuestionDialog(BuildContext context) {
  SizeConfig().init(context);

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(23))),
          content: Container(
            decoration: BoxDecoration(),
            height: SizeConfig.safeBlockVertical !* 20,
            width: SizeConfig.screenWidth! - SizeConfig.safeBlockHorizontal !* 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
//                      top: SizeConfig.safeBlockVertical!*5
                      ),
                  child: Text(
                    "آیا مایل به خروج از برنامه هستید؟",
                    textDirection: TextDirection.rtl,
                    style: txtStyle(Color(0xFFAF2B1E), "VazirBold",
                        SizeConfig.safeBlockHorizontal !* 3.7),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Color(0xFFAF2B1E),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "خیر",
                            textDirection: TextDirection.rtl,
                            style: txtStyle(Colors.white, "VazirBold",
                                SizeConfig.safeBlockHorizontal !* 3.7),
                          ),
                        ),
                      ),
                    ),
                    RaisedButton(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                          side: BorderSide(color: Colors.green)),
                      onPressed: () {
                        Navigator.pop(context);
                        savePrivateToken("");
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return App();
                        }));
                      },
                      color: Colors.white,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "بله",
                            textDirection: TextDirection.rtl,
                            style: txtStyle(Colors.green, "VazirBold",
                                SizeConfig.safeBlockHorizontal !* 3.7),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      });
}

Future<Future> openSwitchedDialog(BuildContext context) async {
  SizeConfig().init(context);
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(23))),
          content: Container(
            height: SizeConfig.safeBlockVertical !* 37,
            width: SizeConfig.screenWidth! - SizeConfig.safeBlockHorizontal !* 16,
            child: Column(
              children: <Widget>[
                Text(
                  "آیا از تغییر وضعیت سالن مطمعن هستید؟",
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: txtStyle(Color(0xFF707070), "Vazir",
                      SizeConfig.safeBlockHorizontal !* 4),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.safeBlockVertical !* 3),
                  child: Text(
                    "توجه: در صورتی که وضعیت سالن را به حالت غیر فعال در می آورید بایستی با تماس با مالکین سانس های اجاره شده آنان را از وضعیت پیش آمده مطلع کنید. ",
                    textDirection: TextDirection.rtl,
                    style: txtStyle(Color(0xFFAF2B1E), "Vazir",
                        SizeConfig.safeBlockHorizontal !* 3.5),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22)),
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      color: Color(0xFFAF2B1E),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "خیر",
                            textDirection: TextDirection.rtl,
                            style: txtStyle(Colors.white, "VazirBold",
                                SizeConfig.safeBlockHorizontal !* 3.7),
                          ),
                        ),
                      ),
                    ),
                    RaisedButton(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                          side: BorderSide(color: Colors.green)),
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      color: Colors.white,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "بله",
                            textDirection: TextDirection.rtl,
                            style: txtStyle(Colors.green, "VazirBold",
                                SizeConfig.safeBlockHorizontal !* 3.7),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      });
}

openUserDescriptionDialog(BuildContext context, Map data) {
  SizeConfig().init(context);
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(23))),
          content: Container(
            height: SizeConfig.safeBlockVertical !* 30,
            width: SizeConfig.screenWidth! - SizeConfig.safeBlockHorizontal !* 40,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.safeBlockVertical !* 3),
                      child: Text(
                        "توضیحات بازیکن مورد نظر",
                        textDirection: TextDirection.rtl,
                        style: txtStyle(Color(0xFF707070), "VazirBold",
                            SizeConfig.safeBlockHorizontal !* 3.7),
                      ),
                    ),
                    Container(
                      width: SizeConfig.safeBlockHorizontal !* 9,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        "assets/images/icon_close.png",
                        color: Color(0xFFAF2B1E),
                        width: SizeConfig.safeBlockHorizontal !* 5,
                        height: SizeConfig.safeBlockHorizontal !* 5,
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.safeBlockHorizontal !* 2,
                      top: SizeConfig.safeBlockVertical !* 1,
                      right: SizeConfig.safeBlockHorizontal !* 2,
                      bottom: SizeConfig.safeBlockVertical !* 2),
                  child: Divider(
                    color: Color(0xFF707070),
                  ),
                ),
                Container(
                  height: SizeConfig.safeBlockVertical !* 15,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Text(
                        (data["content"] != null) ? "${data["content"]}" : "",
                        textDirection: TextDirection.rtl,
                        style: txtStyle(Color(0xFF707070), "Vazir",
                            SizeConfig.safeBlockHorizontal !* 3.5),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });
}

openDetailReservationDialog(BuildContext context, Map data, String clock,
    String date, String mobile, int remainableReceipt) {
  int isDongi = data["is_dongi"];
  List details =
      (isDongi == 0) ? data["reserve_beyane"] : data["reserve_dongi"];
  SizeConfig().init(context);
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(23))),
          content: Container(
              height: SizeConfig.safeBlockVertical !* 60,
              width:
                  SizeConfig.screenWidth! - SizeConfig.safeBlockHorizontal !* 10,
              child: ListView(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "نام رزرو کننده: ",
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: txtStyle(Color(0xFF707070), "Vazir",
                            SizeConfig.safeBlockHorizontal !* 3.7),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.safeBlockVertical !* 2),
                        child: Text(
                          "${data["player"]["name"]} ${data["player"]["family"]} ",
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: txtStyle(Color(0xFF707070), "VazirBold",
                              SizeConfig.safeBlockHorizontal !* 4),
                        ),
                      ),
                      Text(
                        "سانس $clock - $date ",
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: txtStyle(Color(0xFF707070), "Vazir",
                            SizeConfig.safeBlockHorizontal !* 3.7),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.safeBlockVertical !* 2),
                        child: Text(
                          "شماره موبایل:$mobile",
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: txtStyle(Color(0xFF707070), "Vazir",
                              SizeConfig.safeBlockHorizontal !* 3.7),
                        ),
                      ),
                      Text(
                        "کاربری مورد نظر: ${data["using_type"]}",
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: txtStyle(Color(0xFF707070), "VazirBold",
                            SizeConfig.safeBlockHorizontal !* 3.7),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.safeBlockVertical !* 2),
                        child: Text(
                          "پورسانت سیستم :${data["system_porsant"]} درصد",
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: txtStyle(Colors.green, "VazirBold",
                              SizeConfig.safeBlockHorizontal !* 3.7),
                        ),
                      ),
                      Text(
                        "مانده قابل دریافت: ${formatMony(remainableReceipt)} تومان",
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: txtStyle(Color(0xFF80251C), "VazirBold",
                            SizeConfig.safeBlockHorizontal !* 4.5),
                      ),
                      Divider(
                        color: Color(0xFF707070),
                      ),
                      Container(
                        height: SizeConfig.screenHeight! / 2.3,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: details.length,
                          itemBuilder: (BuildContext context, int position) {
                            return InkWell(
                                onTap: () {},
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Color(0xFFEBE8E8), width: 1),
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  margin: EdgeInsets.only(
                                    left: SizeConfig.safeBlockHorizontal !* 1,
                                    top: SizeConfig.safeBlockVertical !* 1.5,
                                    right: SizeConfig.safeBlockHorizontal !* 1,
                                    bottom: SizeConfig.safeBlockVertical !* 1.5,
                                  ),
                                  child: ItemListDetailReservationDialog(
                                      details[position]),
                                ));
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.safeBlockVertical !* 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ButtonTheme(
                                minWidth: SizeConfig.safeBlockHorizontal !* 47,
                                height: SizeConfig.safeBlockVertical !* 5,
                                child: RaisedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Share.share("${data["share_link"]}");
                                    },
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Color(0xFFAF2B1E)),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: SizeConfig.safeBlockVertical !* 1,
                                        right:
                                            SizeConfig.safeBlockHorizontal !* 1,
                                        bottom:
                                            SizeConfig.safeBlockVertical !* 1,
                                      ),
                                      child: SizedBox(
                                        height:
                                            SizeConfig.safeBlockVertical !* 5,
                                        width:
                                            SizeConfig.safeBlockHorizontal !* 47,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Image.asset(
                                              "assets/images/icon_share.png",
                                              width: SizeConfig
                                                      .safeBlockHorizontal !*
                                                  5,
                                              height: SizeConfig
                                                      .safeBlockHorizontal !*
                                                  6,
                                              fit: BoxFit.fill,
                                              color: Color(0xFFAF2B1E),
                                            ),
                                            Text(
                                              "اشتراک گذاری لینک پرداخت",
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                  color: Color(0xFFAF2B1E),
                                                  fontFamily: "Vazir",
                                                  fontSize: SizeConfig
                                                          .safeBlockHorizontal !*
                                                      3.2),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.safeBlockVertical !* 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            ButtonTheme(
                                minWidth: SizeConfig.safeBlockHorizontal !* 47,
                                height: SizeConfig.safeBlockVertical !* 5,
                                child: RaisedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      openUserDescriptionDialog(context, data);
                                    },
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Color(0xFFAF2B1E)),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: SizeConfig.safeBlockVertical !* 1,
                                        right:
                                            SizeConfig.safeBlockHorizontal !* 1,
                                        bottom:
                                            SizeConfig.safeBlockVertical !* 1,
                                      ),
                                      child: SizedBox(
                                        height:
                                            SizeConfig.safeBlockVertical !* 5,
                                        width:
                                            SizeConfig.safeBlockHorizontal !* 47,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Image.asset(
                                              "assets/images/icon_user.png",
                                              width: SizeConfig
                                                      .safeBlockHorizontal !*
                                                  5,
                                              height: SizeConfig
                                                      .safeBlockHorizontal !*
                                                  6,
                                              fit: BoxFit.fill,
                                              color: Color(0xFFAF2B1E),
                                            ),
                                            Text(
                                              "توضیحات بازیکن مورد نظر",
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                  color: Color(0xFFAF2B1E),
                                                  fontFamily: "Vazir",
                                                  fontSize: SizeConfig
                                                          .safeBlockHorizontal !*
                                                      3.2),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))),
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(bottom: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ButtonTheme(
                                minWidth: SizeConfig.safeBlockHorizontal !* 20,
                                height: SizeConfig.safeBlockVertical !* 5,
                                child: RaisedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        side:
                                            BorderSide(color: Color(0xFFAF2B1E)),
                                        borderRadius: BorderRadius.circular(30)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: SizeConfig.safeBlockVertical !* 1,
                                        right: SizeConfig.safeBlockHorizontal !* 1,
                                        bottom: SizeConfig.safeBlockVertical !* 1,
                                      ),
                                      child: SizedBox(
                                        height: SizeConfig.safeBlockVertical !* 5,
                                        width:
                                            SizeConfig.safeBlockHorizontal !* 20,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Icon(
                                              Icons.cancel,
                                              color: Color(0xFFAF2B1E),
                                              size:
                                                  SizeConfig.safeBlockHorizontal !*
                                                      7,
                                            ),
                                            Text(
                                              "بستن",
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                  color: Color(0xFFAF2B1E),
                                                  fontFamily: "Vazir",
                                                  fontSize: SizeConfig
                                                          .safeBlockHorizontal !*
                                                      3.2),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              )),
        );
      });
}

Future<bool?> openAgreementCancellation(
    BuildContext context, int id, int hallId) {
  SizeConfig().init(context);
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(23))),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState){
                  bool isLoading = false;
                  return Container(
                    height: SizeConfig.safeBlockVertical !* 27,
                    width:
                    SizeConfig.screenWidth! - SizeConfig.safeBlockHorizontal !* 10,
                    child: ListView(
                      children: <Widget>[
                        Text(
                          "لغو قرارداد ",
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: txtStyle(Color(0xFF707070), "VazirBold",
                              SizeConfig.safeBlockHorizontal !* 4),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.safeBlockVertical !* 1),
                          child: Text(
                            "آیا از لغو این قرارداد مطمین هستید؟ ",
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.right,
                            style: txtStyle(Color(0xFF707070), "Vazir",
                                SizeConfig.safeBlockHorizontal !* 3.9),
                          ),
                        ),
                        Text(
                          "توجه: حدف این قرارداد موجب آزاد شدن کلیه سانس های آن از سیستم میشود. ",
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: txtStyle(Color(0xFFAF2B1E), "Vazir",
                              SizeConfig.safeBlockHorizontal !* 3.8),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.only(top: SizeConfig.safeBlockVertical !* 3,
                              bottom: SizeConfig.safeBlockVertical!*1 ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Color(0xFFAF2B1E)),
                                    borderRadius: BorderRadius.circular(22)),
                                onPressed: () async {
                                  setState((){
                                    isLoading = true;
                                  }
                                  );
                                  String? token = await getToken();
                                  GeneralModel? response = await postDeleteContract(
                                      context, token!, hallId, id);
                                  setState((){
                                    isLoading = false;
                                  }
                                  );
                                  if (response?.success == true) {
                                    showToastModel(
                                        "${response?.message.toString()}",
                                        Colors.green,
                                        Colors.white,
                                        Toast.LENGTH_SHORT);
                                    Navigator.pop(context, true);
                                  } else {
                                    showToastModel("${response?.message.toString()}",
                                        Colors.red, Colors.white, Toast.LENGTH_SHORT);
                                    Navigator.pop(context, false);
                                  }
                                },
                                color: Colors.white,
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: (isLoading ==true)?
                                    /*LoadingBouncingLine.circle(
                                      backgroundColor: Colors.red.shade900,
                                      duration: Duration(milliseconds: 2400),
                                    )*/Text('data')
                                        :
                                    Text(
                                      "بله، حذف کن",
                                      textDirection: TextDirection.rtl,
                                      style: txtStyle(Color(0xFFAF2B1E), "VazirBold",
                                          SizeConfig.safeBlockHorizontal !* 3.5),
                                    ),
                                  ),
                                ),
                              ),
                              RaisedButton(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                color: Color(0xFFAF2B1E),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "خیر",
                                      textDirection: TextDirection.rtl,
                                      style: txtStyle(Colors.white, "Vazir",
                                          SizeConfig.safeBlockHorizontal !* 3.5),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
            )
        );
      });
}

openAgreementDetail(BuildContext context, Map data) {
  SizeConfig().init(context);
  List reserves = data["reserves"];

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(23))),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState){
                  bool isLoading = false;
                  return Container(
                      height: SizeConfig.safeBlockVertical !* 50,
                      width: SizeConfig.screenWidth! -
                          SizeConfig.safeBlockHorizontal !* 10,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: reserves.length,
                              itemBuilder: (BuildContext context, int position) {
                                int sansDate = reserves[position]["sans_date"];
                                var dateTimeStamp =
                                new DateTime.fromMillisecondsSinceEpoch(
                                    sansDate !* 1000);
                                Jalali finalDate = Jalali.fromDateTime(dateTimeStamp);
                                String strDate =
                                    "${finalDate.year}/${finalDate.month}/${finalDate.day}";
                                String startTime =
                                reserves[position]["sans"]["start_time"];
                                String endTime =
                                reserves[position]["sans"]["end_time"];
                                String sTime = startTime.substring(0, 5);
                                String eTime = endTime.substring(0, 5);

                                return InkWell(
                                    onTap: () {},
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Color(0xFFEBE8E8), width: 1),
                                        borderRadius: BorderRadius.circular(18.0),
                                      ),
                                      margin: EdgeInsets.only(
                                        left: SizeConfig.safeBlockHorizontal !* 1,
                                        top: SizeConfig.safeBlockVertical !* 1.5,
                                        right: SizeConfig.safeBlockHorizontal !* 1,
                                        bottom: SizeConfig.safeBlockVertical !* 1.5,
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              InkWell(
                                                onTap: () async {
                                                  Navigator.pop(context);
                                                  final result =
                                                  await openDialogCancelSans(
                                                      context,
                                                      reserves[position]
                                                      ["sans_id"],
                                                      data["hall_id"],
                                                      reserves[position]["id"],
                                                      strDate,
                                                      sTime,
                                                      eTime);
                                                  if (result == true)
                                                    reserves.removeAt(position);
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 7, right: 7),
                                                  child: Icon(
                                                    Icons.cancel,
                                                    color: Color(0xFFAF2B1E),
                                                    size: SizeConfig
                                                        .safeBlockHorizontal! !*
                                                        8,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "سانس $sTime تا $eTime",
                                            textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                                color: Color(0xFF707070),
                                                fontFamily: "VazirBold",
                                                fontSize:
                                                SizeConfig.safeBlockHorizontal! !*
                                                    3.5),
                                          ),
                                          Padding(
                                            padding:
                                            EdgeInsets.only(top: 3, bottom: 6),
                                            child: Text(
                                              "$strDate",
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                  color: Color(0xFF707070),
                                                  fontFamily: "VazirBold",
                                                  fontSize:
                                                  SizeConfig.safeBlockHorizontal! !*
                                                      3.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.safeBlockVertical !* 1),
                            child: ButtonTheme(
                                minWidth: SizeConfig.safeBlockHorizontal !* 20,
                                height: SizeConfig.safeBlockVertical !* 5,
                                child: RaisedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(color: Color(0xFFAF2B1E)),
                                        borderRadius: BorderRadius.circular(30)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: SizeConfig.safeBlockVertical !* 1,
                                        right: SizeConfig.safeBlockHorizontal !* 1,
                                        bottom: SizeConfig.safeBlockVertical !* 1,
                                      ),
                                      child: SizedBox(
                                        height: SizeConfig.safeBlockVertical !* 5,
                                        width: SizeConfig.safeBlockHorizontal !* 20,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Icon(
                                              Icons.cancel,
                                              color: Color(0xFFAF2B1E),
                                              size:
                                              SizeConfig.safeBlockHorizontal !* 7,
                                            ),
                                            Text(
                                              "بستن",
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                  color: Color(0xFFAF2B1E),
                                                  fontFamily: "Vazir",
                                                  fontSize:
                                                  SizeConfig.safeBlockHorizontal !*
                                                      4),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))),
                          ),
                        ],
                      ));
                }
            )
        );
      });
}

Future<bool?> openDialogCancelSans(BuildContext context, int id, int hallId,
    int reserveId, String date, String startTime, String endTime) {
  SizeConfig().init(context);
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(23))),
            content: Container(
              height: SizeConfig.safeBlockVertical !* 32,
              width:
                  SizeConfig.screenWidth! - SizeConfig.safeBlockHorizontal !* 10,
              child: ListView(
                children: <Widget>[
                  Text(
                    "سانس $startTime تا $endTime-$date ",
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: txtStyle(Color(0xFF707070), "VazirBold",
                        SizeConfig.safeBlockHorizontal !* 4),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.safeBlockVertical !* 1),
                    child: Text(
                      "آیا از حذف این سانس از قرارداد مطمین هستید؟ ",
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: txtStyle(Color(0xFF707070), "Vazir",
                          SizeConfig.safeBlockHorizontal !* 3.9),
                    ),
                  ),
                  Text(
                    "توجه: حدف سانس موجب آزاد شدن آن و امکان رزرو از سمت سیستم میشود. ",
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: txtStyle(Color(0xFFAF2B1E), "Vazir",
                        SizeConfig.safeBlockHorizontal !* 3.8),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: SizeConfig.safeBlockVertical !* 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Color(0xFFAF2B1E)),
                              borderRadius: BorderRadius.circular(22)),
                          onPressed: () async {
                            String? token = await getToken();
                            GeneralModel? response =
                                await postDeleteReserveContract(
                                    context, token!, id, hallId, reserveId);
                            if (response?.success == true) {
                              showToastModel(
                                  "${response?.message.toString()}",
                                  Colors.green,
                                  Colors.white,
                                  Toast.LENGTH_SHORT);
                              Navigator.pop(context, true);
                            } else {
                              showToastModel("${response?.message.toString()}",
                                  Colors.red, Colors.white, Toast.LENGTH_SHORT);
                              Navigator.pop(context, false);
                            }
                          },
                          color: Colors.white,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "بله، حذف کن",
                                textDirection: TextDirection.rtl,
                                style: txtStyle(Color(0xFFAF2B1E), "VazirBold",
                                    SizeConfig.safeBlockHorizontal !* 3.5),
                              ),
                            ),
                          ),
                        ),
                        RaisedButton(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          color: Color(0xFFAF2B1E),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "خیر",
                                textDirection: TextDirection.rtl,
                                style: txtStyle(Colors.white, "Vazir",
                                    SizeConfig.safeBlockHorizontal !* 3.5),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));
      });
}

Future<Future> openDialogWeeklySchedule(
    BuildContext context, List<Map> sansData, int hallId) async {
  SizeConfig().init(context);
  bool? confirmation = false;
  bool? isDate = false;
  String? contractContent;
  String _fromDate = '';
  int? _selectedSalonState;
  bool isLoadingRecord = false;
  List<DropdownMenuItem<int>> salonStateList = [];
  final _contractController = new TextEditingController();
  salonStateList = [];
  salonStateList.add(new DropdownMenuItem(
    child: new Text(
      "آزاد",
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
    ),
    value: 0,
  ));
  salonStateList.add(new DropdownMenuItem(
      child: new Text(
        "رزرو داخلی",
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
      ),
      value: 1));
  salonStateList.add(new DropdownMenuItem(
    child: new Text(
      "آزاد-عدم نمایش در سیستم",
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
    ),
    value: 2,
  ));

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(23))),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              Future _selectFromDate() async {
                String picked = "";//await jalaliCalendarPicker(context: context,selectedFormat: "yyyy/mm/dd",);
                if (picked != null) {
                  String strYear = picked.substring(0, 4);
                  String strMonth = picked.substring(5, 7);
                  setState(() {
                    _fromDate = picked.toString();
                  });
                }
              }

              return Container(
                height: SizeConfig.safeBlockVertical !* 60,
                width: SizeConfig.screenWidth! -
                    SizeConfig.safeBlockHorizontal !* 10,
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.cancel,
                            color: Color(0xFFAF2B1E),
                            size: SizeConfig.safeBlockHorizontal !* 8,
                          ),
                        )
                      ],
                    ),
                    Text(
                      "وضعیت سالن :",
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: txtStyle(Color(0xFF707070), "VazirBold",
                          SizeConfig.safeBlockHorizontal !* 4),
                    ),
                    Container(
                      height: SizeConfig.safeBlockVertical !* 2,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.safeBlockHorizontal !* 4),
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.safeBlockHorizontal !* 5,
                                right: SizeConfig.safeBlockHorizontal !* 5),
                            child: Container(
                              height: SizeConfig.safeBlockVertical !* 6,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: new Text(
                                    'آزاد',
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.center,
                                    style: txtStyle(Color(0xFFA0A0A0), "Vazir",
                                        SizeConfig.safeBlockHorizontal !* 3.3),
                                  ),
                                  style: txtStyle(Color(0xFF707070), "Vazir",
                                      SizeConfig.safeBlockHorizontal !* 3.7),
                                  items: salonStateList,
                                  value: _selectedSalonState,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedSalonState = value as int?;
                                    });
                                  },
                                  isExpanded: false,
                                ),
                              ),
                            ),
                          ),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1.0,
                                style: BorderStyle.solid,
                                color: Color(0xFF707070),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.safeBlockVertical !* 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: SizeConfig.safeBlockVertical !* 1),
                                child: Text(
                                  "این رزرو یک قرارداد توسط سالن حساب شود. ",
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.center,
                                  style: txtStyle(
                                      const Color(0xFF707070),
                                      "VazirBold",
                                      SizeConfig.safeBlockHorizontal !* 3),
                                ),
                              )),
                          Checkbox(
                              value: confirmation,
                              onChanged: (bool? value) {
                                setState(() {
                                  confirmation = value;
                                });
                              }),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.safeBlockHorizontal !* 5),
                      child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            child: TextFormField(
                              controller: _contractController,
                              minLines: 4,
                              maxLines: 8,
                              onChanged: (String value) {
                                setState(() {
                                  confirmation = true;
                                });
                              },
                              style: const TextStyle(
                                  color: Colors.black, fontFamily: "Vazir"),
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                  labelText: "قرارداد",
                                  labelStyle: TextStyle(
                                      color: Colors.black45,
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal !* 3.2),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: Color(0xFF3498DB),
                                          width: 2.0)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                              validator: (value) {
                                if(value !=null){
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      contractContent = value;
                                    });
                                  }
                                }
                              },
                            ),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.safeBlockVertical !* 1,
                          bottom: SizeConfig.safeBlockVertical !* 2),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: SizeConfig.safeBlockVertical !* 2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        "انتخاب این سانس در کلیه هفته ها تا تاریخ: ",
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center,
                                        style: txtStyle(
                                            Color(0xFF707070),
                                            "VazirBold",
                                            SizeConfig.safeBlockHorizontal !* 3),
                                      )),
                                  Checkbox(
                                      value: isDate,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isDate = value;
                                        });
                                      }),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: SizeConfig.safeBlockVertical !* 2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: SizeConfig.safeBlockHorizontal !* 34,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: SizeConfig.safeBlockHorizontal !*
                                              3,
                                          top: SizeConfig.safeBlockVertical !*
                                              1.5,
                                          right:
                                              SizeConfig.safeBlockHorizontal !*
                                                  3,
                                          bottom: SizeConfig.safeBlockVertical !*
                                              1.5),
                                      child: Center(
                                        child: Text(
                                          "$_fromDate",
                                          textDirection: TextDirection.rtl,
                                          style: txtStyle(
                                              Color(0xFF707070),
                                              "Vazir",
                                              SizeConfig.safeBlockHorizontal !*
                                                  3.3),
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(0xFF707070),
                                          width: 1,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            SizeConfig.safeBlockHorizontal !* 3,
                                        right:
                                            SizeConfig.safeBlockHorizontal !* 5),
                                    child: InkWell(
                                      child: Image.asset(
                                        "assets/images/icon_calendar.png",
                                        fit: BoxFit.fill,
                                        color: Color(0xFFB72415),
                                        width:
                                            SizeConfig.safeBlockHorizontal !* 8,
                                        height:
                                            SizeConfig.safeBlockHorizontal !* 8,
                                      ),
                                      onTap: _selectFromDate,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.safeBlockHorizontal !* 15),
                      child: ButtonTheme(
                        minWidth: SizeConfig.safeBlockHorizontal !* 15,
                        height: SizeConfig.safeBlockVertical !* 6,
                        child: CustomButton(
                          onPress: () async {
                            String status = "";
                            switch (_selectedSalonState) {
                              case 0:
                                {
                                  status = "free";
                                }
                                break;
                              case 1:
                                {
                                  status = "internal";
                                }
                                break;
                              case 2:
                                {
                                  status = "disable";
                                }
                                break;
                            }
                            setState(() {
                              isLoadingRecord = true;
                            });
//                            String finalTillDate="";
//                            String finalContract="";
//                            (confirmation == true)
//                                ? finalContract = contractContent
//                                : finalContract = "";
//                            (isDate == true)
//                                ? finalTillDate = _fromDate
//                                : finalTillDate = "";
                            String? token = await getToken();
                            GeneralModel? updateModel = await postWeeklySchedule(
                                context,
                                token!,
                                hallId,
                                sansData,
                                status,
                                _fromDate,
                                _contractController.text);

                            setState(() {
                              isLoadingRecord = false;
                            });
                            if (updateModel?.success == true) {
                              showToastModel(
                                  "${updateModel?.message.toString()}",
                                  Colors.green,
                                  Colors.white,
                                  Toast.LENGTH_SHORT);
                              Navigator.pop(context, true);
                            } else {
                              showToastModel(
                                  "${updateModel?.message.toString()}",
                                  Colors.red,
                                  Colors.white,
                                  Toast.LENGTH_SHORT);
                              Navigator.pop(context, false);
                            }
                          },
                          text: "ویرایش",
                          icon: Icon(
                            Icons.check_circle_outline,
                            color: Colors.white,
                          ),
                          color: Colors.green,
                          isLoading: isLoadingRecord,
                          txtStyle: txtStyle(Colors.white, "Vazir",
                              SizeConfig.safeBlockHorizontal !* 3.2), borderRadiuse: 1.0,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }));
      });
}

Future<bool?> openGallerySecurityAlertBox(
    BuildContext context, int index, int id, int hallId) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding:
              EdgeInsets.only(top: SizeConfig.blockSizeHorizontal !* 5),
          content: Container(
            height: SizeConfig.safeBlockVertical !* 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal!*8),
                  child: Text(
                    "آیا میخواهید عکس مربوطه را حذف کنید؟",
                    textDirection: TextDirection.rtl,
                    style:
                        TextStyle(fontSize: SizeConfig.blockSizeHorizontal !* 4.3),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(bottom: SizeConfig.safeBlockVertical!*5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Color(0xFFAF2B1E)),
                            borderRadius: BorderRadius.circular(22)),
                        onPressed: () async {
                          String? token = await getToken();
                          GeneralModel? response =
                              await deleteImagePost(context, token!, hallId, id);
                          if (response?.success == true) {
                            showToastModel("${response?.message.toString()}",
                                Colors.green, Colors.white, Toast.LENGTH_SHORT);
                            Navigator.pop(context, true);
                          } else {
                            showToastModel(
                                "${response?.message.toString()}",
                                Colors.red.shade900,
                                Colors.white,
                                Toast.LENGTH_SHORT);
                            Navigator.pop(context, false);
                          }
                        },
                        color: Colors.white,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "بله، حذف کن",
                              textDirection: TextDirection.rtl,
                              style: txtStyle(Color(0xFFAF2B1E), "VazirBold",
                                  SizeConfig.safeBlockHorizontal !* 3.5),
                            ),
                          ),
                        ),
                      ),
                      RaisedButton(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        color: Color(0xFFAF2B1E),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "خیر",
                              textDirection: TextDirection.rtl,
                              style: txtStyle(Colors.white, "Vazir",
                                  SizeConfig.safeBlockHorizontal !* 3.5),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

openDeleteAdditionsDialog(BuildContext context, int id, int hallId) {
  SizeConfig().init(context);

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(23))),
          content: Container(
            decoration: BoxDecoration(),
            height: SizeConfig.safeBlockVertical !* 20,
            width: SizeConfig.screenWidth! - SizeConfig.safeBlockHorizontal !* 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(),
                  child: Text(
                    "آیا مایل به حذف این مورد هستید؟",
                    textDirection: TextDirection.rtl,
                    style: txtStyle(Color(0xFFAF2B1E), "VazirBold",
                        SizeConfig.safeBlockHorizontal !* 3.7),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22)),
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      color: Color(0xFFAF2B1E),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "خیر",
                            textDirection: TextDirection.rtl,
                            style: txtStyle(Colors.white, "VazirBold",
                                SizeConfig.safeBlockHorizontal !* 3.7),
                          ),
                        ),
                      ),
                    ),
                    Builder(builder: (BuildContext context) {
                      return RaisedButton(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                            side: BorderSide(color: Colors.green)),
                        onPressed: () async {
                          String? token = await getToken();
                          GeneralModel? response =
                              await deleteSalonAdditionsPost(
                                  context, token!, id, hallId);
                          if (response?.success == true) {
                            showToastModel("${response?.message}", Colors.green,
                                Colors.white, Toast.LENGTH_SHORT);
                            Navigator.pop(context, true);
                          } else {
                            Navigator.pop(context, false);
                            showToastModel("${response?.message}", Colors.red,
                                Colors.white, Toast.LENGTH_SHORT);
                          }
                        },
                        color: Colors.white,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "بله",
                              textDirection: TextDirection.rtl,
                              style: txtStyle(Colors.green, "VazirBold",
                                  SizeConfig.safeBlockHorizontal !* 3.7),
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                )
              ],
            ),
          ),
        );
      });
}

openDeleteDiscountCode(BuildContext context, int id, int hallId) {
  SizeConfig().init(context);

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(23))),
          content: Container(
            decoration: BoxDecoration(),
            height: SizeConfig.safeBlockVertical !* 20,
            width: SizeConfig.screenWidth! - SizeConfig.safeBlockHorizontal !* 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
//                      top: SizeConfig.safeBlockVertical!*5
                      ),
                  child: Text(
                    "آیا مایل به حذف تخفیف هستید؟",
                    textDirection: TextDirection.rtl,
                    style: txtStyle(Color(0xFFAF2B1E), "VazirBold",
                        SizeConfig.safeBlockHorizontal !* 3.7),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22)),
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      color: Color(0xFFAF2B1E),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "خیر",
                            textDirection: TextDirection.rtl,
                            style: txtStyle(Colors.white, "VazirBold",
                                SizeConfig.safeBlockHorizontal !* 3.7),
                          ),
                        ),
                      ),
                    ),
                    RaisedButton(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                          side: BorderSide(color: Colors.green)),
                      onPressed: () async {
                        String? token = await getToken();
                        GeneralModel? response =
                            await postDeleteDiscountManagement(
                                context, token!, hallId, id);
                        if (response?.success == true) {
                          showToastModel(" عملیات با موفقیت انجام شد",
                              Colors.green, Colors.white, Toast.LENGTH_SHORT);
                          Navigator.pop(context, true);
                        } else {
                          showToastModel("عملیات با خطا انجام شد", Colors.red,
                              Colors.white, Toast.LENGTH_SHORT);
                          Navigator.pop(context, false);
                        }
                      },
                      color: Colors.white,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "بله",
                            textDirection: TextDirection.rtl,
                            style: txtStyle(Colors.green, "VazirBold",
                                SizeConfig.safeBlockHorizontal !* 3.7),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      });
}

Future<bool?> openGenderDialog(
    BuildContext context, List sansData, int hallId) async {
  SizeConfig().init(context);
  bool? male = false;
  bool? female = false;
  bool? both = false;
  bool isLoadingEdit = false;

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(23))),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: SizeConfig.safeBlockVertical !* 25,
                width: SizeConfig.screenWidth! -
                    SizeConfig.safeBlockHorizontal !* 10,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.safeBlockHorizontal !* 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Checkbox(
                                  value: female,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      female = value;
                                    });
                                  }),
                              Text(
                                "بانوان",
                                textDirection: TextDirection.rtl,
                                style: txtStyle(Color(0xFF707070), "Vazir",
                                    SizeConfig.safeBlockHorizontal !* 3.7),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Checkbox(
                                  value: male,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      male = value;
                                    });
                                  }),
                              Text(
                                "آقایان",
                                textDirection: TextDirection.rtl,
                                style: txtStyle(Color(0xFF707070), "Vazir",
                                    SizeConfig.safeBlockHorizontal !* 3.7),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.safeBlockHorizontal !* 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                right: SizeConfig.safeBlockHorizontal !* 1.5),
                            child: Checkbox(
                                value: both,
                                onChanged: (bool? value) {
                                  setState(() {
                                    both = value;
                                  });
                                }),
                          ),
                          Text(
                            "هردو",
                            textDirection: TextDirection.rtl,
                            style: txtStyle(Color(0xFF707070), "Vazir",
                                SizeConfig.safeBlockHorizontal !* 3.7),
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                      text: "ثبت",
                      txtStyle: txtStyle(Colors.white, "Vazir", 18),
                      onPress: () async {
                       if(male==true || female==true || both ==true){
                         String gender = "";
                         setState(() {
                           isLoadingEdit = true;
                         });

                         if(male==true) gender="male";
                         else if(female==true) gender="female";
                         else if(both==true) gender ="unset";

                         String? token = await getToken();
                         GeneralModel? response = await postSansGenderUpdate(
                             context, token!, sansData, hallId,gender);
                         setState(() {
                           isLoadingEdit = false;
                         });
                         if (response?.success == true) {
                           showToastModel("${response?.message}", Colors.green,
                               Colors.white, Toast.LENGTH_SHORT);
                           Navigator.pop(context, true);
                         }else{
                           showToastModel("${response?.message}", Colors.red,
                               Colors.white, Toast.LENGTH_SHORT);
                           Navigator.pop(context, false);
                         }
                       }else{
                         showToastModel("لطفا یکی از گزینه ها را انتخاب کنید", Colors.red,
                             Colors.white, Toast.LENGTH_SHORT);
                       }
                      },
                      color: Colors.green,
                      isLoading: isLoadingEdit, icon: null, borderRadiuse:1.0,
                    )
                  ],
                ),
              );
            }));
      });
}
