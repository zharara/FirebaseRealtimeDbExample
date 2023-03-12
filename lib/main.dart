import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtime_database/user_model.dart';

import 'add_user_form.dart';
import 'firebase_options.dart';
import 'firebase_realtime_functions.dart';
import 'utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List Of App Users',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'List Of Students'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder<DatabaseEvent>(
            stream: getUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              return ListView(
                children: snapshot.data!.snapshot.children
                    .map((data) {
                      final user = UserModel.fromMap(
                          Map<String, dynamic>.from(data.value as Map));

                      return ListTile(
                        leading: const Icon(
                          Icons.person_pin_outlined,
                          size: 50,
                        ),
                        title: Text(user.name),
                        isThreeLine: true,
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.address),
                            Text("${user.phoneNumber} | ${user.email}"),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          ),
                          onPressed: () async {
                            try {
                              await deleteUser(user.id);
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        '${user.name} was deleted successfully.')));
                              }
                            } catch (_) {
                              showErrorDialog(context);
                            }
                          },
                        ),
                      );
                    })
                    .toList()
                    .cast(),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddBottomSheet(context),
        tooltip: 'Add User',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _showAddBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context, builder: (ctx) => const AddUserForm());
  }
}
