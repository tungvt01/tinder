import 'package:tinder/domain/provider/index.dart';

const baseApiUrlDev = 'https://dummyapi.io/data/v1/';
const baseApiUrlProd = 'https://dummyapi.io/data/v1/';

const apiAppIdDev = '6252f48209831b89f69dd47c';
const apiAppIdPro = '6252f48209831b89f69dd47c';

abstract class ApiConfig {
  late String baseUrl;
  late int connectTimeout;
  late int receiveTimeout;
  late String appId;
}

class ApiConfigImpl extends ApiConfig {
  EnviromentProvider enviromentProvider;
  ApiConfigImpl({
    required this.enviromentProvider,
  });

  @override
  String get baseUrl {
    final evn = enviromentProvider.getCurrentFlavor();
    switch (evn) {
      case EnviromentFlavor.prod:
        return baseApiUrlProd;
      default:
        return baseApiUrlDev;
    }
  }

  @override
  int get connectTimeout => 50000;
  @override
  int get receiveTimeout => 30000;

  @override
  String get appId {
    final evn = enviromentProvider.getCurrentFlavor();
    switch (evn) {
      case EnviromentFlavor.prod:
        return apiAppIdPro;
      default:
        return apiAppIdDev;
    }
  }
}
