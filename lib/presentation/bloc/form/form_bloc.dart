import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insurance_challenge/core/domain/model/failure.dart';
import 'package:insurance_challenge/core/domain/use_case/add_premium_calculation.dart';
import 'package:insurance_challenge/core/domain/use_case/login.dart';
import 'package:insurance_challenge/core/domain/use_case/logout.dart';
import 'package:insurance_challenge/resource/string_resource.dart';
import 'package:insurance_challenge/utils/enum/coverage_risk.dart';
import 'package:insurance_challenge/utils/enum/coverage_type.dart';

part 'form_event.dart';

part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, KbFormState> {
  FormBloc(
    this._addPremiumCalculation,
    this._login,
    this._logout,
  ) : super(KbFormStateInitial()) {
    on<FormEventLogin>(_onFormEventLogin);
    on<FormEventSubmitPremiumForm>(_onFormEventSubmitPremiumForm);
    on<FormEventLogout>(_onFormEventLogout);
  }

  final AddPremiumCalculation _addPremiumCalculation;
  final Login _login;
  final Logout _logout;

  FutureOr _onFormEventLogin(
    FormEventLogin event,
    Emitter<KbFormState> emit,
  ) async {
    emit(KbFormStateLoading());
    (String?, Failure?) result = await _login.execute(
      username: event.username,
      password: event.password,
    );
    _handleError(emit, result.$2);
  }

  FutureOr _onFormEventSubmitPremiumForm(
    FormEventSubmitPremiumForm event,
    Emitter<KbFormState> emit,
  ) async {
    emit(KbFormStateLoading());
    Map<String, dynamic> message = {
      StringRes.customerName.name: event.customerName,
      StringRes.coveragePeriod.name: event.period.toString(),
      StringRes.vehicleType.name: event.vehicle,
      StringRes.coverage.name: event.coverage,
      StringRes.coverageType.name: event.coverageType.code,
      StringRes.coverageRisk.name:
          event.coverageRisk?.map((e) => e.code).toList(),
    };
    (String?, Failure?) result = await _addPremiumCalculation.execute(message);
    _handleError(emit, result.$2);
  }

  FutureOr _onFormEventLogout(
    FormEventLogout event,
    Emitter<KbFormState> emit,
  ) async {
    emit(KbFormStateLoading());
    (String?, Failure?) result = await _logout.execute();
    _handleError(emit, result.$2);
  }

  dynamic _handleError(Emitter<KbFormState> emit, Failure? failure) {
    if (failure == null) {
      emit(KbFormStateSuccess());
    } else {
      emit(KbFormStateError(failure.message));
    }
  }
}
