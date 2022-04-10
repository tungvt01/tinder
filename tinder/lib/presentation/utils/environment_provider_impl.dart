import 'package:tinder/domain/provider/environment_provider.dart';

class EnvironmentProviderImpl implements EnviromentProvider {
  late EnviromentFlavor _flavor;

  @override
  setFlavor({required EnviromentFlavor flavor}) {
    _flavor = flavor;
  }

  @override
  EnviromentFlavor getCurrentFlavor() {
    return _flavor;
  }
}
