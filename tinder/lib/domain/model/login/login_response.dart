import 'package:tinder/domain/model/index.dart';

class LoginResponse {
/*
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MTIzN2M2ODkyNDMzNDAwMWE0NjM4MDAiLCJwaG9uZU51bWJlciI6IjAzNDkxMDI1NTUiLCJmY21Ub2tlbiI6InVuZGVmaW5lZCIsImRldmljZUlkIjoiMzc4MjIzOTItRDg4QS00QTZGLUFFOEEtMEIyMkYxNUI1MzMyIiwibmFtZSI6IkhpZXUgVHJhbiIsInZlcnNpb25Db2RlIjoiMS4wIiwiZGV2aWNlVHlwZSI6MSwiZGV2aWNlTmFtZSI6Ik1vYmlsZSBpT1MgLSBBcHBsZSgxNS4wKSAtIGlQaG9uZSAxMiIsImxvZ2luVHlwZSI6MSwiaWF0IjoxNjMxMTgyNTU4LCJleHAiOjE2MzM3NzQ1NTh9.2xc5xnWpbgZPI9s4M-FC42_rG6Rm0PoiDvDsAkw-R7s",
  "uid": "0349102555",
  "isLogin": true,
  "user": {
    "isLocked": 0,
    "_id": "61237c68924334001a463800",
    "name": "Hieu Tran",
    "provider": "phone",
    "uid": "0349102555",
    "phoneNumber": "0349102555",
    "createAt": "2021-08-23T10:46:00.246Z",
    "__v": 0,
    "fcmToken": "undefined",
    "wallet": {
      "_id": "6123705e2489dc28226d7f84",
      "userId": "61237c68924334001a463800",
      "amount": 19800000,
      "createdAt": 1630126697,
      "phoneNumber": "0349102555"
    }
  }
} 
*/

  String? token;
  String? uid;
  bool? isLogin;
  UserModel? user;
  LoginResponse({
    this.token,
    this.uid,
    this.isLogin,
  });
  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json["token"]?.toString();
    uid = json["uid"]?.toString();
    isLogin = json["isLogin"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["token"] = token;
    data["uid"] = uid;
    data["isLogin"] = isLogin;

    return data;
  }

  static LoginResponse fromJsonModel(Map<String, dynamic> json) =>
      LoginResponse.fromJson(json);
}
