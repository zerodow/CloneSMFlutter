import 'package:first_project/presentation/providers/app_provider.dart';
import 'package:first_project/presentation/screens/intro_screen.dart';
import 'package:first_project/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppProvider(),
        )
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Clean Architecture',
      home: Consumer<AppProvider>(
        builder: (context, appProvider, child) {
          return appProvider.isFirstLaunch
              ? IntroScreen()
              : const LoginScreen();
        },
      ),
    );
  }
}
