import 'package:bia_varzesh/src/animation/bouncing_line.dart';
import 'package:bia_varzesh/src/models/general_model.dart';
import 'package:bia_varzesh/src/resources/api_provider.dart';
import 'package:bia_varzesh/src/resources/share_prefs.dart';
import 'package:bia_varzesh/src/ui/tools/text_style.dart';
import 'package:flutter/material.dart';
//import 'package:jalali_calendar/jalali_calendar.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../size_config.dart';
import 'table_weekly.dart';

class WeeklySchedule extends StatefulWidget {
  final int hallId;

  WeeklySchedule(this.hallId);

  @override
  WeeklyScheduleState createState() => WeeklyScheduleState();

  static WeeklyScheduleState? of(BuildContext context) {
    final WeeklyScheduleState? navigator =
        context.findAncestorStateOfType<WeeklyScheduleState>();
    assert(() {
      if (navigator == null) {
        throw new FlutterError(
            'MyStatefulWidgetState operation requested with a context that does '
            'not include a MyStatefulWidget.');
      }
      return true;
    }());

    return navigator;
  }
}

class WeeklyScheduleState extends State<WeeklySchedule>
    with TickerProviderStateMixin {
  String _fromDate = '';
  late String token;
  late bool isLoadingWeeklyData;
  late GeneralModel hoursResponse;
  late GeneralModel weeklyResponse;
  late List hoursData;
  late List weeklyData;
  late bool successH;
  late bool successWeekly;
  late int year;
  late int month;
  late Map mapData;
  List namesWeek = [
    "هفته اول",
    "هفته دوم",
    " هفته سوم",
    "هفته چهارم",
    "هفته پنجم",
    "هفته ششم"
  ];
  int _isReloaded = 0;

  set reloadMethod(int value) => setState(() => _isReloaded = value);

  @override
  void initState() {
    isLoadingWeeklyData = false;
    Jalali jNow = Jalali.now();
    year = jNow.year;
    month = jNow.month;
    initiateData();
    super.initState();
  }

  initiateData() async {
    setState(() {
      isLoadingWeeklyData = true;
    });
    token = (await getToken())!;
    GeneralModel? dataModelHours =
        await getWsHours(context, token, widget.hallId);
    GeneralModel? dataModelWeekly =
        await getWeeklySchedule(context, token, widget.hallId, year, month);
    setState(() {
      hoursResponse = dataModelHours!;
      weeklyResponse = dataModelWeekly!;
      successH = hoursResponse.success;
      successWeekly = weeklyResponse.success;
      print(" su week : $successWeekly");
      hoursData = hoursResponse.data;
      weeklyData = weeklyResponse.data;
      isLoadingWeeklyData = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (_isReloaded == 1) {
      initiateData();
      _isReloaded = 0;
    }
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.safeBlockHorizontal !* 7,
              vertical: SizeConfig.safeBlockVertical !* 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                width: SizeConfig.safeBlockHorizontal !* 34,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.safeBlockHorizontal !* 4,
                      top: SizeConfig.safeBlockVertical !* 1.5,
                      right: SizeConfig.safeBlockHorizontal !* 4,
                      bottom: SizeConfig.safeBlockVertical !* 1.5),
                  child: Center(
                    child: Text(
                      "$_fromDate",
                      textDirection: TextDirection.rtl,
                      style: txtStyle(Color(0xFF707070), "Vazir",
                          SizeConfig.safeBlockHorizontal !* 4),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF707070),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.safeBlockHorizontal !* 3,
                    right: SizeConfig.safeBlockHorizontal !* 5),
                child: InkWell(
                  child: Image.asset(
                    "assets/images/icon_calendar.png",
                    fit: BoxFit.fill,
                    color: Color(0xFFB72415),
                    width: SizeConfig.safeBlockHorizontal !* 8,
                    height: SizeConfig.safeBlockHorizontal !* 8,
                  ),
                  onTap: _selectFromDate,
                ),
              ),
              Text(
                "انتخاب ماه :",
                textDirection: TextDirection.rtl,
                style: txtStyle(Color(0xFF707070), "Vazir",
                    SizeConfig.safeBlockHorizontal !* 4),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.safeBlockHorizontal !* 4),
          child: Divider(
            color: Color(0xFF707070),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.safeBlockHorizontal !* 7,
              vertical: SizeConfig.safeBlockVertical !* 1),
          child: Text(
            "راهنما",
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            style: txtStyle(
                Color(0xFF707070), "Vazir", SizeConfig.safeBlockHorizontal !* 4),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.safeBlockHorizontal !* 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: SizeConfig.safeBlockHorizontal !* 1),
                    child: Container(
                      height: SizeConfig.safeBlockHorizontal !* 6,
                      width: SizeConfig.safeBlockHorizontal !* 6,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Text(
                    "آزاد-عدم نمایش سیستم",
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: txtStyle(Color(0xFF707070), "Vazir",
                        SizeConfig.safeBlockHorizontal !* 3),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: SizeConfig.safeBlockHorizontal !* 1),
                    child: Container(
                      height: SizeConfig.safeBlockHorizontal !* 6,
                      width: SizeConfig.safeBlockHorizontal !* 6,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Text(
                    "رزرو داخلی",
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: txtStyle(Color(0xFF707070), "Vazir",
                        SizeConfig.safeBlockHorizontal !* 3),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: SizeConfig.safeBlockHorizontal !* 1),
                    child: Container(
                      height: SizeConfig.safeBlockHorizontal !* 6,
                      width: SizeConfig.safeBlockHorizontal !* 6,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Text(
                    "آزاد",
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: txtStyle(Color(0xFF707070), "Vazir",
                        SizeConfig.safeBlockHorizontal !* 3),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: SizeConfig.safeBlockHorizontal !* 1),
                    child: Container(
                      height: SizeConfig.safeBlockHorizontal !* 6,
                      width: SizeConfig.safeBlockHorizontal !* 6,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Text(
                    "رزرو سیستمی",
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: txtStyle(Color(0xFF707070), "Vazir",
                        SizeConfig.safeBlockHorizontal !* 3),
                  ),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.safeBlockHorizontal !* 4,
              top: SizeConfig.safeBlockVertical !* 1.5,
              right: SizeConfig.safeBlockHorizontal !* 4,
              bottom: SizeConfig.safeBlockVertical !* 1.5),
          child: Divider(
            color: Color(0xFF707070),
          ),
        ),
        Container(
            height: SizeConfig.screenHeight! / 1.8,
            child: (isLoadingWeeklyData == true)
                ? Scaffold(
                    body: Center(
                      child: /*LoadingBouncingLine.circle(
                        backgroundColor: Colors.red.shade900,
                        duration: Duration(milliseconds: 2400),
                      ),*/Text('data')
                    ),
                  )
                : DefaultTabController(
                    length: weeklyData.length,
                    child: new Scaffold(
                      appBar: new PreferredSize(
                        preferredSize: Size.fromHeight(kToolbarHeight),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.safeBlockHorizontal !* 2),
                          child: new Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Color(0xFFAF2B1E))),
                            child: new SafeArea(
                              child: Column(
                                children: <Widget>[
                                  new Expanded(child: new Container()),
                                  new TabBar(
//                                    controller: _weeklyController,
                                    isScrollable: true,
                                    labelColor: Color(0xFFAF2B1E),
                                    indicatorColor: Color(0xFFAF2B1E),
                                    unselectedLabelColor: Color(0xFF707070),
                                    indicatorWeight:
                                        SizeConfig.safeBlockHorizontal !* 1,
                                    tabs: tabBars(weeklyData, namesWeek),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      body: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.safeBlockHorizontal !* 2),
                        child:
                            new TabBarView(children: tabBarViews(weeklyData)),
                      ),
                    ),
                  )),
      ],
    );
  }

  Future _selectFromDate() async {
    String picked = "";//await jalaliCalendarPicker(context: context,selectedFormat: "yyyy/mm",);
    if (picked != null) {
      String strYear = picked.substring(0, 4);
      String strMonth = picked.substring(5, 7);
      print(" $year !**** $month");
      year = int.parse(strYear);
      month = int.parse(strMonth);
      initiateData();
      setState(() {
        _fromDate = picked.toString();
      });
    }
  }

  List<Widget> tabBars(List data, List names) {
    List<Widget> widgets = <Widget>[];
    for (int i = 0; i < data.length; i++) {
      widgets.add(Tab(
        child: Text(
          names[i],
          textDirection: TextDirection.rtl,
          style: TextStyle(
              fontFamily: "Vazir",
              fontSize: SizeConfig.safeBlockHorizontal !* 3.5),
        ),
      ));
    }
    return widgets;
  }

  List<Widget> tabBarViews(List data) {
    List<Widget> widgets = <Widget>[];
    for (int i = 0; i < data.length; i++) {
     widgets.add(
       (successH==true)?
       (hoursData.isEmpty)?
       Center(
           child: Text(
             "داده ای برای این سالن وجود ندارد!",
             textDirection: TextDirection.rtl,
             style: txtStyle(Color(0xFFAF2B1E), "Vazir",
                 SizeConfig.safeBlockHorizontal !* 4),
           )):

         ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                    width: SizeConfig.safeBlockVertical !* 70,
                    child:

                    WeeklyTable(
                        hoursData,
                        data[i]["sans"],
                        widget.hallId,
                        (val) => setState(() => _isReloaded = val)
                )),
              ],
            ):
       Center(
         child: Text(
           "${hoursResponse.message}",
           textDirection: TextDirection.rtl,
           style: txtStyle(Color(0xFFAF2B1E), "Vazir",
               SizeConfig.safeBlockHorizontal !* 4),
         ),
       )
     );

    }
    return widgets;
  }
}
