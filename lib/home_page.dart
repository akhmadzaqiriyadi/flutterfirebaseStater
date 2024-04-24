import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void addUserToFirestore() {
    final firestore = FirebaseFirestore.instance;
    final usersCollection = firestore.collection('users');

    usersCollection.doc(user.uid).set({
      'email': user.email,
      'name': _nameController.text,
      'address': _addressController.text,
      'job': _jobController.text,
    }).then((_) {
      print("Data pengguna ditambahkan ke Firestore!");
    }).catchError((error) {
      print("Error saat menambahkan data pengguna: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        actions: [
          IconButton(onPressed: signUserOut, icon: Icon(Icons.logout)),
          IconButton(onPressed: addUserToFirestore, icon: Icon(Icons.add)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Login BOLO" + user.email!, style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nama',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Alamat',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _jobController,
                decoration: InputDecoration(
                  labelText: 'Pekerjaan',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
