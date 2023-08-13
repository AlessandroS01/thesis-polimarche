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
        color: backgroundColor,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                    decoration: BoxDecoration(
                      color: backgroundColor, // Light background color
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 10,
                          offset: Offset(-5, -5),
                        ),
                        BoxShadow(
                          color: Colors.grey.shade500,
                          blurRadius: 10,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black,
                      style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'aleo',
                            letterSpacing: 1
                        ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Matricola',
                        hintStyle: TextStyle(color: Colors.grey),
                        suffixIcon: Icon(
                          Icons.login_sharp,
                          color: Colors.black,
                        ),
                      ),
                      controller: _usernameController,
                    )
                  ),
                ),
                const SizedBox(height: 20.0),
                // Password Field
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                    decoration: BoxDecoration(
                      color: backgroundColor, // Light background color
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 10,
                          offset: Offset(-5, -5),
                        ),
                        BoxShadow(
                          color: Colors.grey.shade500,
                          blurRadius: 10,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                    child: TextField(
                      cursorColor: Colors.black,
                      style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'aleo',
                            letterSpacing: 1
                        ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey),
                        suffixIcon: IconButton(
                          onPressed: _togglePasswordVisibility,
                          icon: Icon(
                                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                color: Colors.black,
                            ),
                        ),
                      ),
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible, // Toggle visibility
                    )
                  ),
                ),
                const SizedBox(height: 50.0),

                // Login Button
                Listener(
                      onPointerUp: (_) async {
                          await Future.delayed(const Duration(milliseconds: 500)); // Wait for animation
                          setState(() => isLoginPressed = false); // Reset the state
                          // TODO: Add your navigation logic here
                          Navigator.popAndPushNamed(context, '/home');
                      },
                      onPointerDown: (_) => setState(() => isLoginPressed = true),
                      child: AnimatedContainer(
                        width: 120,
                        duration: const Duration(milliseconds: 500),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: isLoginPressed ? [] : [
                            //
                            BoxShadow(
                              color: Colors.grey.shade500,
                              offset: const Offset(18, 18),
                              blurRadius: 30
                            ),
                            BoxShadow(
                              color: Colors.white,
                              offset: -const Offset(18, 18),
                              blurRadius: 30,
                            ),


                          ]
                        ),
                        child: const Center(child: Text("Login")),
                      ),
                ),
              ],
            )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: const Text(
                  '©Polimarche',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'aleo'
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
