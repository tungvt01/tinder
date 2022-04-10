class BaseResponse<T> {
  late final bool ok;
  T? data;
  late final String? msg;
  late final String? url;

  BaseResponse({required this.ok, this.data, this.msg, this.url});

  BaseResponse.fromJson(
      {required Map<String, dynamic> json, Function? fromJsonModel}) {
    var dataT = json['data'];
    ok = json['ok'];
    msg = json['msg'];
    url = json['url'];
    if (dataT != null && fromJsonModel != null) {
      data = fromJsonModel(dataT);
    }
  }

  Map<String, dynamic> toJson() =>
      {'ok': ok, 'data': data, 'msg': msg, 'url': url};
}
