class GeneralModel{
bool success;
var data;
var message;
GeneralModel({required this.success,this.data,this.message});
factory GeneralModel.fromJson(Map<String,dynamic> json){
  return GeneralModel(
    success:json["is_successful"],
    data:json["data"],
    message:json["message"]
  );
}
}