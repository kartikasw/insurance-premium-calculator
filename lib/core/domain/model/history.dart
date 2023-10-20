import 'package:insurance_challenge/resource/string_resource.dart';
import 'package:insurance_challenge/utils/enum/coverage_risk.dart';
import 'package:insurance_challenge/utils/enum/coverage_type.dart';

class History {
  const History({
    this.customerName = 'Kartika Sari',
    this.period = '',
    this.vehicleType = 'vehicleType',
    this.coverage = 0.0,
    this.coverageType = CoverageType.comprehensive,
    this.coverageRisk = const [],
    this.premium = 0.0,
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
}