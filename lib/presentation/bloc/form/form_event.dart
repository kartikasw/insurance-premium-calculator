part of 'form_bloc.dart';

class FormEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FormEventLogin extends FormEvent {
  FormEventLogin({required this.email, required this.password});

  final String email;
  final String password;
}

class FormEventSubmitPremiumForm extends FormEvent {
  FormEventSubmitPremiumForm({
    required this.customerName,
    required this.vehicle,
    required this.period,
    required this.coverage,
    required this.coverageType,
    required this.coverageRisk,
  });

  final String customerName;
  final String vehicle;
  final DateTime period;
  final double coverage;
  final CoverageType coverageType;
  final List<CoverageRisk> coverageRisk;
}

class FormEventLogout extends FormEvent {}
