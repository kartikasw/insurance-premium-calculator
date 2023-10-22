import 'package:insurance_challenge/core/data/source/remote/response/premium_response.dart';
import 'package:insurance_challenge/resource/string_resource.dart';
import 'package:insurance_challenge/utils/enum/coverage_risk.dart';
import 'package:insurance_challenge/utils/enum/coverage_type.dart';

class History {
  const History({
    this.customerName = 'Kartika Sari',
    this.period = '',
    this.vehicleType = 'vehicleType',
    this.coverage = 0,
    this.coverageType = CoverageType.comprehensive,
    this.coverageRisk = const [CoverageRisk.flood, CoverageRisk.earthQuake],
    this.premium = 0,
    this.timestamp = '',
  });

  final String customerName;
  final String period;
  final String vehicleType;
  final double coverage;
  final CoverageType coverageType;
  final List<CoverageRisk> coverageRisk;
  final double premium;
  final String timestamp;

  factory History.fromResponse(PremiumResponse response) {
    return History(
      customerName: response.customerName,
      period: response.period,
      vehicleType: response.vehicleType,
      coverage: response.coverage,
      coverageType: CoverageType.getCoverageTypeByCode(response.coverageType),
      coverageRisk: response.coverageRisk
          .map((e) => CoverageRisk.getCoverageRiskByCode(e) as CoverageRisk)
          .toList(),
      premium: response.premium,
      timestamp: response.timestamp,
    );
  }

  Map<String, dynamic> toMapMessage() {
    return {
      StringRes.customerName.name: customerName,
      StringRes.coveragePeriod.name: period,
      StringRes.vehicleType.name: vehicleType,
      StringRes.coverage.name: coverage,
      StringRes.coverageType.name: coverageType.code,
      StringRes.coverageRisk.name: coverageRisk.map((e) => e.code).toList(),
      StringRes.premium.name: premium,
      'timestamp': DateTime.now().toString(),
    };
  }
}
