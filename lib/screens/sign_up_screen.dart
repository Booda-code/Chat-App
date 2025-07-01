import 'package:chat_app_fixed/constant.dart';
import 'package:chat_app_fixed/cubits/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../cubits/sign_register_cubit_states.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_text_button.dart';
import '../widgets/custom_form_text_field.dart';
import 'chat_screen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  static String id = 'signUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocBuilder<RegisterCubit, SignRegisterCubitStates>(
        builder: (context, state) {
          isLoading = state is SignLoadingState;

          if (state is SignLoadedState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushNamed(context, ChatScreen.id, arguments: email);
            });
          } else if (state is SignErrorState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showSnackBar(context, state.error);
            });
          }
          return ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Scaffold(
              backgroundColor: kPrimaryColor,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      SizedBox(height: 75),
                      Image.asset('assets/images/scholar.png', height: 100),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Scholar Chat',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Pacifico',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 75),
                      Row(
                        children: [
                          Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      CustomFormTextField(
                        onChanged: (data) {
                          email = data;
                        },
                        hintText: 'Enter your email',
                        labelText: 'Email',
                      ),
                      SizedBox(height: 16),
                      CustomFormTextField(
                        onChanged: (data) {
                          password = data;
                        },
                        hintText: 'Enter your password',
                        labelText: 'Password',
                      ),
                      SizedBox(height: 25),
                      CustomTextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<RegisterCubit>(context).registerUser(
                              email: email!,
                              password: password!,
                            );
                          }
                        },
                        text: 'Sign Up',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('already have an account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
