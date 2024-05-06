import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '/models/http_exceptions.dart';
import 'dart:convert';
import 'dart:async';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? authTimer;

  bool get isAuth {
    return _token != null;
  }

  String? get userId {
    if (_userId != null) {
      return _userId;
    }
    return null;
  }

  String? get token {
    if (_token != null &&
        _userId != null &&
        _expiryDate!.isAfter(
          DateTime.now(),
        )) {
      return _token!;
    }
    return null;
  }

  Future<void> _authenticate({
    required String email,
    required String password,
    required String urlSegment,
  }) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBAW3s7Jr15c6yvZm-ypNaRXppSc9i566E';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate!.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
    } catch (_) {
      rethrow;
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    return _authenticate(
      email: email,
      password: password,
      urlSegment: 'signUp',
    );
  }

  Future<void> LogIn({
    required String email,
    required String password,
  }) async {
    return _authenticate(
      email: email,
      password: password,
      urlSegment: 'signInWithPassword',
    );
  }
    
  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    DateTime expiryDate =
        DateTime.parse(extractedUserData['expiryDate'] as String);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'] as String;
    _userId = extractedUserData['userId'] as String;
    _expiryDate = expiryDate;
    notifyListeners();
    autoLogout();
    return true;
  }

  Future<void> logout() async {
    _userId = null;
    _token = null;
    _expiryDate = null;
    if (authTimer != null) {
      authTimer!.cancel();
      authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void autoLogout() {
    if (authTimer != null) {
      authTimer!.cancel();
    }
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
