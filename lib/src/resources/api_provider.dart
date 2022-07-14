import 'dart:io';
import 'package:bia_varzesh/src/models/general_model.dart';
import 'package:bia_varzesh/src/ui/size_config.dart';
import 'package:bia_varzesh/src/ui/tools/text_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'initialization.dart';

final Dio _dio = Dio();
String publicToken =
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNmI2OWY0NzU5NmFjYjljZWE3NTc2NDM4YWE2MDkyMWRjZTJiMWMyMWY2NGU3NjBmNzE4NGNmZGMwODZiNWU1ZDM5MTY2M2JiYzk4M2U4OGQiLCJpYXQiOjE1ODE3NjY3MjUsIm5iZiI6MTU4MTc2NjcyNSwiZXhwIjoxNjEzMzg5MTI1LCJzdWIiOiIxIiwic2NvcGVzIjpbInZ1ZV9wdWJsaWNfc2NvcGUiXX0.MhHriuGFCQmy1xz7LbZGcwAkFlgWEFylfBZBoTwVXC_SbNx5eSFuExVYOT6bdAGTChT5g_7_rx2IhEYZENJtJsu_k84UkdVqPOaVo-_IE3x1BkZ9jHvyDD8dF1aDDWUzFWFcH64ddFXwoVYtOnBBtwFj1pOlwfbOaGt2xpKB6Jzy5aFXD2dDb7pF-OoSAb1th7RIgOn30P3GeaZrQo26y96lDWhBjcXJleOCVwuOOCwxKrLJu0NgoEjNPTqqhYfI-CZbGzMw0nybsO1jmVWzh64tP2TfFia77k6cJtVNSRyilqmM0JuqiGtjRgxockQuetI0Feub00pV44n4zApQrllVyS7nvKwXz4eNoz-UcXWkXV74wMNqj4bzA-ETxRDrvgmvGZrWUt1x4sCngB9KYzjZ3VhdTIBJimV6LhbVZhKbV7DIkuPDkuQluyFaED7NzqXmvpCjRCzbFIOwDxWIUhZFEP5_vme2pUj2KN_Es-8qn9EQ5F-oAKmqZlnD6d-6VIMEpLQyE54tyTFMcZTTjeXzoZL0pMsZJxKWzt8mmVz4as-vzWmLvS2yiqsdfsIkAAi2x7cO6T6BIyOzqWNONsAQpBGf1YN-d5wZdXoYP0CznLS8PSYjMDPKpGTYEAMCQMvuYt02N5GdUW098H29g7o5wm7VC7ma0BubXx35AvA";
//************************************ post! ********************************

Future<GeneralModel?> registerPost(
    BuildContext context, String mobile, String name, String family) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $publicToken",
      "Accept": "application/json"
    };
    FormData formData = new FormData.fromMap(
        {"mobile": mobile, "name": name, "family": family});
    Response response =
        await _dio.post(Initialization.register, data: formData);
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("register Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error register :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
            txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> logInPost(BuildContext context, String mobile) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $publicToken",
      "Accept": "application/json"
    };
    FormData formData = new FormData.fromMap({"mobile": mobile});
    Response response = await _dio.post(Initialization.logIn, data: formData);
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("LogIn Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error Log In :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
            txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> checkActivationCodePost(
    BuildContext context, String mobile, String activationCode) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $publicToken",
      "Accept": "application/json"
    };
    FormData formData = new FormData.fromMap(
        {"mobile": mobile, "activation_code": activationCode});
    Response response =
        await _dio.post(Initialization.activationCode, data: formData);
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("checkActivationCode Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error checkActivationCode :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
            txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> recordSalonPost(
    BuildContext context,
    String pToken,
    int clubId,
    String address,
    String name,
    String description,
    List<String> facilities,
    String mobile,
    String shabaCode,
    List<String> usingType,
    String sansPrice,
    String reserveSansPrice,
    String systemPorsant,
    String ballCount,
    double lat,
    double lng,
    String status,
    List<String> ballType) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $pToken",
      "Accept": "application/json"
    };
    FormData formData = new FormData.fromMap({
      "club_id": clubId,
      "address": address,
      "name": name,
      "facilities": facilities,
      "using_type": usingType,
      "content": description,
      "phone": mobile,
      "sans_price": sansPrice,
      "sans_beyane_price": reserveSansPrice,
      "system_porsant": systemPorsant,
      "balls_count": ballCount,
      "shaba_code": shabaCode,
      "lat": lat,
      "lng": lng,
      "status": status,
      "ball_type": ballType
    });

    Response response =
        await _dio.post(Initialization.salonRecord, data: formData);
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("recordSalon Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error recordSalon :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
            txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> editSalon(
    BuildContext context,
    String pToken,
    int clubId,
    String address,
    String name,
    String description,
    List<String> facilities,
    String mobile,
    String shabaCode,
    List<String> usingType,
    int sansPrice,
    int sansBeyanePrice,
//    int reserveSansPrice,
    int systemPorsant,
    int ballCount,
    double lat,
    double lng,
    String status,
    int id,
    List<String> ballType) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $pToken",
      "Accept": "application/json"
    };
    FormData formData = new FormData.fromMap({
      "address": address,
      "name": name,
      "facilities": facilities,
      "using_type": usingType,
      "content": description,
      "phone": mobile,
      "sans_price": sansPrice,
      "sans_beyane_price": sansBeyanePrice,
//      "reserve_sans_price": reserveSansPrice,
      "system_porsant": systemPorsant,
      "balls_count": ballCount,
      "shaba_code": shabaCode,
      "status": status,
      "lat": lat,
      "lng": lng,
      "id": id,
      "ball_type": ballType
    });

    Response response =
        await _dio.post(Initialization.postEditSalon, data: formData);
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("EditSalon Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error EditSalon :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
            txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> addImagePost(
    BuildContext context, String prToken, int hallId, File image) async {
  final String filename = image.path.split('/').last;

  try {
    _dio.options.headers = {
      "Authorization": "Bearer $prToken",
      "Accept": "application/json"
    };

    FormData formData = new FormData.fromMap({
      "hall_id": hallId,
      "image": await MultipartFile.fromFile(image.path, filename: filename)
    });
    Response response =
        await _dio.post(Initialization.postAddImage, data: formData);
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("addImagePost Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error addImagePost :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
            txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> deleteImagePost(
    BuildContext context, String prToken, int hallId, int id) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $prToken",
      "Accept": "application/json"
    };
    FormData formData = new FormData.fromMap({"hall_id": hallId, "id": id});
    Response response =
        await _dio.post(Initialization.postDeleteImage, data: formData);
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("deleteImagePost Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error deleteImagePost :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
            txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> storeSalonAdditionsPost(
    BuildContext context,
    String prToken,
    String name,
    int price,
    int hallId,
    List<String> usingType) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $prToken",
      "Accept": "application/json"
    };
    FormData formData = new FormData.fromMap({
      "name": name,
      "price": price,
      "hall_id": hallId,
      "using_type": usingType
    });
    Response response =
        await _dio.post(Initialization.postSalonAdditionsStore, data: formData);
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("storeSalonAdditionsPost Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error storeSalonAdditionsPost :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
            txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> editSalonAdditionsPost(
    BuildContext context,
    String prToken,
    int id,
    String name,
    String price,
    int hallId,
    List<String> usingType) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $prToken",
      "Accept": "application/json"
    };
    FormData formData = new FormData.fromMap({
      "id": id,
      "name": name,
      "price": price,
      "hall_id": hallId,
      "using_type": usingType
    });
    Response response =
        await _dio.post(Initialization.postSalonAdditionsEdit, data: formData);
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("editSalonAdditionsPost Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error editSalonAdditionsPost :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
            txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> deleteSalonAdditionsPost(
    BuildContext context, String prToken, int id, int hallId) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $prToken",
      "Accept": "application/json"
    };
    FormData formData = new FormData.fromMap({"id": id, "hall_id": hallId});
    Response response = await _dio.post(Initialization.postSalonAdditionsDelete,
        data: formData);
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("deleteSalonAdditionsPost Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error deleteSalonAdditionsPost :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
            txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> postWeeklySchedule(
    BuildContext context,
    String prToken,
    int hallId,
    List<Map> sansData,
    String status,
    String tillData,
    String contract) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $prToken",
      "Accept": "application/json"
    };

    FormData formData = new FormData.fromMap({"hall_id": hallId, "sans_data":
    sansData,"status":status,"till_date":tillData,"contract":contract});

    Response response = await _dio.post(Initialization.postWeeklySchedule,
        data: formData);
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("postWeeklySchedule Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error postWeeklySchedule :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
            txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> postDiscountCode(
    BuildContext context,
    String prToken,
    int hallId,
    int discountPercent,
    String title,
    int  count,
    String expiredAt) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $prToken",
      "Accept": "application/json"
    };

    FormData formData = new FormData.fromMap({"hall_id": hallId, "discount_percent":
    discountPercent,"title":title,"count":count,"expired_at":expiredAt});

    Response response = await _dio.post(Initialization.postDiscountCode,
        data: formData);
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("postDiscountCode Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error postDiscountCode :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
        txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> postStoreDiscountManagement(
    BuildContext context,
    String prToken,
    int hallId,
    String discountPercent,
    String  count,
   ) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $prToken",
      "Accept": "application/json"
    };

    FormData formData = new FormData.fromMap({"hall_id": hallId, "discount_percent":
    discountPercent,"sans_count":count,});

    Response response = await _dio.post(Initialization.postStoreHallDiscountManagement,
        data: formData);
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("postStoreDiscountManagement Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error postStoreDiscountManagement :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
        txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> postDeleteDiscountManagement(
    BuildContext context,
    String prToken,
    int hallId,
    int id,
    ) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $prToken",
      "Accept": "application/json"
    };

    FormData formData = new FormData.fromMap({"hall_id": hallId, "id":
    id,});

    Response response = await _dio.post(Initialization.postDeleteHallDiscountManagement,
        data: formData);
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("postDeleteDiscountManagement Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error postDeleteDiscountManagement :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
        txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> postDeleteContract(
    BuildContext context,
    String prToken,
    int hallId,
    int id,
    ) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $prToken",
      "Accept": "application/json"
    };

    FormData formData = new FormData.fromMap({"hall_id": hallId, "id":
    id,});

    Response response = await _dio.post(Initialization.postContractDelete,
        data: formData);
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("postDeleteContract Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error postDeleteContract :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
        txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> postDeleteReserveContract(
    BuildContext context,
    String prToken,
    int id,
    int hallId,
    int reserveId

    ) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $prToken",
      "Accept": "application/json"
    };

    FormData formData = new FormData.fromMap({"id":
    id,"hall_id": hallId,"reserve_id":reserveId});

    Response response = await _dio.post(Initialization.postContractReserveDelete,
        data: formData);
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("postDeleteReserveContract Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error postDeleteReserveContract :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
        txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> postSansGenderUpdate(
    BuildContext context,
    String prToken,
    List sansData,
    int hallId,
    String gender
    ) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $prToken",
      "Accept": "application/json"
    };

    FormData formData = new FormData.fromMap({"hall_id":
    hallId,"ids":sansData,"gender":gender});

    Response response = await _dio.post(Initialization.postSansGenderUpdate,
        data: formData);
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("postSansGenderUpdate Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error postSansGenderUpdate :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
        txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> postEditNameProfile(
    BuildContext context,
    String prToken,
    String name,
    String family
    ) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $prToken",
      "Accept": "application/json"
    };

    FormData formData = new FormData.fromMap({"name":
    name,"family":family});

    Response response = await _dio.post(Initialization.postEditNameProfile,
        data: formData);
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("postEditNameProfile Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error postEditNameProfile :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
        txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> postEditMobileProfile(
    BuildContext context,
    String prToken,
    String mobile,
    String activationCode
    ) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $prToken",
      "Accept": "application/json"
    };

    FormData formData = new FormData.fromMap({"activation_code":
    activationCode,"mobile":mobile});

    Response response = await _dio.post(Initialization.postEditMobileProfile,
        data: formData);
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("postEditMobileProfile Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error postEditMobileProfile :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
        txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

//******************************** get! ****************************************

Future<GeneralModel?> salonsListGet(
    BuildContext context, String privateToken) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $privateToken",
      "Accept": "application/json"
    };

    Response response = await _dio.get(Initialization.getSalons,
        queryParameters: {"include_rating": "1","include_player":"1"});
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("salonsListGet Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error salonsListGet :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
            txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> salonRatingGet(BuildContext context, String privateToken,
    int hallId, int page, int perPage) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $privateToken",
      "Accept": "application/json"
    };

    Response response = await _dio.get(Initialization.getSalonRating,
        queryParameters: {
          "hall_id": hallId,
          "page": page,
          "per_page": perPage,
          "include_player":"1"
        });
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("salonRatingGet Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error salonRatingGet :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
            txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> salonAdditionsGet(BuildContext context,
    String privateToken, String usingType, int hallId) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $privateToken",
      "Accept": "application/json"
    };

    Response response = await _dio.get(Initialization.getSalonAdditions,
        queryParameters: {"hall_id": hallId, "using_type": usingType});
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("salonAdditionsGet Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error salonAdditionsGet :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
            txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> salonGetEditData(
    BuildContext context, String privateToken, int id) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $privateToken",
      "Accept": "application/json"
    };

    Response response = await _dio
        .get(Initialization.getSalonEditData, queryParameters: {"id": id});
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("salonGetEditData Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error salonGetEditData :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
            txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> getWeeklySchedule(BuildContext context,
    String privateToken, int hallId, int year, int month) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $privateToken",
      "Accept": "application/json"
    };

    Response response = await _dio.get(Initialization.getWeeklySchedule,
        queryParameters: {"hall_id": hallId, "year": year, "month": month});
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("getWeeklySchedule Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error getWeeklySchedule :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
            txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> getWsHours(
    BuildContext context, String privateToken, int hallId) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $privateToken",
      "Accept": "application/json"
    };

    Response response = await _dio
        .get(Initialization.getWSHours, queryParameters: {"hall_id": hallId});
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("getWsHours Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error getWsHours :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
            txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> getDiscountCode(
    BuildContext context, String privateToken, int hallId) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $privateToken",
      "Accept": "application/json"
    };

    Response response = await _dio
        .get(Initialization.getDiscountCode, queryParameters: {"hall_id": hallId});
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("getDiscountCode Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error getDiscountCode :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
        txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> getHallDiscountItem(
    BuildContext context, String privateToken, int id) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $privateToken",
      "Accept": "application/json"
    };

    Response response = await _dio
        .get(Initialization.getHallDiscountItem, queryParameters: {"hall_discount_group_id": id});
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("getHallDiscountItem Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error getHallDiscountItem :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
        txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> getDiscountManagement(
    BuildContext context, String privateToken, int hallId) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $privateToken",
      "Accept": "application/json"
    };

    Response response = await _dio
        .get(Initialization.getHallDiscountManagement, queryParameters: {"hall_id": hallId});
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("getDiscountManagement Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error getDiscountManagement :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
        txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> getReservation(
    BuildContext context, String privateToken, int hallId) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $privateToken",
      "Accept": "application/json"
    };

    Response response = await _dio
        .get(Initialization.getReservation, queryParameters: {"hall_id": hallId
      ,"include_sans":1,"include_player":1});
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("getReservation Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error getReservation :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
        txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> getCredit(
    BuildContext context, String privateToken) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $privateToken",
      "Accept": "application/json"
    };

    Response response = await _dio
        .get(Initialization.getCredit,);
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("getCredit Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error getCredit :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
        txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> getCheckOut(
    BuildContext context, String privateToken) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $privateToken",
      "Accept": "application/json"
    };

    Response response = await _dio
        .get(Initialization.getCheckOut,);
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("getCheckOut Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error getCheckOut :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
        txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> getContract(
    BuildContext context, String privateToken) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $privateToken",
      "Accept": "application/json"
    };

    Response response = await _dio
        .get(Initialization.getSalonContract,
        queryParameters: {"include_reserve":1});
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("getContract Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error getContract :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
        txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> getSansGender(
    BuildContext context, String privateToken,int hallId) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $privateToken",
      "Accept": "application/json"
    };

    Response response = await _dio
        .get(Initialization.getSansGender,
        queryParameters: {"hall_id":hallId});
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("getSansGender Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error getSansGender :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
        txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> getEditProfile(
    BuildContext context, String privateToken) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $privateToken",
      "Accept": "application/json"
    };

    Response response = await _dio
        .get(Initialization.getEditProfile,);
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("getEditProfile Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error getEditProfile :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
        txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal!! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

Future<GeneralModel?> getSupportAndAboutUs(
    BuildContext context, String privateToken,String word) async {
  try {
    _dio.options.headers = {
      "Authorization": "Bearer $privateToken",
      "Accept": "application/json"
    };

    Response response = await _dio
        .get(Initialization.getSupportAndAboutUs,queryParameters: {"word":word});
    if (response.statusCode == 200) return GeneralModel.fromJson(response.data);
    print("getSupportAndAboutUs Status code = ${response.statusCode}");
  } on Exception catch (e) {
    print("Error getSupportAndAboutUs :$e");
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        "لطفا اتصال اینترنت را بررسی کنید!",
        style:
        txtStyle(Colors.white, "Vazir", SizeConfig.safeBlockHorizontal!! * 4),
      ),
      backgroundColor: Colors.red.shade900,
    ));
  }
}

