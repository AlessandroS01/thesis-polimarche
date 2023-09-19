import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:polimarche/model/balance_model.dart';
import 'package:polimarche/model/setup_model.dart';
import 'package:polimarche/model/spring_model.dart';
import 'package:polimarche/model/wheel_model.dart';
import 'package:polimarche/pages/setup/detail/modify/modify_step_pages/balance/balance_page.dart';
import 'package:polimarche/pages/setup/detail/modify/modify_step_pages/balance/balance_provider.dart';
import 'package:polimarche/pages/setup/detail/modify/modify_step_pages/damper/damper_provider.dart';
import 'package:polimarche/pages/setup/detail/modify/modify_step_pages/damper/dampers_page.dart';
import 'package:polimarche/pages/setup/detail/modify/modify_step_pages/general_informations/general_information_page.dart';
import 'package:polimarche/pages/setup/detail/modify/modify_step_pages/general_informations/general_information_provider.dart';
import 'package:polimarche/pages/setup/detail/modify/modify_step_pages/spring/spring_provider.dart';
import 'package:polimarche/pages/setup/detail/modify/modify_step_pages/spring/springs_page.dart';
import 'package:polimarche/pages/setup/detail/modify/modify_step_pages/wheel/wheel_provider.dart';
import 'package:polimarche/pages/setup/detail/modify/modify_step_pages/wheel/wheels_page.dart';
import 'package:polimarche/service/balance_service.dart';
import 'package:polimarche/service/damper_service.dart';
import 'package:polimarche/service/spring_service.dart';
import 'package:polimarche/service/wheel_service.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../model/damper_model.dart';
import '../../../../service/setup_service.dart';

class ModifySetupPage extends StatefulWidget {
  final Setup setup;
  final Future<void> Function() updateStateSetupPage;

  const ModifySetupPage(
      {super.key, required this.setup, required this.updateStateSetupPage});

  @override
  State<ModifySetupPage> createState() => _ModifySetupPageState();
}

class _ModifySetupPageState extends State<ModifySetupPage>
    with TickerProviderStateMixin {
  // GENERAL DATA
  late AnimationController _animationController;
  final backgroundColor = Colors.grey.shade300;
  late final Setup setup;
  late final SetupService _setupService;
  late final Future<void> Function() updateStateDetailSetup;

  bool _isModifying = false;

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

  void _tryPreviousStepFromBalancePage(List<Balance?> balance) {
    if (balance[0] != null) {
      if (balance[1] != null) {
        if (balance[0]!.peso + balance[1]!.peso == 100) {
          if (balance[0]!.frenata + balance[1]!.frenata == 100) {
            setState(() {
              _progress--;
            });
          } else {
            showToast("La somma del bilanciamento della frenata anteriore e "
                "posteriore deve essere 100. Attualmente: "
                "${(balance[0]!.frenata + balance[1]!.frenata)}");
          }
        } else {
          showToast("La somma del bilanciamento del peso anteriore e "
              "posteriore deve essere 100. Attualmente: "
              "${(balance[0]!.peso + balance[1]!.peso)}");
        }
      } else {
        showToast("Specificare il bilanciamento posteriore");
      }
    } else {
      showToast("Specificare il bilanciamento anteriore");
    }
  }

  void _tryPreviousStepFromSpringPage(List<Spring?> springs) {
    if (springs[0] != null) {
      if (springs[1] != null) {
        setState(() {
          _progress--;
        });
      } else {
        showToast("Specificare le molle posteriori");
      }
    } else {
      showToast("Specificare le molle anteriori");
    }
  }

  void _tryPreviousStepFromDamperPage(List<Damper?> dampers) {
    if (dampers[0] != null) {
      if (dampers[1] != null) {
        setState(() {
          _progress--;
        });
      } else {
        showToast("Specificare gli ammortizzatori posteriori");
      }
    } else {
      showToast("Specificare gli ammortizzatori anteriori");
    }
  }

  void _tryPreviousStepFromGeneralInformationPage(List<String> infos) {
    if (infos[0].isNotEmpty) {
      if (infos[1].isNotEmpty) {
        setState(() {
          _progress--;
        });
      } else {
        showToast("Specificare le note o immettere un qualsiasi carattere");
      }
    } else {
      showToast("Specificare l'ala");
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
  void onBalanceFromPage(List<Balance?> listBalance) {
    Balance? front = listBalance[0];
    Balance? rear = listBalance[1];

    if (front != null) {
      if (rear != null) {
        if (front.peso + rear.peso == 100) {
          if (front.frenata + rear.frenata == 100) {
            setState(() {
              frontBalance = front;
              rearBalance = rear;
            });
            _nextStep();
          } else {
            showToast("La somma del bilanciamento della frenata anteriore e "
                "posteriore deve essere 100. Attualmente: "
                "${(front.frenata + rear.frenata)}");
          }
        } else {
          showToast("La somma del bilanciamento del peso anteriore e "
              "posteriore deve essere 100. Attualmente: "
              "${(front.peso + rear.peso)}");
        }
      } else {
        showToast("Specificare il bilanciamento posteriore");
      }
    } else {
      showToast("Specificare il bilanciamento anteriore");
    }
  }

  // THIRD STEP DATA
  late Spring frontSpring;
  late Spring rearSpring;

  // THIRD STEP METHODS
  void onSpringFromPage(List<Spring?> listSpring) {
    Spring? front = listSpring[0];
    Spring? rear = listSpring[1];

    if (front != null) {
      if (rear != null) {
        setState(() {
          frontSpring = front;
          rearSpring = rear;
        });
        _nextStep();
      } else {
        showToast("Specificare le molle posteriori");
      }
    } else {
      showToast("Specificare le molle anteriori");
    }
  }

  // FOURTH STEP DATA
  late Damper frontDamper;
  late Damper rearDamper;

  // FOURTH STEP METHODS
  void onDamperFromPage(List<Damper?> listDamper) {
    Damper? front = listDamper[0];
    Damper? rear = listDamper[1];

    if (front != null) {
      if (rear != null) {
        setState(() {
          frontDamper = front;
          rearDamper = rear;
        });
        _nextStep();
      } else {
        showToast("Specificare gli ammortizzatori posteriori");
      }
    } else {
      showToast("Specificare gli ammortizzatori anteriori");
    }
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

    _setupService = SetupService();

    updateStateDetailSetup = widget.updateStateSetupPage;

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
      WheelsPage(),
      BalancePage(),
      SpringsPage(),
      DampersPage(),
      GeneralInformationPage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WheelProvider(
              frontRightWheel, frontLeftWheel, rearRightWheel, rearLeftWheel),
        ),
        ChangeNotifierProvider(
          create: (context) => BalanceProvider(frontBalance, rearBalance),
        ),
        ChangeNotifierProvider(
          create: (context) => SpringProvider(frontSpring, rearSpring),
        ),
        ChangeNotifierProvider(
          create: (context) => DamperProvider(frontDamper, rearDamper),
        ),
        ChangeNotifierProvider(
          create: (context) => GeneralInformationProvider(ala, note),
        ),
      ],
      child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: _appBar(backgroundColor),
          bottomNavigationBar: _bottomNavBar(),
          body: !_isModifying
              ? Container(
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
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 20),
                      _stepPages[_progress - 1]
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                )),
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
              if (!_isModifying)
                _progress > 1
                    ? GButton(
                        icon: Icons.arrow_back,
                        onPressed: () {
                          if (_progress == 2) {
                            List<Balance?> balance =
                                BalancePage.balanceOf(context);

                            _tryPreviousStepFromBalancePage(balance);
                          }

                          if (_progress == 3) {
                            List<Spring?> springs =
                                SpringsPage.springOf(context);

                            _tryPreviousStepFromSpringPage(springs);
                          }

                          if (_progress == 4) {
                            List<Damper?> dampers =
                                DampersPage.damperOf(context);

                            _tryPreviousStepFromDamperPage(dampers);
                          }

                          if (_progress == 5) {
                            List<String> infos =
                                GeneralInformationPage.stringOf(context);

                            _tryPreviousStepFromGeneralInformationPage(infos);
                          }
                        })
                    : GButton(
                        icon: Icons.flag_outlined,
                        leading: Badge(
                          backgroundColor: backgroundColor,
                        )),

              // WHEEL
              if (!_isModifying && _progress != 5 && _progress == 1)
                GButton(
                    icon: Icons.arrow_forward,
                    onPressed: () {
                      List<Wheel?> wheels = WheelsPage.wheelsOf(context);

                      onWheelFromPage(wheels);
                    }),

              // BALANCE
              if (!_isModifying && _progress != 5 && _progress == 2)
                GButton(
                    icon: Icons.arrow_forward,
                    onPressed: () {
                      List<Balance?> balance = BalancePage.balanceOf(context);

                      onBalanceFromPage(balance);
                    }),
              if (!_isModifying && _progress != 5 && _progress == 3)
                GButton(
                    icon: Icons.arrow_forward,
                    onPressed: () {
                      List<Spring?> springs = SpringsPage.springOf(context);

                      onSpringFromPage(springs);
                    }),
              if (!_isModifying && _progress != 5 && _progress == 4)
                GButton(
                    icon: Icons.arrow_forward,
                    onPressed: () {
                      List<Damper?> dampers = DampersPage.damperOf(context);

                      onDamperFromPage(dampers);
                    }),
              if (!_isModifying && _progress == 5)
                GButton(
                  icon: Icons.save_alt,
                  onPressed: () async {
                    List<String> genInfos =
                        GeneralInformationPage.stringOf(context);
                    onGeneralInformationFromPage(genInfos[0], genInfos[1]);
                    if (_animationController.isAnimating) {
                      return;
                    }
                    await _animationController.forward();

                    setState(() {
                      _isModifying = true;
                    });

                    await _modifySetup();

                    setState(() {
                      _isModifying = false;
                    });

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

  Future<void> _modifySetup() async {
    /*
    List<Wheel> wheels = [
      frontRightWheel,
      frontLeftWheel,
      rearRightWheel,
      rearLeftWheel
    ];
    List<int> wheelIds = [0, 0, 0, 0];
    List<Balance> balance = [frontBalance, rearBalance];
    List<int> balanceIds = [0, 0];
    List<Spring> springs = [frontSpring, rearSpring];
    List<int> springIds = [0, 0];
    List<Damper> dampers = [frontDamper, rearDamper];
    List<int> damperIds = [0, 0];

    final WheelService _wheelService = WheelService();
    final BalanceService _balanceService = BalanceService();
    final SpringService _springService = SpringService();
    final DamperService _damperService = DamperService();

    await Future.forEach(wheels.asMap().entries,
        (MapEntry<int, Wheel> entry) async {
      final index = entry.key;
      final wheel = entry.value;

      if (wheel.id == 0) {
        wheelIds[index] = await _wheelService.addNewWheel(wheel);
      } else {
        wheelIds[index] = wheel.id;
      }
    });

    await Future.forEach(balance.asMap().entries,
        (MapEntry<int, Balance> entry) async {
      final index = entry.key;
      final balance = entry.value;

      if (balance.id == 0) {
        balanceIds[index] = await _balanceService.addNewBalance(balance);
      } else {
        balanceIds[index] = balance.id;
      }
    });

    await Future.forEach(springs.asMap().entries,
        (MapEntry<int, Spring> entry) async {
      final index = entry.key;
      final spring = entry.value;

      if (spring.id == 0) {
        springIds[index] = await _springService.addNewSpring(spring);
      } else {
        springIds[index] = spring.id;
      }
    });

    await Future.forEach(dampers.asMap().entries,
        (MapEntry<int, Damper> entry) async {
      final index = entry.key;
      final damper = entry.value;

      if (damper.id == 0) {
        damperIds[index] = await _damperService.addNewDampers(damper);
      } else {
        damperIds[index] = damper.id;
      }
    });

    final wheelsUsed = <Wheel>[];
    wheels.asMap().forEach((index, wheel) {
      wheelsUsed.add(Wheel(
          id: wheelIds[index],
          codifica: wheel.codifica,
          posizione: wheel.posizione,
          frontale: wheel.frontale,
          superiore: wheel.superiore,
          pressione: wheel.pressione));
    });
    final balanceUsed = <Balance>[];
    balance.asMap().forEach((index, balance) {
      balanceUsed.add(Balance(
          id: balanceIds[index],
          posizione: balance.posizione,
          frenata: balance.frenata,
          peso: balance.peso));
    });
    final springsUsed = <Spring>[];
    springs.asMap().forEach((index, spring) {
      springsUsed.add(Spring(
          id: springIds[index],
          posizione: spring.posizione,
          codifica: spring.codifica,
          posizioneArb: spring.posizioneArb,
          rigidezzaArb: spring.rigidezzaArb,
          altezza: spring.altezza));
    });
    final dampersUsed = <Damper>[];
    dampers.asMap().forEach((index, damper) {
      dampersUsed.add(Damper(
          id: damperIds[index],
          posizione: damper.posizione,
          lsr: damper.lsr,
          hsr: damper.hsr,
          lsc: damper.lsc,
          hsc: damper.hsc));
    });
    List<String> genInfosUsed = [ala, note];

    await _setupService.modifySetup(setup.id, wheelsUsed, balanceUsed, springsUsed, dampersUsed, genInfosUsed);

    showToast("Setup modificata con successo");

    await updateStateDetailSetup();

    Navigator.pop(context);
    */

    if (setup.wheelAntDx == frontRightWheel &&
        setup.wheelAntSx == frontLeftWheel &&
        setup.wheelPostDx == rearRightWheel &&
        setup.wheelPostSx == rearLeftWheel &&
        setup.balanceAnt == frontBalance &&
        setup.balancePost == rearBalance &&
        setup.springAnt == frontSpring &&
        setup.springPost == rearSpring &&
        setup.damperAnt == frontDamper &&
        setup.damperPost == rearDamper &&
        setup.note == note &&
        setup.ala == ala) {
      showToast("Il setup definito è uguale a quello selezionato");

      Navigator.pop(context);
    } else {
      List<Wheel> wheels = [
        frontRightWheel,
        frontLeftWheel,
        rearRightWheel,
        rearLeftWheel
      ];
      List<int> wheelIds = [0, 0, 0, 0];
      List<Balance> balance = [frontBalance, rearBalance];
      List<int> balanceIds = [0, 0];
      List<Spring> springs = [frontSpring, rearSpring];
      List<int> springIds = [0, 0];
      List<Damper> dampers = [frontDamper, rearDamper];
      List<int> damperIds = [0, 0];

      final WheelService _wheelService = WheelService();
      final BalanceService _balanceService = BalanceService();
      final SpringService _springService = SpringService();
      final DamperService _damperService = DamperService();

      await Future.forEach(wheels.asMap().entries,
          (MapEntry<int, Wheel> entry) async {
        final index = entry.key;
        final wheel = entry.value;

        if (wheel.id == 0) {
          wheelIds[index] = await _wheelService.addNewWheel(wheel);
        } else {
          wheelIds[index] = wheel.id;
        }
      });

      await Future.forEach(balance.asMap().entries,
          (MapEntry<int, Balance> entry) async {
        final index = entry.key;
        final balance = entry.value;

        if (balance.id == 0) {
          balanceIds[index] = await _balanceService.addNewBalance(balance);
        } else {
          balanceIds[index] = balance.id;
        }
      });

      await Future.forEach(springs.asMap().entries,
          (MapEntry<int, Spring> entry) async {
        final index = entry.key;
        final spring = entry.value;

        if (spring.id == 0) {
          springIds[index] = await _springService.addNewSpring(spring);
        } else {
          springIds[index] = spring.id;
        }
      });

      await Future.forEach(dampers.asMap().entries,
          (MapEntry<int, Damper> entry) async {
        final index = entry.key;
        final damper = entry.value;

        if (damper.id == 0) {
          damperIds[index] = await _damperService.addNewDampers(damper);
        } else {
          damperIds[index] = damper.id;
        }
      });

      final wheelsUsed = <Wheel>[];
      wheels.asMap().forEach((index, wheel) {
        wheelsUsed.add(Wheel(
            id: wheelIds[index],
            codifica: wheel.codifica,
            posizione: wheel.posizione,
            frontale: wheel.frontale,
            superiore: wheel.superiore,
            pressione: wheel.pressione));
      });
      final balanceUsed = <Balance>[];
      balance.asMap().forEach((index, balance) {
        balanceUsed.add(Balance(
            id: balanceIds[index],
            posizione: balance.posizione,
            frenata: balance.frenata,
            peso: balance.peso));
      });
      final springsUsed = <Spring>[];
      springs.asMap().forEach((index, spring) {
        springsUsed.add(Spring(
            id: springIds[index],
            posizione: spring.posizione,
            codifica: spring.codifica,
            posizioneArb: spring.posizioneArb,
            rigidezzaArb: spring.rigidezzaArb,
            altezza: spring.altezza));
      });
      final dampersUsed = <Damper>[];
      dampers.asMap().forEach((index, damper) {
        dampersUsed.add(Damper(
            id: damperIds[index],
            posizione: damper.posizione,
            lsr: damper.lsr,
            hsr: damper.hsr,
            lsc: damper.lsc,
            hsc: damper.hsc));
      });
      List<String> genInfosUsed = [ala, note];

      await _setupService.createSetup(
          wheelsUsed, balanceUsed, springsUsed, dampersUsed, genInfosUsed);

      showToast("Il nuovo setup modificato è stato creato");

      Navigator.pop(context);
    }
  }
}
