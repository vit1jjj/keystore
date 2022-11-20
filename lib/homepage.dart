import 'package:flutter/material.dart';
import 'package:keystore/credential.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CredentialsStore _credentialsStore = CredentialsStore();
  final TextEditingController textEditingController = TextEditingController();
  String login = '';
  String password = '';
  bool remember = true;
  String firstName = '';
  String secondName = '';
  String email = '';

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
      firstName = _credentialsStore.getCurrentFName();
      secondName = _credentialsStore.getCurrentSName();
      email = _credentialsStore.getCurrentMail();
    });
  }

  void setFild(String key, String map) async {
    _credentialsStore.setFild(key, map);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        centerTitle: true,
        title: Text('Привет $login'),
        backgroundColor: Colors.green[900],
      ),
      body: Container(
        color: Colors.lightGreen[100],
        child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    textRedactor('firstName', 'Введите имя', Icons.account_circle),
                    textRedactor('secondName', 'Введите фамилию', Icons.account_circle),
                    textRedactor('email', 'Введите email', Icons.mail),
                  ],
                ),           
              ),
              mButton('Выход'),
            ],
          ),
      ),
    );
  }

  Widget mButton(String t) {
    return GestureDetector(
      onTap: () {Navigator.pop(context);},
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        height: 40,
        decoration: BoxDecoration(
              color: Colors.green[800],
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

  Widget textRedactor(String lText, String hText, [IconData iconForm=Icons.pets]) {
    String sText = '';
    switch (lText) {
            case 'firstName':
              sText = firstName;
              break;
            case 'secondName':
              sText = secondName;
              break;
            case 'email':
              sText = email;
              break;
            default:
    }
    return Container(
      padding: const EdgeInsets.all(10),
      height: 80,
      child: TextField(
        controller: TextEditingController()..text = sText,
        onSubmitted: (String value) {
          setState(() {
            switch (lText) {
            case 'firstName':
              firstName = value;
              break;
            case 'secondName':
              secondName = value;
              break;
            case 'email':
              email = value;
              break;
            default:
            }
            setFild(lText, value);
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(iconForm),
          labelText: lText,
          hintText: hText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))
          )
        ),
      ),
    );
  }

}
