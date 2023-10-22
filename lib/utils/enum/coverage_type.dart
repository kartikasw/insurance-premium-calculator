import 'package:insurance_challenge/resource/string_resource.dart';

enum CoverageType {
  comprehensive(StringRes.coverageTypeComprehensive, 1, 0.0015),
  totalLossOnly(StringRes.coverageTypeTotalLossOnly, 2, 0.005);

  const CoverageType(this._title, this._code, this._rate);

  final StringRes _title;
  final int _code;
  final double _rate;

  String get title => _title.name;

  int get code => _code;

  double get rate => _rate;

  static getCoverageTypeByCode(int code) {
    return values.firstWhere(
      (e) => e.code == code,
      orElse: () => comprehensive,
    );
  }
}
