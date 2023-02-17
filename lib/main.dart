import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import '/theme.dart';
import 'package:flutter/material.dart';

import 'AppState/appState.dart';
import 'homePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDNEBkY1Rbp_KD5XBCKI-nZBNBlt3QBSeQ",
        authDomain: "bingointernals.firebaseapp.com",
        databaseURL: "https://bingointernals-default-rtdb.firebaseio.com",
        projectId: "bingointernals",
        storageBucket: "bingointernals.appspot.com",
        messagingSenderId: "895671046398",
        appId: "1:895671046398:web:75e4dce138779a8aad55af",
        measurementId: "G-XWF7S534QH"),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AppState(),
        ),
      ],
      child: MaterialApp(
        title: 'Internals',
        debugShowCheckedModeBanner: false,
        theme: lightThemeData(context),
        // darkTheme: darkThemeData(context),
        home: const HomePage(),
      ),
    );
  }
}
