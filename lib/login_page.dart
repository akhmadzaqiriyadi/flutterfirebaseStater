import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageSate();
}

class _LoginPageSate extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

Future signIn() async {
  showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text, 
      password: _passwordController.text
    );
    Navigator.pop(context);
  } catch (error) {
    Navigator.pop(context); // Menutup dialog loading
  
    String errorMessage = "Manjingna Gmail mbuh sandi Salah Kue!!";
    if (error is FirebaseAuthException) {
      if (error.code == 'user-not-found') {
        errorMessage = "Email tidak terdaftar";
      } else if (error.code == 'wrong-password') {
        errorMessage = "Password salah";
      }
    }

    // Menampilkan pesan kesalahan
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Kesalahan"),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Tutup"),
            ),
          ],
        );
      },
    );
  }
}


  // void wrongEmailMessage() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return const AlertDialog(
  //         title: Text('Salah AKUN Gamail BOLO'),
  //       );
  //     },
  //   );
  // }

  // void wrongPasswordMessage() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return const AlertDialog(
  //         title: Text('Salah Passworde BOLO'),
  //       );
  //     },
  //   );
  // }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Log in.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    'lib/assets/images/login.png',
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Please sign in to continue.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: signIn,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 155, vertical: 18),
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Text('Login'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(
                    height: 1, // Tinggi garis (opsional)
                    thickness: 1, // Ketebalan garis (opsional)
                    color: Colors.grey, // Warna garis (opsional)
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
