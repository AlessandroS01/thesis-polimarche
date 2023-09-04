import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../model/member_model.dart';
import '../../auth/auth.dart';
import '../../service/member_service.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final backgroundColor = Colors.grey.shade300;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late final Member loggedMember;

  String? errorMessage = '';

  bool _isPasswordVisible = false;
  bool isLoginPressed = false;

  void _togglePasswordVisibility() async {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }
  /*
  Future<void> generateData() async {
    var firestore = FirebaseFirestore.instance.collection('sensor_current');

    for (int i = 1; i <= 25; i++) {
      await firestore.doc(i.toString()).set(Current(
            id: i,
            sessionId: 1,
            setupId: 2,
            bpCurrent: Random().nextDouble() * 100,
            lvBattery: Random().nextDouble() * 100,
            waterPump: Random().nextDouble() * 100,
            coolingFanSys: Random().nextDouble() * 100,
          ).toMap(i));
    }

    firestore = FirebaseFirestore.instance.collection('sensor_load');

    for (int i = 1; i <= 25; i++) {
      await firestore.doc(i.toString()).set(Load(
            id: i,
            sessionId: 1,
            setupId: 2,
            steerTorque: Random().nextDouble() * 100,
            pushFR: Random().nextDouble() * 100,
            pushFL: Random().nextDouble() * 100,
            pushRR: Random().nextDouble() * 100,
            pushRL: Random().nextDouble() * 100,
          ).toMap(i));
    }

    firestore = FirebaseFirestore.instance.collection('sensor_position');

    for (int i = 1; i <= 25; i++) {
      await firestore.doc(i.toString()).set(Position(
            id: i,
            sessionId: 1,
            setupId: 2,
            throttle: Random().nextDouble() * 100,
            steeringAngle: Random().nextDouble() * 100,
            suspensionFR: Random().nextDouble() * 100,
            suspensionFL: Random().nextDouble() * 100,
            suspensionRR: Random().nextDouble() * 100,
            suspensionRL: Random().nextDouble() * 100,
          ).toMap(i));
    }

    firestore = FirebaseFirestore.instance.collection('sensor_pressure');

    for (int i = 1; i <= 25; i++) {
      await firestore.doc(i.toString()).set(Pressure(
            id: i,
            sessionId: 1,
            setupId: 2,
            brakeF: Random().nextDouble() * 100,
            brakeR: Random().nextDouble() * 100,
            coolant: Random().nextDouble() * 100,
          ).toMap(i));
    }

    firestore = FirebaseFirestore.instance.collection('sensor_speed');

    for (int i = 1; i <= 25; i++) {
      await firestore.doc(i.toString()).set(Speed(
            id: i,
            sessionId: 1,
            setupId: 2,
            wheelFR: Random().nextDouble() * 100,
            wheelFL: Random().nextDouble() * 100,
          ).toMap(i));
    }

    firestore = FirebaseFirestore.instance.collection('sensor_voltage');

    for (int i = 1; i <= 25; i++) {
      await firestore.doc(i.toString()).set(Voltage(
            id: i,
            sessionId: 1,
            setupId: 2,
            lvBattery: Random().nextDouble() * 100,
            source24v: Random().nextDouble() * 100,
            source5v: Random().nextDouble() * 100,
          ).toMap(i));
    }
  }

   */

  Future<User?> signInWithEmailAndPassword() async {
    User? user;
    try {
      final String emailStr =
          "S" + _usernameController.text + "@studenti.univpm.it";
      final String password = _passwordController.text;

      //await generateData();

      await Auth()
          .signInWithEmailAndPassword(email: emailStr, password: password);

      user = Auth().currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        setState(() {
          errorMessage =
              "Nessun utente risulta registrato con le credenziali inserite.";
        });
      } else {
        setState(() {
          errorMessage = "Immettere matricola e password.";
        });
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Column(
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
            _matricolaInput(backgroundColor),

            const SizedBox(height: 20.0),
            // Password Field
            _passwordInput(backgroundColor),

            const SizedBox(height: 50.0),

            // Login Button
            _loginButton(context),
          ],
        )),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: const Text(
              '©Polimarche',
              style: TextStyle(
                  color: Colors.black, fontSize: 12, fontFamily: 'aleo'),
            ),
          ),
        )
      ],
    );
  }

  Listener _loginButton(BuildContext context) {
    return Listener(
      onPointerDown: (_) async {
        setState(() {
          isLoginPressed = true;
        });

        User? user = await signInWithEmailAndPassword();

        if (user != null) {
          final memberService = MemberService();
          loggedMember = (await memberService.getMemberByUid(user.uid))!;
          Navigator.popAndPushNamed(context, '/home', arguments: loggedMember);
        } else {
          showToast(errorMessage!);
        }

        setState(() => isLoginPressed = false); // Reset the state
      },
      child: AnimatedContainer(
        width: 120,
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: isLoginPressed
                ? []
                : [
                    //
                    BoxShadow(
                        color: Colors.grey.shade500,
                        offset: const Offset(18, 18),
                        blurRadius: 30),
                    BoxShadow(
                      color: Colors.white,
                      offset: -const Offset(18, 18),
                      blurRadius: 30,
                    ),
                  ]),
        child: const Center(child: Text("Login")),
      ),
    );
  }

  Padding _passwordInput(Color backgroundColor) {
    return Padding(
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
                color: Colors.black, fontFamily: 'aleo', letterSpacing: 1),
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
          )),
    );
  }

  Padding _matricolaInput(Color backgroundColor) {
    return Padding(
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
                color: Colors.black, fontFamily: 'aleo', letterSpacing: 1),
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
          )),
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength:
          Toast.LENGTH_SHORT, // Duration for which the toast will be displayed
      gravity: ToastGravity.BOTTOM, // Position of the toast on the screen
      backgroundColor: Colors.grey[600], // Background color of the toast
      textColor: Colors.white, // Text color of the toast message
      fontSize: 16.0, // Font size of the toast message
    );
  }
}
