import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel {
  final String? id;
  final String email;
  final String name;
  final String password;

  UserModel({
    this.id,
    required this.email,
    required this.name,
    required this.password,
  });

  toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'password': password,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      email: data['email'],
      name: data['name'],
      password: data['password'],
    );
  }
}
