import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../model/member_model.dart';
import '../../auth/auth.dart';
import '../../model/balance_model.dart';
import '../../model/damper_model.dart';
import '../../model/setup_model.dart';
import '../../model/spring_model.dart';
import '../../model/wheel_model.dart';
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

  /*Future<void> creaSetup() async {
    List<Wheel> wheels = [
      Wheel(
        id: 1,
        codifica: 'setup ant dxsdfsdfsdfsdfds',
        posizione: 'Ant dx',
        frontale: 'setup ant dx',
        superiore: 'setup ant dx',
        pressione: 2,
      ),
      Wheel(
        id: 2,
        codifica: 'setup ant sx',
        posizione: 'Ant sx',
        frontale: 'setup ant sx',
        superiore: 'setup ant sx',
        pressione: 11111.0000,
      ),
      Wheel(
        id: 3,
        codifica: 'setup post dx',
        posizione: 'Post dx',
        frontale: 'setup post dx',
        superiore: 'setup post dx',
        pressione: 123.4500,
      ),
      Wheel(
        id: 4,
        codifica: 'setup post sx',
        posizione: 'Post sx',
        frontale: 'setup post sx',
        superiore: 'setup post sx',
        pressione: 123.4500,
      ),
    ];
    List<Balance> balance = [
      Balance(
        id: 1,
        posizione: 'Ant',
        frenata: 48.2,
        peso: 53,
      ),
      Balance(
        id: 2,
        posizione: 'Post',
        frenata: 51.8,
        peso: 47,
      ),

    ];
    List<Spring> spring = [
      Spring(
        id: 1,
        posizione: 'Ant',
        codifica: 'anteriiore',
        posizioneArb: 'Ant',
        rigidezzaArb: 'ABCD1234',
        altezza: 30.0000,
      ),
      Spring(
        id: 2,
        posizione: 'Post',
        codifica: 'reaasdr',
        posizioneArb: 'Ant',
        rigidezzaArb: 'ABCD1234',
        altezza: 30.0000,
      ),
    ];
    List<Damper> damper = [
      Damper(
        id: 1,
        posizione: 'Ant',
        lsr: 9.10,
        hsr: 10.00,
        lsc: 10.00,
        hsc: 10.00,
      ),
      Damper(
        id: 2,
        posizione: 'Post',
        lsr: 9.10,
        hsr: 10.00,
        lsc: 10.00,
        hsc: 10.00,
      ),
    ];
    Setup setup = Setup(
      id: 1,
      ala: 'ala',
      note: 'note',
      wheelAntDx: wheels[0],
      wheelAntSx: wheels[1],
      wheelPostDx: wheels[2],
      wheelPostSx: wheels[3],
      balanceAnt: balance[0],
      balancePost: balance[1],
      springAnt: spring[0],
      springPost: spring[1],
      damperAnt: damper[0],
      damperPost: damper[1],
    );

    FirebaseFirestore.instance.collection('setup').doc("2").set(setup.toMap());

    wheels.forEach((element) {
      FirebaseFirestore.instance.collection('wheel').doc((element.id).toString()).set(element.toMap());
    });
    balance.forEach((element) {
      FirebaseFirestore.instance.collection('balance').doc((element.id).toString()).set(element.toMap());
    });
    spring.forEach((element) {
      FirebaseFirestore.instance.collection('spring').doc((element.id).toString()).set(element.toMap());
    });
    damper.forEach((element) {
      FirebaseFirestore.instance.collection('damper').doc((element.id).toString()).set(element.toMap());
    });
  }

   */

  Future<User?> signInWithEmailAndPassword() async {
    User? user;
    try {
      final String emailStr =
          "S" + _usernameController.text + "@studenti.univpm.it";
      final String password = _passwordController.text;

      //await creaSetup();

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
            _loginButton(context, backgroundColor),
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

  Listener _loginButton(BuildContext context, Color backgroundColor) {
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
