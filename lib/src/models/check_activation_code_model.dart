class CheckActivationCodeModel {
  bool success;
  String message;
  Data data;

  CheckActivationCodeModel({required this.success, required this.message, required this.data});

  factory CheckActivationCodeModel.fromJson(Map<String, dynamic> json) {
    return CheckActivationCodeModel(
        success: json["is_successful"],
        message: json["message"],
        data: Data.fromJson(json["data"]));
  }
}

class Data {
  final String token;
  Club club;

  Data({required this.token, required this.club});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(token: json["token"], club: Club.fromJson(json["club"]));
  }
}

class Club {
  final int id;
  final String name;
  final String family;
  final String email;
  final String mobile;
  final String lastSession;
  var image;
  var emailVerifiedAt;
  var apiToken;
  var provinceId;
  var createdAt;
  final String updateAt;

  Club(
      {required this.id,
      required this.name,
      required this.family,
      required this.email,
      required this.mobile,
      required this.lastSession,
      this.image,
      this.emailVerifiedAt,
      this.apiToken,
      this.provinceId,
      this.createdAt,
      required this.updateAt});

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
        id: json["id"],
        name: json["name"],
        family: json["family"],
        email: json["email"],
        mobile: json["mobile"],
        lastSession: json["last_session"],
        image: json["image"],
        emailVerifiedAt: json["email_verified_at"],
        apiToken: json["api_token"],
        provinceId: json["province_id"],
        createdAt: json["created_at"],
        updateAt: json["updated_at"]);
  }
}
