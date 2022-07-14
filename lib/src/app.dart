import 'package:bia_varzesh/src/resources/share_prefs.dart';
import 'package:flutter/material.dart';
//import 'ui/auth/login_page.dart';
//import 'ui/auth/register_tabs.dart';
//import 'ui/register_club.dart';
//import 'ui/tools/nav_bar.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late String token = "" ;
  @override
  void initState() {
    initiateData();
    super.initState();
  }
  initiateData() async{
    token = (await getToken())!;
    setState(() {
      token = token;
    });

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: (token.isEmpty)?
      Text('login'):Text('navbar')
      //LogIn(): NavBar(token)
    );
  }
}