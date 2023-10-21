import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insurance_challenge/core/domain/model/failure.dart';
import 'package:insurance_challenge/core/domain/model/history.dart';
import 'package:insurance_challenge/core/domain/use_case/add_premium_calculation.dart';
import 'package:insurance_challenge/core/domain/use_case/login.dart';
import 'package:insurance_challenge/core/domain/use_case/logout.dart';
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
    await _handleError(emit, result.$2);
  }

  FutureOr _onFormEventSubmitPremiumForm(
    FormEventSubmitPremiumForm event,
    Emitter<KbFormState> emit,
  ) async {
    emit(KbFormStateLoading());
    double vehiclePremium = (event.coverage * event.coverageType.rate);
    double riskPremium = 0.0;
    if (event.coverageRisk.isNotEmpty) {
      event.coverageRisk.map((e) {
        riskPremium += event.coverage * e.rate;
      });
    }

    History history = History(
      customerName: event.customerName,
      period: event.period.toString(),
      vehicleType: event.vehicle,
      coverage: event.coverage,
      coverageType: event.coverageType,
      coverageRisk: event.coverageRisk,
      premium: vehiclePremium + riskPremium,
    );

    (String?, Failure?) result = await _addPremiumCalculation.execute(history);
    await _handleError(emit, result.$2, history: history);
  }

  FutureOr _onFormEventLogout(
    FormEventLogout event,
    Emitter<KbFormState> emit,
  ) async {
    emit(KbFormStateLoading());
    (String?, Failure?) result = await _logout.execute();
    await _handleError(emit, result.$2);
  }

  Future<void> _handleError(
    Emitter<KbFormState> emit,
    Failure? failure, {
    History? history,
  }) async {
    if (failure == null) {
      await Future.delayed(Duration(seconds: 2));
      emit(KbFormStateSuccess(history));
    } else {
      emit(KbFormStateError(failure.message));
    }
  }
}
