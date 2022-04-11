import 'package:tinder/data/remote/api/index.dart';

class RequestHeaderBuilder {
  ApiConfig apiConfig;

  RequestHeaderBuilder({
    required this.apiConfig,
  });

  Map<String, String> _defaultHeader({
    String? apiAppId,
    String contentType = 'application/json',
  }) {
    var header = {
      'content-type': contentType,
    };
    if (apiAppId?.isNotEmpty ?? false) {
      header['app-id'] = '$apiAppId';
    }

    return header;
  }

  Future<Map<String, String>> buildHeader() async {
    var header = _defaultHeader(apiAppId: apiConfig.appId);
    return header;
  }
}
