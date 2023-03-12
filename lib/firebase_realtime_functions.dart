import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

import 'user_model.dart';

const String usersDBRef = 'users';

Future<UserModel> addUser(UserModel user) async {
  final ref = FirebaseDatabase.instance.ref(usersDBRef).child(user.id);

  await ref.set(user.toMap());

  return user;
}

Stream<DatabaseEvent> getUsers() {
  return FirebaseDatabase.instance.ref(usersDBRef).onValue;
}

Future<void> deleteUser(String id) async {
  await FirebaseDatabase.instance.ref(usersDBRef).child(id).remove();
}
