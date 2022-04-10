class ParamsLogin {
  final String deviceId;
  final String deviceName;
  final int deviceType;
  final String fcmToken;
  final String phoneNumber;
  final String password;
  final String versionCode;


  ParamsLogin({
    required this.deviceId,
    required this.deviceName,
    required this.deviceType,
    required this.fcmToken,
    required this.phoneNumber,
    required this.password,
    required this.versionCode,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceId'] = this.deviceId;
    data['deviceName'] = this.deviceName;
    data['deviceType'] = this.deviceType;
    data['fcmToken'] = this.fcmToken;
    data['phoneNumber'] = this.phoneNumber;
    data['password'] = this.password;
    data['versionCode'] = this.versionCode;
    return data;
  }



/**
 * {
    "deviceId": "37822392-D88A-4A6F-AE8A-0B22F15B5332",
    "deviceName":"Mobile iOS - Apple(15.0) - iPhone 12",
    "deviceType":1,
    "fcmToken":"undefined",
    "name":"Hieu Tran",
    "phoneNumber": "0349102555",
    "password": "123456",
    "versionCode":"1.0",
    "signature":"2aec70d7e85db49df4ce01add4a21ade"
    }
 */
}
