import 'package:chat_app_fixed/cubits/sign_cubit_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignCubit extends Cubit<SignCubitStates>{
  SignCubit() : super(SignInitialState());

  signUser({required String email, required String password}) async{
    emit(SignLoadingState());
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SignLoadedState());
    }
    on FirebaseAuthException catch(e){
      emit(SignErrorState(error: e.code));
    }
  }

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