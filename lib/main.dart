import 'package:blood_donor/add.dart';
import 'package:blood_donor/firebase_options.dart';
import 'package:blood_donor/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:blood_donor/update.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(BloodDonorApp());
}

class BloodDonorApp extends StatelessWidget {
  const BloodDonorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomePage(),
        '/add': (context) => AddDonor(),
        '/update': (context) => updateDonor(),
      },
      initialRoute: '/',
    );
  }
}
