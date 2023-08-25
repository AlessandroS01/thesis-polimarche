import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:polimarche/model/Track.dart';

class CardTrackListItem extends StatefulWidget {
  final Track track;

  const CardTrackListItem(
      {required this.track});

  @override
  State<CardTrackListItem> createState() => _CardTrackListItemState();
}

class _CardTrackListItemState extends State<CardTrackListItem> {
  final backgroundColor = Colors.grey.shade300;

  late Track track;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    track = widget.track;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
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
              inset: false),
          BoxShadow(
              color: Colors.white,
              offset: Offset(-5, -5),
              blurRadius: 10,
              inset: false),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "${track.nome}",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 5),
          Text(
            "${track.lunghezza} km",
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }

}
