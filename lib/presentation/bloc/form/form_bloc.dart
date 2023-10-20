import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insurance_challenge/core/domain/use_case/login.dart';
import 'package:insurance_challenge/resource/string_resource.dart';
import 'package:insurance_challenge/utils/enum/coverage_risk.dart';
import 'package:insurance_challenge/utils/enum/coverage_type.dart';

part 'form_event.dart';

part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, KbFormState> {
  FormBloc(this._login) : super(KbFormStateInitial()) {
    on<FormEventSubmitPremiumForm>(_onFormEventSubmitPremiumForm);
  }

  final Login _login;

  FutureOr _onFormEventSubmitPremiumForm(
      FormEventSubmitPremiumForm event, Emitter<KbFormState> emit) async {
    emit(KbFormStateLoading());
    Map<String, dynamic> message = {
      StringRes.customerName.name: event.customerName,
      StringRes.coveragePeriod.name: event.period.toString(),
      StringRes.vehicleType.name: event.vehicle,
      StringRes.coverage.name: event.coverage,
      StringRes.coverageType.name: event.coverageType.code,
      StringRes.coverageRisk.name: event.coverageRisk?.map((e) => e.code).toList(),
    };
    await Future.delayed(Duration(seconds: 2));
    emit(KbFormStateSuccess());
  }
}
