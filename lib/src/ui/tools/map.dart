import 'package:bia_varzesh/src/animation/bouncing_line.dart';
import 'package:bia_varzesh/src/models/general_model.dart';
import 'package:bia_varzesh/src/resources/api_provider.dart';
import 'package:bia_varzesh/src/resources/share_prefs.dart';
import 'package:bia_varzesh/src/ui/tools/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:latlong/latlong.dart';
import 'package:location/location.dart' as loc;

class CustomMap extends StatefulWidget {
  CustomMap({required Key key, required this.protoType, required this.show, required this.id}) : super(key: key);
  final int protoType;
  final bool show;
  final int id;

  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  late GeneralModel response;
  late bool isLoadingMapData;
  late String token;

  //List<LatLng> tappedPoints = [];
  loc.Location location = new loc.Location();
  MapController mapController = MapController();
  var markers;
  var markers2;
  late int flag;
  late double tapLat;
  late double tapLong;
  late double showLat;
  late double showLong;
  late List coordinates;

  @override
  void initState() {
    isLoadingMapData = false;
    super.initState();
    if (widget.protoType == 2) {
      initiateData();
    }
  }

  @override
  Widget build(BuildContext context) {
    markers = null;/*tappedPoints.map((latlng) {
      return Marker(
        width: 80.0,
        height: 80.0,
        point: latlng,
        builder: (ctx) => Container(
          child: Icon(
            Icons.location_on,
            color: Color(0xFF28BE5B),
            size: 45,
          ),
        ),
      );
    }).toList();*/

    return Scaffold(
        body: (isLoadingMapData == true)
            ? Center(
                child: /*LoadingBouncingLine.circle(
                    backgroundColor: Color(0xFFB72415),
                    duration: Duration(milliseconds: 2400),
                  borderSize: 0.5,
                  controller: AnimationController(vsync: ),
                  itemBuilder: (BuildContext context, int index)=>{index++;  },
                  key: ,),*/
                Text('hello')
              )
            : Stack(
                children: <Widget>[
                  new FlutterMap(
                    options: MapOptions(
                        //center: (showLat == null)
                            //? LatLng(31.939, 54.0)
                            //: LatLng(showLat, showLong),
                        zoom: (showLat == null) ? 5.0 : 16.0,
                        //onTap: _handleTap
                    ),
                    layers: [
                      TileLayerOptions(
                          urlTemplate:
                              "https://api.mapbox.com/styles/v1/m-arjmand/ck1xevwf20l3m1cperlsn9z3u/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
                          additionalOptions: {
                            'accessToken':
                                'pk.eyJ1IjoibS1hcmptYW5kIiwiYSI6ImNrMXN5aGpxNjBqMWkzaG01YXd2NHMzYWsifQ.m3s1F6SijSyKuifLnxyNqw',
                            'id': 'mapbox.streets'
                          }),
                      new MarkerLayerOptions(markers: markers),
                      (widget.protoType == 2 && showLat != null)
                          ? new MarkerLayerOptions(markers: [
                               /*Marker(
                                  width: 90.0,
                                  height: 90.0,
                                  //point: new LatLng(showLat, showLong),
                                  builder: (context) => new Container(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.location_on,
                                            size: 35,
                                          ),
                                          tooltip: "مکان فعلی",
                                          color: Color(0xFFAF2B1E),
                                          iconSize: 45.0,
                                          onPressed: () {
                                            print('Marker tapped');
                                          },
                                        ),
                                      ),
                                   point: null),*/
                            ])
                          : new MarkerLayerOptions()
                    ],
                    mapController: mapController,
                  ),
                  Positioned(
                      right: 5,
                      bottom: 20,
                      child: (widget.show == false)
                          ? FlatButton(
                              onPressed: () {
                                location.getLocation().then((value) {
                                  setState(() {
                                    /*mapController.move(
                                        null,//LatLng(value.latitude, value.longitude),
                                        16.5);*/
                                  });
                                });
                              },
                              child: new Icon(
                                Icons.my_location,
                                size: 45,
                                color: Color(0xFFAF2B1E),
                              ))
                          : Container()),
                  Positioned(
                      left: 5,
                      bottom: 20,
                      child: (widget.show == false)
                          ? Builder(builder: (BuildContext context) {
                              return RaisedButton(
                                onPressed: () async {
                                  if (widget.protoType == 2 &&
                                      response.success == true &&
                                      tapLat != null) {
                                    String strFacilities =
                                        response.data["facilities"];
                                    List<String> listFacilities =
                                        strFacilities.split(',');
                                    String strUType =
                                        response.data["using_type"];
                                    List<String> listUType =
                                        strUType.split(',');
                                    String strBallType =
                                        response.data["ball_type"];
                                    List<String> listBallType =
                                        strBallType.split(',');
                                    GeneralModel? postResponse = await editSalon(
                                        context,
                                        token,
                                        response.data["club_id"],
                                        response.data["address"],
                                        response.data["name"],
                                        response.data["content"],
                                        listFacilities,
                                        response.data["phone"],
                                        response.data["shaba_code"],
                                        listUType,
                                        response.data["sans_price"],
                                        response.data["sans_beyane_price"],
//                                        response.data["reserve_sans_price"],
                                        response.data["system_porsant"],
                                        response.data["balls_count"],
                                        tapLat,
                                        tapLong,
                                        response.data["status"],
                                        response.data["id"],
                                        listBallType);
                                    showToastModel(
                                        "${postResponse?.message.toString()}",
                                        (postResponse?.success == true)
                                            ? Colors.green
                                            : Colors.red,
                                        Colors.white,
                                        Toast.LENGTH_SHORT);
                                    if (postResponse?.success == true) {
                                      await saveLatLongPrefs(tapLat, tapLong);
                                    }
                                  } else if (widget.protoType == 1 &&
                                      tapLat != null) {
                                    await saveLatLongPrefs(tapLat, tapLong);
                                  }
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Icon(
                                    Icons.check,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                ),
                                shape: CircleBorder(),
                                color: Color(0xFFAF2B1E),
                              );
                            })
                          : Container())
                ],
              ));
  }

  initiateData() async {
    setState(() {
      isLoadingMapData = true;
    });
    token = (await getToken())!;
    GeneralModel? showSalon = await salonGetEditData(context, token, widget.id);
    setState(() {
      coordinates = showSalon?.data["position"]["coordinates"];
      showLat = coordinates[1];
      showLong = coordinates[0];
      response = showSalon!;
      isLoadingMapData = false;
    });
  }

  /*void _handleTap(LatLng latlng) async {
    tapLat = latlng.latitude;
    tapLong = latlng.longitude;
    print("latitude:${tapLat}");
    print("longitude:${tapLong}");

    setState(() {
      if (markers != null) {
        tappedPoints.clear();
      }
      tappedPoints.add(latlng);
    });
  }*/
}
