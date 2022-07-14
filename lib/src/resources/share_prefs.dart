import 'package:shared_preferences/shared_preferences.dart';

//*************************sets*************************************************

saveLatLongPrefs(double lat,double long) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setDouble("lat", lat);
  prefs.setDouble("long", long);
  print("save laaatloong");
}

savePrivateToken(String token)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("token", token);
  print("token: $token");
}

saveClubId(int id)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt("clubId", id);
  print("id:$id");
}
saveSalonsNumber(int salonLength) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt("salonLength", salonLength);
  print("salon length : $salonLength");
}

saveSalonsId(List<String> salonsId) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList("salonsId", salonsId);
  print("salon Ids : $salonsId");
}

//*******************************gets*******************************************

Future<String?> getToken()async {
String? pToken;
SharedPreferences prefs = await SharedPreferences.getInstance();
if(prefs.getString("token")!=null){
  pToken = prefs.getString("token");
}else
  pToken =null;
print("private Token Shareprefs: $pToken");
return pToken;

}
Future<int?> getClubId()async {
int? clubId;
SharedPreferences prefs = await SharedPreferences.getInstance();
if(prefs.getInt("clubId")!=null){
  clubId = prefs.getInt("clubId");
}else
  clubId =null;
return clubId;

}

Future<double?> getLat()async {
  double? lat;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.getDouble("lat")!=null){
    lat = prefs.getDouble("lat");
  }else
    lat =null;
  return lat;

}
Future<double?> getLong()async {
  double? long;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.getDouble("long")!=null){
    long = prefs.getDouble("long");
  }else
    long =null;
  return long;

}

Future<int?> getSalonLength()async {
  int? length;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.getInt("salonLength")!=null){
    length = prefs.getInt("salonLength");
  }else
    length =null;
  return length;

}

Future<List<String>?> getSalonsId()async {
  List<String>? sId;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.getStringList("salonsId")!=null){
    sId = prefs.getStringList("salonsId");
  }else
    sId =null;
  return sId;

}