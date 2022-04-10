abstract class DeviceIdProvider {
  Future<String> getDeviceId();
  Future<void> clearDeviceId();
}
