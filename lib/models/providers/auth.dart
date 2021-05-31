import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:shop_app/exception/deletingexception.dart';

class Auth with ChangeNotifier {
  String _id;
  String _token;
  DateTime _expirydate;

  String gettoken() {
    if (_token != null &&
        _expirydate != null &&
        _expirydate.isAfter(DateTime.now())) {
      return _token;
    }

    return null;
  }

  bool get auth {
    return gettoken() != null;
  }

  String get userid {
    return _id;
  }

  Future<void> authenticate(
      {String email, String pasword, String urlsegment}) async {
    print('the paswd we got here is $email $pasword');
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlsegment?key=AIzaSyCQz6RmIyhCWiCqExe12rMI2cOsjilkX2A');
    print(url);

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'pasword': pasword,
            'returnSecureToken': true,
          },
        ),
      );
      final responsedata = json.decode(response.body);
      print(responsedata);
      if (responsedata['error' != null]) {
        throw del_exception(responsedata['error']['message']);
      }
      _token = responsedata['idToken'];
      _id = responsedata['localId'];
      _expirydate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responsedata['expiresIn'],
          ),
        ),
      );
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> signup(
    String email,
    String pasword,
  ) async {
    return authenticate(email: email, pasword: pasword, urlsegment: 'signUp');
  }

  Future<void> signin(
    String email,
    String pasword,
  ) async {
    return authenticate(
        email: email, pasword: pasword, urlsegment: 'signInWithPassword');
  }
}
