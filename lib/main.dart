import 'package:chat_app_habiskerja/screens/auth_screen.dart';
import 'package:chat_app_habiskerja/screens/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/chat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.brown,
            backgroundColor: Colors.grey,
            buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.brown,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          home: snapshot.connectionState != ConnectionState.done
              ? const Splashscreen()
              : StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (ctx, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Splashscreen();
                    }
                    if (userSnapshot.hasData) {
                      return const ChatScreen();
                    }
                    return const AuthScreen();
                  },
                ),
        );
      },
    );
  }
}
