import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'lib/env/.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'WEB_API_KEY', obfuscate: true)
  static final String webApiKey = _Env.webApiKey;

  @EnviedField(varName: 'WEB_APP_ID', obfuscate: true)
  static final String webAppId = _Env.webAppId;

  @EnviedField(varName: 'WEB_MESSAGING_SENDER', obfuscate: true)
  static final String webMessagingSender = _Env.webMessagingSender;

  @EnviedField(varName: 'WEB_PROJECT_ID', obfuscate: true)
  static final String webProjectId = _Env.webProjectId;

  @EnviedField(varName: 'WEB_STORAGE_BUCKET', obfuscate: true)
  static final String webStorageBucket = _Env.webStorageBucket;

  @EnviedField(varName: 'WEB_AUTH_DOMAIN', obfuscate: true)
  static final String webAuthDomain = _Env.webAuthDomain;

  @EnviedField(varName: 'WEB_MEASUREMENT_ID', obfuscate: true)
  static final String webMeasurementId = _Env.webMeasurementId;

  @EnviedField(varName: 'ANDROID_API_KEY', obfuscate: true)
  static final String androidApiKey = _Env.androidApiKey;

  @EnviedField(varName: 'ANDROID_APP_ID', obfuscate: true)
  static final String androidAppId = _Env.androidAppId;

  @EnviedField(varName: 'ANDROID_MESSAGING_SENDER', obfuscate: true)
  static final String androidMessagingSender = _Env.androidMessagingSender;

  @EnviedField(varName: 'ANDROID_PROJECT_ID', obfuscate: true)
  static final String androidProjectId = _Env.androidProjectId;

  @EnviedField(varName: 'ANDROID_STORAGE_BUCKET', obfuscate: true)
  static final String androidStorageBucket = _Env.androidStorageBucket;

  @EnviedField(varName: 'IOS_API_KEY', obfuscate: true)
  static final String iosApiKey = _Env.iosApiKey;

  @EnviedField(varName: 'IOS_APP_ID', obfuscate: true)
  static final String iosAppId = _Env.iosAppId;

  @EnviedField(varName: 'IOS_MESSAGING_SENDER', obfuscate: true)
  static final String iosMessagingSender = _Env.iosMessagingSender;

  @EnviedField(varName: 'IOS_PROJECT_ID', obfuscate: true)
  static final String iosProjectId = _Env.iosProjectId;

  @EnviedField(varName: 'IOS_STORAGE_BUCKET', obfuscate: true)
  static final String iosStorageBucket = _Env.iosStorageBucket;

  @EnviedField(varName: 'IOS_BUNDLE_ID', obfuscate: true)
  static final String iosBundleId = _Env.iosBundleId;
}
