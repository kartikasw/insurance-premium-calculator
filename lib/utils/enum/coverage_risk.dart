import 'package:insurance_challenge/resource/string_resource.dart';

enum CoverageRisk {
  flood(StringRes.coverageRiskFlood, 1, 0.0005),
  earthQuake(StringRes.coverageRiskEarthquake, 2, 0.0002);

  const CoverageRisk(this._title, this._code, this._rate);

  final StringRes _title;
  final int _code;
  final double _rate;

  String get title => _title.name;

  int get code => _code;

  double get rate => _rate;
}
