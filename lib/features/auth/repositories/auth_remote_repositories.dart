import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthRemoteRepositories {
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          "http://10.0.2.2:3000/auth/sign_up",
        ), //always remember to use for android locl host http://10.0.2.2:port_number/endpoint
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"name": name, "email": email, "password": password}),
      );
      print(response.body);
      print(response.statusCode);
    } catch (e) {
      print(e);
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:3000/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );
      print(response.body);
      print(response.statusCode);
    } catch (e) {
      print(e);
    }
  }

  // logout() {}
}
