import 'package:chat_app_fixed/cubits/sign_cubit.dart';
import 'package:chat_app_fixed/cubits/sign_cubit_states.dart';
import 'package:chat_app_fixed/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constant.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_text_button.dart';
import '../widgets/custom_form_text_field.dart';
import 'chat_screen.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  static String id = 'signInScreen';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String? email;
  String? password;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignCubit(),
      child: BlocBuilder<SignCubit, SignCubitStates>(
        builder: (context, state) {

          isLoading = state is SignLoadingState;

          if (state is SignLoadedState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushNamed(context, ChatScreen.id, arguments: email);
            });
          }
          else if (state is SignErrorState) {
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
                      const SizedBox(height: 75),
                      Image.asset('assets/images/scholar.png', height: 100),
                      const Row(
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
                      const SizedBox(height: 75),
                      const Row(
                        children: [
                          Text('Sign In', style: TextStyle(color: Colors.white, fontSize: 20)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      CustomFormTextField(
                        onChanged: (data) => email = data,
                        hintText: 'Enter your email',
                        labelText: 'Email',
                      ),
                      const SizedBox(height: 16),
                      CustomFormTextField(
                        obscureText: true,
                        onChanged: (data) => password = data,
                        hintText: 'Enter your password',
                        labelText: 'Password',
                      ),
                      const SizedBox(height: 25),
                      CustomTextButton(
                        text: 'Sign In',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<SignCubit>(context).signUser(
                              email: email!,
                              password: password!,
                            );
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => SignUpScreen()),
                              );
                            },
                            child: const Text('Sign Up', style: TextStyle(color: Colors.white)),
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
