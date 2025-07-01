class SignRegisterCubitStates {}

class SignInitialState extends SignRegisterCubitStates {}

class SignLoadingState extends SignRegisterCubitStates {}

class SignLoadedState extends SignRegisterCubitStates {}

class SignErrorState extends SignRegisterCubitStates {
  final String error;
  SignErrorState({required this.error});
}
