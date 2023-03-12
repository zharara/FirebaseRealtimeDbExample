import 'package:flutter/material.dart';
import 'package:realtime_database/user_model.dart';

import 'firestore_functions.dart';
import 'utils.dart';

class AddUserForm extends StatefulWidget {
  const AddUserForm({Key? key}) : super(key: key);

  @override
  State<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _idTec = TextEditingController();
  final TextEditingController _nameTec = TextEditingController();
  final TextEditingController _phoneTec = TextEditingController();
  final TextEditingController _addressTec = TextEditingController();
  final TextEditingController _emailTec = TextEditingController();

  bool _addLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Text(
                'Enter Student Information',
                style: TextStyle(fontSize: 19),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _idTec,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    (value?.isNotEmpty ?? false) ? null : 'Field required',
                decoration: const InputDecoration(
                    hintText: 'Student ID number',
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _nameTec,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.name,
                validator: (value) =>
                    (value?.isNotEmpty ?? false) ? null : 'Field required',
                decoration: const InputDecoration(
                    hintText: 'Student Name', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _phoneTec,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    (value?.isNotEmpty ?? false) ? null : 'Field required',
                decoration: const InputDecoration(
                    hintText: 'Phone Number', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _addressTec,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.streetAddress,
                validator: (value) =>
                    (value?.isNotEmpty ?? false) ? null : 'Field required',
                decoration: const InputDecoration(
                    hintText: 'Address', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _emailTec,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    (value?.isNotEmpty ?? false) ? null : 'Field required',
                decoration: const InputDecoration(
                    hintText: 'Email', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: _addLoading
                          ? null
                          : () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                final newUser = UserModel(
                                    id: _idTec.text,
                                    name: _nameTec.text,
                                    phoneNumber: _phoneTec.text,
                                    address: _addressTec.text,
                                    email: _emailTec.text);

                                try {
                                  setState(() {
                                    _addLoading = true;
                                  });
                                  await addUser(newUser);
                                } catch (_) {
                                  showErrorDialog(context);
                                }
                                setState(() {
                                  _addLoading = false;
                                });
                                if (mounted) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text(
                                              '${_nameTec.text} was added successfully.')));
                                }
                              }
                            },
                      child: const Text('Add Student')),
                  TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(color: Colors.red),
                      )),
                ],
              ),
              Visibility(
                  visible: _addLoading,
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ))
            ],
          ),
        ));
  }
}
