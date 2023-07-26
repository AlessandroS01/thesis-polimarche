import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/backgrounds/login.jpg'
            ),
            fit: BoxFit.fill
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 50),
            // Username Field
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                controller: _usernameController,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.login_sharp,
                    color: Colors.white,
                  ),
                  labelText: 'Username',
                  labelStyle: TextStyle(
                      color: Colors.white
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.white
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
              style: const TextStyle(color: Colors.white),
              controller: _passwordController,
              cursorColor: Colors.white,
              obscureText: !_isPasswordVisible, // Toggle visibility
              decoration: InputDecoration(
                labelStyle: const TextStyle(
                      color: Colors.white
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white
                  )
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.white
                  )
                ),
                labelText: 'Password',

                suffixIcon: IconButton(
                  icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
            ),
          ),
            const SizedBox(height: 16.0),
            // Login Button
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    return Colors.white; // Set your desired background color here
                  }
                ), // Background color,
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.grey[500]; //<-- SEE HERE
                    }
                    return null; // Defer to the widget's default.
                  },
                ),

              ),
              onPressed: () {
                // Perform login logic here, using _usernameController.text and _passwordController.text
                // For demo purposes, just print the values to the console.
                print('Username: ${_usernameController.text}');
                print('Password: ${_passwordController.text}');
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black
                    ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
