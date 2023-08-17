import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:polimarche/inherited_widgets/agenda_state.dart';
import 'package:polimarche/model/Note.dart';
import 'package:intl/intl.dart';


class CardNoteListItem extends StatefulWidget {
  final Note note;

  const CardNoteListItem({
    required this.note,
    super.key
  });

  @override
  State<CardNoteListItem> createState() => _CardNoteListItemState();
}

class _CardNoteListItemState extends State<CardNoteListItem> {
  bool isModificaPressed = false;
  bool isCancellaPressed = false;

  @override
  Widget build(BuildContext context) {
    final note = widget.note;
    final noteService = AgendaInheritedState.of(context)!;

    final backgroundColor = Colors.grey.shade300;
    Offset distanceModifica = isModificaPressed ? Offset(5, 5) : Offset(8, 8);
    double blurModifica = isModificaPressed ? 5 : 10;
    Offset distanceCancella = isCancellaPressed ? Offset(5, 5) : Offset(8, 8);
    double blurCancella = isCancellaPressed ? 5 : 10;



    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          const Radius.circular(12),
        ),
        color: backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.shade500,
            offset: Offset(5, 5),
            blurRadius: 15,
            inset: false
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(-5, -5),
            blurRadius: 10,
            inset: false
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
              "${note.descrizione}",
              style: TextStyle(
                fontSize: 16
              ),
          ),
          SizedBox(height: 5),
          Text(
              "${DateFormat('EEEE, MMM d, yyyy').format(note.data)}",
            style: TextStyle(
              fontSize: 15
            ),
          ),
          SizedBox(height: 2),
          Text(
              "${DateFormat('HH:mm:ss').format(note.ora_inizio)} "
                  "- ${DateFormat('HH:mm:ss').format(note.ora_fine)}"
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _modificaButton(backgroundColor, distanceModifica, blurModifica),

              _cancellaButton(backgroundColor, distanceCancella, blurCancella),
            ],
          )
        ],
      ),
    );
  }

  Listener _cancellaButton(Color backgroundColor, Offset distanceCancella, double blurCancella) {
    return Listener(
              onPointerDown: (_) async {
                setState(() => isCancellaPressed = true); // Reset the state
                await Future.delayed(const Duration(milliseconds: 200)); // Wait for animation

                setState(() => isCancellaPressed = false); // Reset the state,
              },
              child: AnimatedContainer(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                duration: Duration(milliseconds: 150),
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: isCancellaPressed ? [
                      BoxShadow(
                          offset: distanceCancella,
                          blurRadius: blurCancella,
                          color: Colors.grey.shade500,
                          inset: true
                      ),
                      BoxShadow(
                          offset: -distanceCancella,
                          blurRadius: blurCancella,
                          color: Colors.white,
                          inset: true
                      ),
                    ] : []
                ),
                child: Row(
                    children: [
                      Text(
                        "Cancella",
                        style: TextStyle(
                            color: Colors.black
                        ),
                      ),
                      Icon(
                        Icons.delete_forever,
                        color: Colors.black,
                      )
                    ]
                ),
              ),
            );
  }

  Listener _modificaButton(Color backgroundColor, Offset distanceModifica, double blurModifica) {
    return Listener(
              onPointerDown: (_) async {
                setState(() => isModificaPressed = true); // Reset the state
                await Future.delayed(const Duration(milliseconds: 200)); // Wait for animation

                setState(() => isModificaPressed = false); // Reset the state,
              },
              child: AnimatedContainer(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                duration: Duration(milliseconds: 150),
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: isModificaPressed ? [
                      BoxShadow(
                          offset: distanceModifica,
                          blurRadius: blurModifica,
                          color: Colors.grey.shade500,
                          inset: true
                      ),
                      BoxShadow(
                          offset: -distanceModifica,
                          blurRadius: blurModifica,
                          color: Colors.white,
                          inset: true
                      ),
                    ] : []
                ),
                child: Row(
                    children: [
                      Text(
                        "Modifica",
                        style: TextStyle(
                            color: Colors.black
                        ),
                      ),
                      Icon(
                        Icons.event_note,
                        color: Colors.black,
                      )
                    ]
                ),
              ),
            );
  }
}
