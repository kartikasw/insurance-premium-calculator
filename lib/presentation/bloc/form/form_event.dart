part of 'form_bloc.dart';

class FormEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FormEventSubmitPremiumForm extends FormEvent {
  FormEventSubmitPremiumForm({
    required this.customerName,
    required this.vehicle,
    required this.period,
    required this.coverage,
    required this.coverageType,
    this.coverageRisk,
  });

  final String customerName;
  final String vehicle;
  final DateTime period;
  final int coverage;
  final CoverageType coverageType;
  final List<CoverageRisk>? coverageRisk;
}
