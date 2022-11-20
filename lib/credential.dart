import 'package:shared_preferences/shared_preferences.dart';

class CredentialsStore {
  late SharedPreferences _prefs;

  CredentialsStore() {
    initPrefs();
  }

  Future initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future rememberMe(bool rem) async {
    await _prefs.setBool('remember', rem);
  }

  bool wasRemembered() {
    return _prefs.getBool('remember') ?? false;
  }

  bool loginBed(String login) {
    final savedLogin = _prefs.getString('login');
    if (savedLogin == login) {return false;}    
    return true;
  }

  bool passwordBed(String password) {
    final savedPassword = _prefs.getString('password');
    if (savedPassword == password) {return false;}    
    return true;
  }

  bool loginDubl(String login) {
    final savedLogin = _prefs.getString('login');
    if (login == savedLogin) return true;
    return false;
  }

  register(String login, String password) {
    _prefs.setString('login', login);
    _prefs.setString('password', password);
  }

  String getCurrentLogin() {
   return _prefs.getString('login') ?? '';
  }

  String getCurrentPassword() {
   return _prefs.getString('password') ?? '';
  }

  String getCurrentFName() {
   return _prefs.getString('firstName') ?? '';
  }

  String getCurrentSName() {
   return _prefs.getString('secondName') ?? '';
  }

  String getCurrentMail() {
   return _prefs.getString('email') ?? '';
  }

  void setFild(String key, String map) {
    _prefs.setString(key, map);
  }

  // Future forgetRemembered() async {
  //   return await _prefs.remove('remember');
  // }

  // Future<bool> signUp(String login, String password) async {
  //   final savedLogin = _prefs.getString('login');
  //   if (login == savedLogin) return false;
  //   await _prefs.setString('login', login);
  //   await _prefs.setString('password', password);
  //   return true;
  // }

  // LoginResult login(String login, String password) {
  //   final savedLogin = _prefs.getString('login');
  //   final savedPassword = _prefs.getString('password');

  //   if (savedLogin != login) {
  //     return LoginResult.wrongLogin;
  //   }

  //   if (savedPassword != password) {
  //     return LoginResult.wrongPassword;
  //   }

  //   return LoginResult.success;
  // }

}

// enum LoginResult {
//   wrongLogin('Такого пользователя нет!'),
//   wrongPassword('Неверный пароль!'),
//   success('Успешная авторизация!'),
//   ;

//   final String message;

//   const LoginResult(this.message);
// }
