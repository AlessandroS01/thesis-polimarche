import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/services.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:polimarche/model/member_model.dart';

import '../../../model/setup_model.dart';
import '../../../service/setup_service.dart';
import 'modify/modify_setup_page.dart';
import 'setup_card.dart';

class DetailSetup extends StatefulWidget {
  final Setup setup;
  final Member loggedMember;
  final Future<void> Function() updateStateSetupPage;

  const DetailSetup({
    super.key,
    required this.setup,
    required this.loggedMember,
    required this.updateStateSetupPage,
  });

  @override
  State<DetailSetup> createState() => _DetailSetupState();
}

class _DetailSetupState extends State<DetailSetup> {
  final backgroundColor = Colors.grey.shade300;
  late final Member loggedMember;
  late Setup setup;
  late final SetupService _setupService;

  bool isModifyButtonPressed = false;
  bool isExcelButtonPressed = false;

  Future<void> _refreshState() async {
    // update the card
    Setup newSetup = await _setupService.getSetupById(setup.id);

    setState(() {
      setup = newSetup;
    });

    // update the main page
    await widget.updateStateSetupPage();
  }

  @override
  void initState() {
    super.initState();
    _setupService = SetupService();
    loggedMember = widget.loggedMember;
    setup = widget.setup;
  }

  @override
  Widget build(BuildContext context) {
    Offset distanceModify =
        isModifyButtonPressed ? Offset(5, 5) : Offset(18, 18);
    double blurModify = isModifyButtonPressed ? 5.0 : 30.0;

    Offset distanceExcel = isExcelButtonPressed ? Offset(5, 5) : Offset(18, 18);
    double blurExcel = isExcelButtonPressed ? 5.0 : 30.0;

    return Scaffold(
      appBar: _appBar(backgroundColor),
      body: Container(
        height: MediaQuery.of(context)
            .size
            .height, // Set a finite height constraint
        decoration: BoxDecoration(color: backgroundColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SETUP CARD
            CardSetup(setup: setup),

            loggedMember.ruolo == "Manager" ||
                    loggedMember.ruolo == "Caporeparto"
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child:
                                    _modifyButton(distanceModify, blurModify)),
                            Expanded(
                                child: _excelButton(distanceExcel, blurExcel)),
                          ],
                        ),
                      ],
                    ),
                  )
                : Expanded(child: Container())
          ],
        ),
      ),
    );
  }

  AppBar _appBar(Color backgroundColor) {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor,
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        "Dettagli setup",
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
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

  Listener _modifyButton(
    Offset distanceComment,
    double blurComment,
  ) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isModifyButtonPressed = true);

        await Future.delayed(
            const Duration(milliseconds: 170)); // Wait for animation

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ModifySetupPage(
              setup: setup,
              updateStateSetupPage: _refreshState,
            ),
          ),
        );

        setState(() => isModifyButtonPressed = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: isModifyButtonPressed
                ? [
                    //
                    BoxShadow(
                        color: Colors.grey.shade500,
                        offset: distanceComment,
                        blurRadius: blurComment,
                        inset: isModifyButtonPressed),
                    BoxShadow(
                        color: Colors.white,
                        offset: -distanceComment,
                        blurRadius: blurComment,
                        inset: isModifyButtonPressed),
                  ]
                : []),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Modifica setup"),
            //Icon(Icons.group)
          ],
        ),
      ),
    );
  }

  Listener _excelButton(
    Offset distanceExcel,
    double blurExcel,
  ) {
    return Listener(
      onPointerDown: (_) async {
        setState(() => isExcelButtonPressed = true);

        await Future.delayed(
            const Duration(milliseconds: 170)); // Wait for animation

        await _createExcel();
        showToast(
            "L'excel è stato salvato nella cartella 'Download' del dispositivo");

        setState(() => isExcelButtonPressed = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: isExcelButtonPressed
                ? [
                    //
                    BoxShadow(
                        color: Colors.grey.shade500,
                        offset: distanceExcel,
                        blurRadius: blurExcel,
                        inset: isExcelButtonPressed),
                    BoxShadow(
                        color: Colors.white,
                        offset: -distanceExcel,
                        blurRadius: blurExcel,
                        inset: isExcelButtonPressed),
                  ]
                : []),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Genera excel"),
            //Icon(Icons.group)
          ],
        ),
      ),
    );
  }

  Future<void> _createExcel() async {
    Directory? directory = Directory('/storage/emulated/0/Download');
    // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
    // ignore: avoid_slow_async_io
    if (!await directory.exists())
      directory = await getExternalStorageDirectory();

    final ByteData templateData =
        await rootBundle.load("assets/excel_templates/SetupTemplate.xlsx");
    final List<int> templateByte = templateData.buffer.asUint8List();

    final String fileName = "${directory?.path}/Setup${setup.id}.xlsx";
    final File file = File(fileName);

    await file.writeAsBytes(templateByte, flush: true);
    await _uploadData(file, templateByte);
  }

  void setFormat(Sheet sheetObject) {
    sheetObject.cell(CellIndex.indexByString("A1")).value = "SETUP ${setup.id}";

    sheetObject.cell(CellIndex.indexByString("D1")).value = "FRONT";
    sheetObject.cell(CellIndex.indexByString("J1")).value = "REAR";

    sheetObject.cell(CellIndex.indexByString("D3")).value = "RIGHT";
    sheetObject.cell(CellIndex.indexByString("G3")).value = "LEFT";
    sheetObject.cell(CellIndex.indexByString("J3")).value = "RIGHT";
    sheetObject.cell(CellIndex.indexByString("M3")).value = "LEFT";

    sheetObject.cell(CellIndex.indexByString("A5")).value = "FRONT WING";

    sheetObject.cell(CellIndex.indexByString("A7")).value = "WHEELS";
    sheetObject.cell(CellIndex.indexByString("B7")).value = "ID";
    sheetObject.cell(CellIndex.indexByString("B9")).value = "CODIFICATION";
    sheetObject.cell(CellIndex.indexByString("B11")).value = "PRESSURE";
    sheetObject.cell(CellIndex.indexByString("B13")).value = "CAMBER";
    sheetObject.cell(CellIndex.indexByString("B15")).value = "TOE";

    sheetObject.cell(CellIndex.indexByString("A17")).value = "BALANCE";
    sheetObject.cell(CellIndex.indexByString("B17")).value = "ID";
    sheetObject.cell(CellIndex.indexByString("B19")).value = "WEIGHT";
    sheetObject.cell(CellIndex.indexByString("B21")).value = "BRAKE";

    sheetObject.cell(CellIndex.indexByString("A23")).value = "SPRINGS";
    sheetObject.cell(CellIndex.indexByString("B23")).value = "ID";
    sheetObject.cell(CellIndex.indexByString("B25")).value = "CODIFICATION";
    sheetObject.cell(CellIndex.indexByString("B27")).value = "POSITION ARB";
    sheetObject.cell(CellIndex.indexByString("B29")).value = "STIFFNESS ARB";
    sheetObject.cell(CellIndex.indexByString("B31")).value = "HEIGHT";

    sheetObject.cell(CellIndex.indexByString("A33")).value = "DAMPER";
    sheetObject.cell(CellIndex.indexByString("B33")).value = "ID";
    sheetObject.cell(CellIndex.indexByString("B35")).value = "LSR";
    sheetObject.cell(CellIndex.indexByString("B37")).value = "HSR";
    sheetObject.cell(CellIndex.indexByString("B39")).value = "LSC";
    sheetObject.cell(CellIndex.indexByString("B41")).value = "HSC";

    sheetObject.cell(CellIndex.indexByString("A43")).value = "NOTES";
  }

  Future<void> _uploadData(File file, List<int> bytes) async {
    Excel excel = Excel.decodeBytes(bytes);
    Sheet sheetObject = excel['Setup'];

    setFormat(sheetObject);

    sheetObject.cell(CellIndex.indexByString("D5")).value = "${setup.ala}";

    sheetObject.cell(CellIndex.indexByString("D7")).value =
        "${setup.wheelAntDx.id}";
    sheetObject.cell(CellIndex.indexByString("G7")).value =
        "${setup.wheelAntSx.id}";
    sheetObject.cell(CellIndex.indexByString("J7")).value =
        "${setup.wheelPostDx.id}";
    sheetObject.cell(CellIndex.indexByString("M7")).value =
        "${setup.wheelPostSx.id}";
    sheetObject.cell(CellIndex.indexByString("D9")).value =
        "${setup.wheelAntDx.codifica}";
    sheetObject.cell(CellIndex.indexByString("G9")).value =
        "${setup.wheelAntSx.codifica}";
    sheetObject.cell(CellIndex.indexByString("J9")).value =
        "${setup.wheelPostDx.codifica}";
    sheetObject.cell(CellIndex.indexByString("M9")).value =
        "${setup.wheelPostSx.codifica}";
    sheetObject.cell(CellIndex.indexByString("D11")).value =
        "${setup.wheelAntDx.pressione} mBar";
    sheetObject.cell(CellIndex.indexByString("G11")).value =
        "${setup.wheelAntSx.pressione} mBar";
    sheetObject.cell(CellIndex.indexByString("J11")).value =
        "${setup.wheelPostDx.pressione} mBar";
    sheetObject.cell(CellIndex.indexByString("M11")).value =
        "${setup.wheelPostSx.pressione} mBar";
    sheetObject.cell(CellIndex.indexByString("D13")).value =
        "${setup.wheelAntDx.frontale}";
    sheetObject.cell(CellIndex.indexByString("G13")).value =
        "${setup.wheelAntSx.frontale}";
    sheetObject.cell(CellIndex.indexByString("J13")).value =
        "${setup.wheelPostDx.frontale}";
    sheetObject.cell(CellIndex.indexByString("M13")).value =
        "${setup.wheelPostSx.frontale}";
    sheetObject.cell(CellIndex.indexByString("D15")).value =
        "${setup.wheelAntDx.superiore}";
    sheetObject.cell(CellIndex.indexByString("G15")).value =
        "${setup.wheelAntSx.superiore}";
    sheetObject.cell(CellIndex.indexByString("J15")).value =
        "${setup.wheelPostDx.superiore}";
    sheetObject.cell(CellIndex.indexByString("M15")).value =
        "${setup.wheelPostSx.superiore}";

    sheetObject.cell(CellIndex.indexByString("D17")).value =
        "${setup.balanceAnt.id}";
    sheetObject.cell(CellIndex.indexByString("J17")).value =
        "${setup.balancePost.id}";
    sheetObject.cell(CellIndex.indexByString("D19")).value =
        "${setup.balanceAnt.peso} %";
    sheetObject.cell(CellIndex.indexByString("J19")).value =
        "${setup.balancePost.peso} %";
    sheetObject.cell(CellIndex.indexByString("D21")).value =
        "${setup.balanceAnt.frenata} %";
    sheetObject.cell(CellIndex.indexByString("J21")).value =
        "${setup.balancePost.frenata} %";

    sheetObject.cell(CellIndex.indexByString("D23")).value =
        "${setup.springAnt.id}";
    sheetObject.cell(CellIndex.indexByString("J23")).value =
        "${setup.springPost.id}";
    sheetObject.cell(CellIndex.indexByString("D25")).value =
        "${setup.springAnt.codifica}";
    sheetObject.cell(CellIndex.indexByString("J25")).value =
        "${setup.springPost.codifica}";
    sheetObject.cell(CellIndex.indexByString("D27")).value =
        "${setup.springAnt.posizioneArb}";
    sheetObject.cell(CellIndex.indexByString("J27")).value =
        "${setup.springPost.posizioneArb}";
    sheetObject.cell(CellIndex.indexByString("D29")).value =
        "${setup.springAnt.rigidezzaArb}";
    sheetObject.cell(CellIndex.indexByString("J29")).value =
        "${setup.springPost.rigidezzaArb}";
    sheetObject.cell(CellIndex.indexByString("D31")).value =
        "${setup.springAnt.altezza} mm";
    sheetObject.cell(CellIndex.indexByString("J31")).value =
        "${setup.springPost.altezza} mm";

    sheetObject.cell(CellIndex.indexByString("D33")).value =
        "${setup.damperAnt.id}";
    sheetObject.cell(CellIndex.indexByString("J33")).value =
        "${setup.damperPost.id}";
    sheetObject.cell(CellIndex.indexByString("D35")).value =
        "${setup.damperAnt.lsr}";
    sheetObject.cell(CellIndex.indexByString("J35")).value =
        "${setup.damperPost.lsr}";
    sheetObject.cell(CellIndex.indexByString("D37")).value =
        "${setup.damperAnt.hsr}";
    sheetObject.cell(CellIndex.indexByString("J37")).value =
        "${setup.damperPost.hsr}";
    sheetObject.cell(CellIndex.indexByString("D39")).value =
        "${setup.damperAnt.lsc}";
    sheetObject.cell(CellIndex.indexByString("J39")).value =
        "${setup.damperPost.lsc}";
    sheetObject.cell(CellIndex.indexByString("D41")).value =
        "${setup.damperAnt.hsc}";
    sheetObject.cell(CellIndex.indexByString("J41")).value =
        "${setup.damperPost.hsc}";

    sheetObject.cell(CellIndex.indexByString("D43")).value = "${setup.note}";

    await file.writeAsBytes(excel.encode()!, flush: true);
  }


}
