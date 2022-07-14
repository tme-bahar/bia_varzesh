import 'package:bia_varzesh/src/animation/bouncing_line.dart';
import 'package:bia_varzesh/src/resources/share_prefs.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';
import 'weekly_schedule.dart';

class RegisterWeeklySchedule extends StatefulWidget {
  RegisterWeeklySchedule({Key? key}) : super(key: key);

  @override
  _RegisterWeeklyScheduleState createState() => _RegisterWeeklyScheduleState();
}

class _RegisterWeeklyScheduleState extends State<RegisterWeeklySchedule> with TickerProviderStateMixin {
  late TabController _cardController;
  late bool isLoadingSalons;
  List<Tab> myTabs = [];
  late int salonLength;
  late List<String> salonId;
  @override
  void initState() {
    this.isLoadingSalons = false;
    initiateData();
    super.initState();
  }

  initiateData() async{
    setState(() {
      isLoadingSalons = true;
    });
   int? sLength = await getSalonLength();
   List<String>? listSalonId = await getSalonsId();
   setState(() {
     salonLength = sLength!;
     salonId = listSalonId!;
     isLoadingSalons = false;
     _cardController = new TabController(vsync: this, length: salonLength);
     for (int i = 0; i < salonLength; i++) {
       myTabs.add(Tab(
         text: " سالن ${i + 1}",
         key: Key("$i"),
       ));
     }
   });

  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return (isLoadingSalons == true)? Scaffold(
      body: Center(
        child: /*LoadingBouncingLine.circle(
          backgroundColor: Colors.red.shade900,
          duration: Duration(milliseconds: 2400),
        ),*/Text('data')
      ),
    )
        :
    new DefaultTabController(
      length: salonLength,
      child: new Scaffold(
        appBar: new PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: new Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),

            child: new SafeArea(
              child: Column(
                children: <Widget>[
                  new Expanded(child: new Container()),
                  new TabBar(
                    controller: _cardController,
                    isScrollable: true,
                    labelColor: Color(0xFFAF2B1E),
                    indicatorColor: Color(0xFFAF2B1E),
                    unselectedLabelColor: Color(0xFF707070),
                    tabs: myTabs,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: new TabBarView(
          controller: _cardController,
          children: myTabs.map((Tab tab) {
            String strIndex = tab.key.toString();
            String strValue = strIndex.substring(3, 4);

            int index = int.parse(strValue);
            print("strIndex=$strValue && integer $index");
            print(" datas : ${salonId[index]}");
            int hallId;
            hallId = int.parse(salonId[index]);

            return new Container(
              child:  new Container(
              child: WeeklySchedule(hallId),
            ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
