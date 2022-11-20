import 'package:flutter/material.dart';
import 'package:keystore/credential.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final CredentialsStore _credentialsStore = CredentialsStore();
  String login = '';
  String password1 = '';
  String password2 = '';

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    await _credentialsStore.initPrefs();
    setState(() {
      login = _credentialsStore.getCurrentLogin();
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
        color: Colors.lightBlue[50],
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textFormOwner('Login', 'Введите Логин', 'Логин уже был', Icons.account_circle),
              textFormOwner('Password', 'Введите Пароль', 'Пароли не совпадают', Icons.key, true),
              textFormOwner('Password Again', 'Введите Пароль', 'Пароли не совпадают', Icons.key, true),
              mButton('Зарегистрироваться'),
            ],
          ),
        ),
      ),
    );
  }

  Widget mButton(String t) {
    return GestureDetector(
      onTap: () {
                  if (_formKey.currentState!.validate()) {
                    _credentialsStore.register(login, password1);
                    setState(() {
                      Navigator.pop(context);
                    });
                  }
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        height: 40,
        decoration: BoxDecoration(
              color: Colors.blue,
              border: Border.all(
                color: Colors.black38
                ),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(
          t,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        )
      )
    );
  }

  Widget textFormOwner(String lText, String hText, String errorText, [IconData iconForm=Icons.pets, bool obs=false]) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 80,
      child: TextFormField(
        validator: (value){
          if (value!.isEmpty) return 'Ничего не введено';
          switch (lText) {
            case 'Login':
              if (login == value) {return errorText;} else {login = value;}
              break;
            case 'Password':
              password1 = value;
              break;
            case 'Password Again':
              password2 = value;
              if (password1 != password2) return errorText;
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
