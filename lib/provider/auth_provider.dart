import 'package:flutter/cupertino.dart';
import '../database/hive_database.dart';
import '../modal/user.dart';

class AuthProvider extends ChangeNotifier {
  final HiveDataBase authService;

  AuthProvider({Key? key,required this.authService});

  User? _currentUser;
  User? get currentUser => _currentUser;

  ///register
  Future<void> register({required String email, required String password,required String name,required bool isLogged}) async {
    await authService.register(email: email, password: password,name: name,isLogged: isLogged);
  }

  ///login
  Future<String?> login({required String email, required String password, required String name,required bool isLogged}) async {
     _currentUser = await authService.login(email: email, password: password,name: name,isLogged: isLogged);
    return _currentUser?.email;
  }

  ///logout
  Future<void> logout({required String email, required String password, required String name,required bool isLogged}) async {
     await authService.logout(email: email, password: password,name: name,isLogged: isLogged);
    notifyListeners();
  }

}