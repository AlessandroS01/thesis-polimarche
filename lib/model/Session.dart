import 'Track.dart';

class Session {

  int id;
  String evento;
  DateTime data;
  DateTime oraInizio;
  DateTime oraFine;
  Track tracciato;
  String meteo;
  double pressioneAtmosferica;
  double temperaturaAria;
  double temperaturaTracciato;
  String condizioneTracciato;

  Session(
      this.id,
      this.evento,
      this.data,
      this.oraInizio,
      this.oraFine,
      this.tracciato,
      this.meteo,
      this.pressioneAtmosferica,
      this.temperaturaAria,
      this.temperaturaTracciato,
      this.condizioneTracciato);
}