import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:polimarche/model/Balance.dart';
import 'package:polimarche/model/Session.dart';
import 'package:polimarche/model/Setup.dart';
import 'package:polimarche/model/Spring.dart';
import 'package:polimarche/model/Track.dart';
import 'package:polimarche/model/Wheel.dart';
import 'package:polimarche/pages/home/home_page.dart';
import 'package:polimarche/pages/setup/detail/modify/modify_step_pages/balance_page.dart';
import 'package:polimarche/pages/setup/detail/modify/modify_step_pages/dampers_page.dart';
import 'package:polimarche/pages/setup/detail/modify/modify_step_pages/general_information_page.dart';
import 'package:polimarche/pages/setup/detail/modify/modify_step_pages/springs_page.dart';
import 'package:polimarche/pages/setup/detail/modify/modify_step_pages/wheel/wheel_provider.dart';
import 'package:polimarche/pages/setup/detail/modify/modify_step_pages/wheel/wheels_page.dart';
import 'package:polimarche/services/session_service.dart';
import 'package:polimarche/services/setup_service.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:intl/intl.dart';

import '../../../../model/Damper.dart';
import 'modify_step_pages/wheel/wheel_provider.dart';

class ModifySetupPage extends StatefulWidget {
  final Setup setup;
  final SetupService setupService;
  final VoidCallback updateStateDetailSetup;

  const ModifySetupPage(
      {super.key,
      required this.setup,
      required this.setupService,
      required this.updateStateDetailSetup});

  @override
  State<ModifySetupPage> createState() => _ModifySetupPageState();
}

class _ModifySetupPageState extends State<ModifySetupPage>
    with TickerProviderStateMixin {
  // GENERAL DATA
  late AnimationController _animationController;
  final backgroundColor = Colors.grey.shade300;
  late final Setup setup;
  late final SetupService setupService;
  late final VoidCallback updateStateDetailSetup;

  int _progress = 1;
  final _totalSteps = 5;

  List<String> _stepsName = [
    "Gomme",
    "Bilanciamento",
    "Molle",
    "Ammortizzatori",
    "Informazioni generali"
  ];

  late final List _stepPages;

  // GENERAL METHODS
  void _nextStep() {
    if (_progress != _totalSteps) {
      setState(() {
        _progress++;
      });
    }
  }

  void _previousStep() {
    if (_progress != 1) {
      setState(() {
        _progress--;
      });
    }
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

  // FIRST STEP DATA
  late Wheel frontRightWheel;
  late Wheel frontLeftWheel;
  late Wheel rearRightWheel;
  late Wheel rearLeftWheel;

  // FIRST STEP METHODS
  void onWheelFromPage(List<Wheel?> listWheels) {
    Wheel? frontRight = listWheels[0];
    Wheel? frontLeft = listWheels[1];
    Wheel? rearRight = listWheels[2];
    Wheel? rearLeft = listWheels[3];

    if (frontRight != null) {
      if (frontLeft != null) {
        if (rearRight != null) {
          if (rearLeft != null) {
            setState(() {
              frontRightWheel = frontRight;
              frontLeftWheel = frontLeft;
              rearRightWheel = rearRight;
              rearLeftWheel = rearLeft;
            });
            _nextStep();
          } else {
            showToast(
                "Specificare i parametri della gomma posteriore sinistra");
          }
        } else {
          showToast("Specificare i parametri della gomma posteriore destra");
        }
      } else {
        showToast("Specificare i parametri della gomma anteriore sinistra");
      }
    } else {
      showToast("Specificare i parametri della gomma anteriore destra");
    }
  }

  // SECOND STEP DATA
  late Balance frontBalance;
  late Balance rearBalance;

  // SECOND STEP METHODS
  void onBalanceFromPage(List<Balance> listBalance) {
    setState(() {
      frontBalance = listBalance[0];
      rearBalance = listBalance[1];
    });
  }

  // THIRD STEP DATA
  late Spring frontSpring;
  late Spring rearSpring;

  // THIRD STEP METHODS
  void onSpringFromPage(List<Spring> listSpring) {
    setState(() {
      frontSpring = listSpring[0];
      rearSpring = listSpring[1];
    });
  }

  // FOURTH STEP DATA
  late Damper frontDamper;
  late Damper rearDamper;

  // FOURTH STEP METHODS
  void onDamperFromPage(List<Damper> listDamper) {
    setState(() {
      frontDamper = listDamper[0];
      rearDamper = listDamper[1];
    });
  }

  // FIFTH STEP DATA
  late String ala;
  late String note;

  // FIFTH STEP METHODS
  void onGeneralInformationFromPage(String newAla, String newNote) {
    setState(() {
      ala = newAla;
      note = newNote;
    });
  }

  @override
  void initState() {
    super.initState();
    // GENERAL DATA
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300), // Adjust duration as needed
    );
    setup = widget.setup;
    setupService = widget.setupService;
    updateStateDetailSetup = widget.updateStateDetailSetup;

    // FIRST STEP DATA
    frontRightWheel = setup.wheelAntDx;
    frontLeftWheel = setup.wheelAntSx;
    rearRightWheel = setup.wheelPostDx;
    rearLeftWheel = setup.wheelPostSx;

    // SECOND STEP DATA
    frontBalance = setup.balanceAnt;
    rearBalance = setup.balancePost;

    // THIRD STEP DATA
    frontSpring = setup.springAnt;
    rearSpring = setup.springPost;

    // FOURTH STEP DATA
    frontDamper = setup.damperAnt;
    rearDamper = setup.damperPost;

    // FIFTH STEP DATA
    ala = setup.ala;
    note = setup.note;

    // PAGES
    _stepPages = [
      WheelsPage(sendDataToParent: onWheelFromPage, setupService: setupService),
      BalancePage(
          balances: [frontBalance, rearBalance],
          updateModifySetupPage: onBalanceFromPage,
          setupService: setupService),
      SpringsPage(
          springs: [frontSpring, rearSpring],
          updateModifySetupPage: onSpringFromPage,
          setupService: setupService),
      DampersPage(
          dampers: [frontDamper, rearDamper],
          updateModifySetupPage: onDamperFromPage,
          setupService: setupService),
      GeneralInformationPage(
          ala: ala,
          note: note,
          updateModifySetupPage: onGeneralInformationFromPage)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => WheelProvider(frontRightWheel, frontLeftWheel,
                rearRightWheel, rearLeftWheel)),
      ],
      child: Scaffold(
        appBar: _appBar(backgroundColor),
        bottomNavigationBar: _bottomNavBar(),
        body: Container(
          decoration: BoxDecoration(color: backgroundColor),
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.all(20),
                  child: StepProgressIndicator(
                    totalSteps: _totalSteps,
                    currentStep: _progress,
                    roundedEdges: Radius.circular(15),
                    size: 13,
                    unselectedColor: Colors.grey.shade500,
                    selectedColor: Colors.black,
                  )),
              Center(
                child: Text(
                  "${_stepsName[_progress - 1]}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              _stepPages[_progress - 1]
            ],
          ),
        ),
      ),
    );
  }

  Builder _bottomNavBar() {
    return Builder(builder: (BuildContext context) {
      return Container(
          color: Colors.grey.shade300,
          child: GNav(
            iconSize: 30,
            backgroundColor: Colors.grey.shade300,
            color: Colors.black,
            activeColor: Colors.black,
            padding: const EdgeInsets.all(32),
            gap: 8,
            tabs: [
              _progress > 1
                  ? GButton(icon: Icons.arrow_back, onPressed: _previousStep)
                  : GButton(
                      icon: Icons.flag_outlined,
                      leading: Badge(
                        backgroundColor: backgroundColor,
                      )),
              if (_progress != 5 && _progress == 1)
                GButton(
                    icon: Icons.arrow_forward,
                    onPressed: () {
                      List<Wheel?> wheels = WheelsPage.wheelsOf(context);

                      onWheelFromPage(wheels);
                    }),
              if (_progress != 5 && _progress == 2)
                GButton(
                  icon: Icons.arrow_forward,
                  onPressed: _nextStep,
                ),
              if (_progress != 5 && _progress == 3)
                GButton(
                  icon: Icons.arrow_forward,
                  onPressed: _nextStep,
                ),
              if (_progress != 5 && _progress == 4)
                GButton(
                  icon: Icons.arrow_forward,
                  onPressed: _nextStep,
                ),
              if (_progress == 5)
                GButton(
                  icon: Icons.upload,
                  onPressed: () async {
                    if (_animationController.isAnimating) {
                      return;
                    }
                    await _animationController.forward();
                    _animationController.reset();
                  },
                ),
            ],
          ));
    });
  }

  AppBar _appBar(Color backgroundColor) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: Icon(Icons.close), // Change to the "X" icon
          onPressed: () {
            // Implement your desired action when the "X" icon is pressed
            Navigator.pop(context); // Example action: Navigate back
          },
        )
      ],
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        "Modifica setup",
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
    );
  }
}
