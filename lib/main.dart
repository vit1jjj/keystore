import 'package:flutter/material.dart';
import 'package:keystore/loginpage.dart';
import 'package:keystore/register.dart';
import 'package:keystore/homepage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(title: 'Вход'),
        '/register': (context) => const RegisterPage(title: 'Регистрация'),
        '/date': (context) => const HomePage(title: 'Данные'),
      },
    );
  }
}
