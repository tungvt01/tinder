import 'package:flutter_test/flutter_test.dart';
import 'package:tinder/data/net/index.dart';
import 'package:tinder/data/remote/base/index.dart';
import 'package:tinder/domain/model/index.dart';
import 'package:tinder/main/app_injector.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await initInjector();
    await injector.get<EndPointProvider>().load();
  });

  group("fetchuser", () {
    test("test fetch user", () async {
      final userApi = injector.get<UserApi>();

      expect(
          (await userApi.fetchUsers(
                  params: FetchUsersParams(page: 0, limit: 20)))
              .limit,
          20);
    });
  });
}
