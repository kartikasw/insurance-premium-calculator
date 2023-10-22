import 'package:insurance_challenge/resource/string_resource.dart';

class PremiumResponse {
  const PremiumResponse({
    this.customerName = '',
    this.period = '',
    this.vehicleType = '',
    this.coverage = 0,
    this.coverageType = 1,
    this.coverageRisk = const [],
    this.premium = 0,
    this.timestamp = '',
  });

  final String customerName;
  final String period;
  final String vehicleType;
  final double coverage;
  final int coverageType;
  final List<int> coverageRisk;
  final double premium;
  final String timestamp;

  factory PremiumResponse.fromMap(Map<String, dynamic> map) {
    List<int> risk = (map[StringRes.coverageRisk.name] as List<dynamic>)
        .map((e) => e as int)
        .toList();
    return PremiumResponse(
      customerName: map[StringRes.customerName.name] ?? '',
      period: map[StringRes.coveragePeriod.name] ?? '',
      vehicleType: map[StringRes.vehicleType.name] ?? '',
      coverage: map[StringRes.coverage.name] ?? 0.0,
      coverageType: map[StringRes.coverageType.name] ?? 0,
      coverageRisk: risk,
      premium: map[StringRes.premium.name] ?? 0.0,
      timestamp: map['timestamp'] ?? '',
    );
  }
}
