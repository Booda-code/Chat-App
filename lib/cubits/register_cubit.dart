import 'package:chat_app_fixed/cubits/sign_register_cubit_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<SignRegisterCubitStates>{
  RegisterCubit() : super(SignInitialState());

  registerUser({required String email, required String password}) async{
    emit(SignLoadingState());
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SignLoadedState());
    }
    on FirebaseAuthException catch(e){
      emit(SignErrorState(error: e.code));
    }
  }
}