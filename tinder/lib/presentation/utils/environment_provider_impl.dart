import 'package:tinder/domain/provider/environment_provider.dart';

class EnvironmentProviderImpl implements EnviromentProvider {
  EnviromentFlavor _flavor = EnviromentFlavor.dev;

  @override
  setFlavor({required EnviromentFlavor flavor}) {
    _flavor = flavor;
  }

  @override
  EnviromentFlavor getCurrentFlavor() {
    return _flavor;
  }
}
