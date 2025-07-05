class SignCubitStates {}

class SignInitialState extends SignCubitStates {}

class SignLoadingState extends SignCubitStates {}

class SignLoadedState extends SignCubitStates {}

class SignErrorState extends SignCubitStates {
  final String error;
  SignErrorState({required this.error});
}
