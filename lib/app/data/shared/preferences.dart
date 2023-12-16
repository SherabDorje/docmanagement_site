/*
  Recordar instalar el paquete de:
    shared_preferences:

  Inicializar en el main
    final prefs = new Preferences();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...

*/
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _instancia = Preferences._internal();

  factory Preferences() {
    return _instancia;
  }

  Preferences._internal();

  SharedPreferences? _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  clear() async {
    var aux = skipSplash;
    _prefs?.clear();
    skipSplash = aux;
  }

  bool get skipSplash {
    return _prefs?.getBool('skipSplash') ?? false;
  }

  set skipSplash(bool value) {
    _prefs?.setBool('skipSplash', value);
  }

  String get lastLogin {
    return _prefs?.getString('lastLogin') ?? '';
  }

  set lastLogin(String value) {
    _prefs?.setString('lastLogin', value);
  }

  String get token {
    return _prefs?.getString('token') ?? '';
  }

  set token(String value) {
    _prefs?.setString('token', value);
  }

  String get expire {
    return _prefs?.getString('expire') ?? '';
  }

  set expire(String value) {
    _prefs?.setString('expire', value);
  }

  String get username {
    return _prefs?.getString('username') ?? '';
  }

  set username(String value) {
    _prefs?.setString('username', value);
  }

  String get pass {
    return _prefs?.getString('pass') ?? '';
  }

  set pass(String value) {
    _prefs?.setString('pass', value);
  }

  int get userId {
    return _prefs?.getInt('userId') ?? -1;
  }

  set userId(int value) {
    _prefs?.setInt('userId', value);
  }

  double get cargaTotal {
    return _prefs?.getDouble('cargaTotal') ?? 0.0;
  }

  set cargaTotal(double value) {
    _prefs?.setDouble('cargaTotal', value);
  }

  bool get darkTheme {
    return _prefs?.getBool('darkTheme') ?? false;
  }

  set darkTheme(bool value) {
    _prefs?.setBool('darkTheme', value);
  }

  String get imgVessels {
    return _prefs?.getString('imgVessels') ?? '';
  }

  set imgVessels(String value) {
    _prefs?.setString('imgVessels', value);
  }
}
