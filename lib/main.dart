import 'package:chat_app_fixed/screens/chat_screen.dart';
import 'package:chat_app_fixed/screens/sign_in_screen.dart';
import 'package:chat_app_fixed/screens/sign_up_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        SignInScreen.id: (context) => SignInScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
      initialRoute: SignInScreen.id,
      debugShowCheckedModeBanner: false,
    );
  }
}
