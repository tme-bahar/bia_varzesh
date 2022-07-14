import 'package:bia_varzesh/src/ui/tools/dialogs.dart';
import 'package:bia_varzesh/src/ui/tools/text_style.dart';
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../size_config.dart';

typedef void IntCallback(int val);

class WeeklyTable extends StatefulWidget {
  final List hours;
  final List data;
  final int hallId;
  final IntCallback callback;

  WeeklyTable(this.hours, this.data, this.hallId, this.callback);

  @override
  _WeeklyTableState createState() => _WeeklyTableState();
}

class _WeeklyTableState extends State<WeeklyTable> {
  List<String> strTime = [];
  List<String> endTime = [];
  late List sansData;
  List<Map> selected =  <Map>[];
  List<String> dateSelected = [];

  @override
  void initState() {
    super.initState();
    setHours();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.safeBlockVertical! * 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                listWidget("جمعه", widget.data[6]["data"],
                    widget.data[6]["day_dateg"]),
                listWidget("پنجشنبه", widget.data[5]["data"],
                    widget.data[5]["day_dateg"]),
                listWidget("چهارشنبه", widget.data[4]["data"],
                    widget.data[4]["day_dateg"]),
                listWidget("سه شنبه", widget.data[3]["data"],
                    widget.data[3]["day_dateg"]),
                listWidget("دوشنبه", widget.data[2]["data"],
                    widget.data[2]["day_dateg"]),
                listWidget("یکشنبه", widget.data[1]["data"],
                    widget.data[1]["day_dateg"]),
                listWidget("شنبه", widget.data[0]["data"],
                    widget.data[0]["day_dateg"]),
                SizedBox(
                  width: SizeConfig.safeBlockVertical! * 12,
                  height:
                      (SizeConfig.safeBlockVertical! * 8) * widget.hours.length +
                          SizeConfig.safeBlockVertical! * 11,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.hours.length + 1,
                    itemBuilder: (BuildContext context, int position) {
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Color(0xFFEBE8E8), width: 1),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        margin: EdgeInsets.only(),
                        child: Container(
                          height: (position == 0)
                              ? SizeConfig.safeBlockVertical! * 10
                              : SizeConfig.safeBlockVertical! * 8,
                          child: Center(
                            child: Text(
                              (position == 0)
                                  ? " "
                                  : " ${endTime[position - 1]} ,${strTime[position - 1]}",
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: txtStyle(Colors.black, "Vazir",
                                  SizeConfig.safeBlockHorizontal! * 3),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          (widget.hours.isEmpty)
              ? Container()
              : Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.safeBlockHorizontal! * 35,
                        vertical: SizeConfig.safeBlockVertical! * 1),
                    child: Center(
                      child: RaisedButton(
                        onPressed: () async {
                          List<Map> sansData = [];
                          for (int i = 0; i < selected.length; i++) {
                            sansData.add({
                              "sans_id": selected[i]["id"],
                              "sans_date": dateSelected[i]
                            });
                          }
                          bool isRefresh = (await openDialogWeeklySchedule(
                              context, sansData, widget.hallId)) as bool;
                          if (isRefresh == true) widget.callback(1);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "ویرایش",
                            textDirection: TextDirection.rtl,
                            style: txtStyle(Colors.white, "Vazir",
                                SizeConfig.safeBlockHorizontal! * 4),
                          ),
                        ),
                        color: Color(0xFFB72415),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  setHours() {
    for (int i = 0; i < widget.hours.length; i++) {
      String tValue = widget.hours[i]["start_time"];
      String eValue = widget.hours[i]["end_time"];
      strTime.add(tValue.substring(0, 5));
      endTime.add(eValue.substring(0, 5));
    }
  }

  Jalali setDate(String miladiDate) {
    String dYear = miladiDate.substring(0, 4);
    String dMonth = miladiDate.substring(5, 7);
    String dDay = miladiDate.substring(8, 10);
    Gregorian g =
        Gregorian(int.parse(dYear), int.parse(dMonth), int.parse(dDay));
    Jalali g2j1 = g.toJalali();
    print(" year : $dYear moth : $dMonth  day:$dDay");
    return g2j1;
  }

  Widget listWidget(String date, List sans, String md) {
    Jalali jalali = setDate(md);
    String rigthMonth = jalali.month.toString();
    String rigthDay = jalali.day.toString();
    if (rigthMonth.length == 1) rigthMonth = "0$rigthMonth";
    if (rigthDay.length == 1) rigthDay = "0$rigthDay";
    String postDate = "${jalali.year}/$rigthMonth/$rigthDay";

    return (sans.isEmpty)
        ? SizedBox(
            width: SizeConfig.safeBlockVertical! * 8,
            height: (SizeConfig.safeBlockVertical! * 8) * widget.hours.length +
                SizeConfig.safeBlockVertical! * 11,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.hours.length + 1,
              itemBuilder: (BuildContext context, int position) {
                return (position == 0)
                    ? Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Color(0xFFEBE8E8), width: 1),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        margin: EdgeInsets.only(),
                        child: Container(
                          height: SizeConfig.safeBlockVertical! * 10,
                          child: Center(
                            child: Text(
                              "$date \n  ${jalali.month}/${jalali.day}",
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: txtStyle(Colors.black, "Vazir",
                                  SizeConfig.safeBlockHorizontal! * 3),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        height: SizeConfig.safeBlockVertical! * 8,
                        decoration: BoxDecoration(
                            color: Color(0xFFC8C8C8),
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(3)),
                      );
              },
            ),
          )
        : SizedBox(
            width: SizeConfig.safeBlockVertical! * 8,
            height: (SizeConfig.safeBlockVertical! * 8) * widget.hours.length +
                SizeConfig.safeBlockVertical! * 11,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: sans.length + 1,
              itemBuilder: (BuildContext context, int position) {
                return (position == 0)
                    ? Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Color(0xFFEBE8E8), width: 1),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        margin: EdgeInsets.only(),
                        child: Container(
                          height: SizeConfig.safeBlockVertical! * 10,
                          child: Center(
                            child: Text(
                              "$date \n  ${jalali.month}/${jalali.day}",
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: txtStyle(Colors.black, "Vazir",
                                  SizeConfig.safeBlockHorizontal! * 3),
                            ),
                          ),
                        ),
                      )
                    : (sans[position - 1]["has_reserve"] == null)
                        ? inkWellContainer(Colors.green, true, position - 1,
                            sans, selected, postDate)
                        : (sans[position - 1]["has_reserve"]["status"] ==
                                "disable")
                            ? inkWellContainer(Colors.black, true, position - 1,
                                sans, selected, postDate)
                            : (sans[position - 1]["has_reserve"]["status"] ==
                                    "online")
                                ? inkWellContainer(Colors.red, false,
                                    position - 1, sans, selected, postDate)
                                : inkWellContainer(Colors.yellow, true,
                                    position - 1, sans, selected, postDate);
              },
            ),
          );
  }

  Widget inkWellContainer(Color color, bool tap, int position, List sans,
      List selected, String postDate) {
    return InkWell(
      onTap: (tap == false)
          ? null
          : () {
              setState(() {
                if (selected.contains(sans[position]) == true) {
                  int index = selected.indexOf(sans[position]);
                  selected.removeAt(index);
                  dateSelected.removeAt(index);
                  print("testL :${selected}");
                } else {
                  selected.add(sans[position]);
                  dateSelected.add(postDate);
                  print("testL :${selected}");
                }
              });
            },
      child: Container(
        height: SizeConfig.safeBlockVertical! * 8,
        decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(3)),
        child: selected == null
            ? Text("")
            : (selected.contains(sans[position]) == true)
                ? Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                : Text(""),
      ),
    );
  }
}
