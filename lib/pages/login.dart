import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool isLoginPressed = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Colors.grey.shade300;

    return Scaffold(
      body: Container(
        color: Colors.grey.shade300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: 'aleo',
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 50),
                // Username Field
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'aleo',
                        letterSpacing: 1
                    ),
                    controller: _usernameController,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(
                        Icons.login_sharp,
                        color: Colors.black,
                      ),
                      labelText: 'Username',
                      labelStyle: TextStyle(
                          fontFamily: 'aleo',
                          color: Colors.black
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.black
                        )
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                // Password Field
                Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'aleo',
                      letterSpacing: 1
                  ),
                  controller: _passwordController,
                  cursorColor: Colors.black,
                  obscureText: !_isPasswordVisible, // Toggle visibility
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(
                          fontFamily: 'aleo',
                          color: Colors.black
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black
                      )
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.black
                      )
                    ),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.black,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                ),
                ),
                const SizedBox(height: 16.0),
                // Login Button
                Listener(
                      onPointerUp: (_) => setState( () {
                          // TODO logic for loggin in
                          // Perform login logic here, using _usernameController.text and _passwordController.text
                          // For demo purposes, just print the values to the console.
                          print('Username: ${_usernameController.text}');
                          print('Password: ${_passwordController.text}');

                          Navigator.popAndPushNamed(
                              context,
                              '/home'
                          );
                      }),
                      onPointerDown: (_) => setState(() => isLoginPressed = true),
                      child: AnimatedContainer(
                        width: 130,
                        duration: const Duration(milliseconds: 100),
                        child: Center(child: Text("Login")),
                        padding: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: isLoginPressed ? [] : [
                            //
                            BoxShadow(
                              color: Colors.grey.shade500,
                              offset: Offset(18, 18),
                              blurRadius: 30
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: -Offset(18, 18),
                              blurRadius: 30,
                            ),


                          ]
                        ),
                      ),
                ),
              ],
            )),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                '©Polimarche',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'aleo'
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
