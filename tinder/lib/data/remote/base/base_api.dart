import 'package:tinder/main/app_injector.dart';
import 'package:tinder/core/network/network_status.dart';
import 'package:tinder/data/net/api_connection.dart';
import 'package:tinder/data/net/endpoint_provider.dart';
import 'package:tinder/data/remote/api/index.dart';
import 'booking_request_header_builder.dart';

abstract class BaseApi {
  NetworkStatus? networkStatus;
  EndPointProvider? endPointProvider;
  BookingRequestHeaderBuilder? headerBuilder;
  ApiConfig? apiConfig;

  BaseApi({
    ApiConfig? config,
    EndPointProvider? provider,
    NetworkStatus? status,
    BookingRequestHeaderBuilder? builder,
  }) {
    this.networkStatus = status ?? injector.get<NetworkStatus>();
    this.headerBuilder = builder ?? injector.get<BookingRequestHeaderBuilder>();
    this.endPointProvider = provider ?? injector.get<EndPointProvider>();
    this.apiConfig = config ?? injector.get<ApiConfig>();
  }

  Future<ApiConnection> initConnection() async {
    final header = await headerBuilder?.buildHeader();
    return ApiConnection(
      apiConfig!,
      header ?? {},
      networkStatus: networkStatus,
    );
  }
}
