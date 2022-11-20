import 'package:flutter/material.dart';
import 'package:keystore/credential.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final CredentialsStore _credentialsStore = CredentialsStore();
  String login = '';
  String password = '';
  bool remember = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    await _credentialsStore.initPrefs();
    setState(() {
      remember = _credentialsStore.wasRemembered();
      login = _credentialsStore.getCurrentLogin();
      password = _credentialsStore.getCurrentPassword();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        centerTitle: true,
        title: Text(widget.title,),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 1.0],
            colors: [Colors.white, Colors.blue],
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textFormOwner('Login', 'Введите Логин', 'Неверный Логин', Icons.account_circle),
              textFormOwner('Password', 'Введите Пароль', 'Неверный Пароль', Icons.key, true),
              CheckboxListTile(
                value: remember,
                onChanged: (b) {
                  setState(() {
                    remember = b ?? false;
                  });
                },
                title: const Text('Запомнить'),
              ),
              iButton('Войти'),
              rButton('Зарегистрироваться'),
            ],
          ),
        ),
      ),
    );
  }

  Widget iButton(String t) {
    return GestureDetector(
      onTap: () {
                  if (_formKey.currentState!.validate()) {
                    _credentialsStore.rememberMe(remember);
                    setState(() {
                      Navigator.pushNamed(context,'/date',arguments: '/page3');
                    });
                  }
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        height: 40,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 1.0],
            colors: [Colors.lightBlue, Colors.black],
          ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(
          t,
          style: const TextStyle(
            color: Colors.lightBlueAccent,
            fontSize: 20,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        )
      )
    );
  }

  Widget rButton(String t) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context,'/register',arguments: '/page2');
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        height: 40,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 1.0],
            colors: [Colors.lightBlue, Colors.black],
          ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(
          t,
          style: const TextStyle(
            color: Colors.lightBlueAccent,
            fontSize: 20,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        )
      )
    );
  }

  Widget textFormOwner(String lText, String hText, String errorText, [IconData iconForm=Icons.pets, bool obs=false]) {
    String sText = '';
    if (remember) {
          switch (lText) {
            case 'Login':
              sText = login;
              break;
            case 'Password':
              sText = password;
              break;
            default:
          }
    }
    return Container(
      padding: const EdgeInsets.all(10),
      height: 80,
      child: TextFormField(
        controller: TextEditingController()..text = sText,
        validator: (value){
          if (value!.isEmpty) return errorText;
          switch (lText) {
            case 'Login':
              login = value;
              if (_credentialsStore.loginBed(login)) return errorText;
              break;
            case 'Password':
              password = value;
              if (_credentialsStore.passwordBed(password)) return errorText;
              break;
            default:
              debugPrint(lText);
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(iconForm),
          labelText: lText,
          hintText: hText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))
          )
        ),
        obscureText: obs,
      ),
    );
  }
}
