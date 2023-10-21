part of 'form_bloc.dart';

class KbFormState extends Equatable {
  @override
  List<Object?> get props => [];
}

class KbFormStateInitial extends KbFormState {}

class KbFormStateLoading extends KbFormState {}

class KbFormStateSuccess extends KbFormState {
  KbFormStateSuccess(this.history);
  final History? history;
}

class KbFormStateError extends KbFormState {
  final String errMessage;

  KbFormStateError(this.errMessage);

  @override
  List<Object?> get props => [errMessage];
}
