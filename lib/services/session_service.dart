import 'dart:math';

import 'package:polimarche/model/Breakage.dart';
import 'package:polimarche/model/Participation.dart';
import 'package:polimarche/model/Session.dart';
import 'package:polimarche/model/Setup.dart';
import 'package:polimarche/model/Track.dart';
import 'package:polimarche/model/Comment.dart';
import 'package:polimarche/repository/comment_repository.dart';
import 'package:polimarche/repository/driver_repository.dart';
import 'package:polimarche/repository/participation_repository.dart';
import 'package:polimarche/repository/session_repository.dart';
import 'package:polimarche/repository/track_repository.dart';
import 'package:polimarche/repository/used_setup_repository.dart';

import '../model/BreakageHappen.dart';
import '../model/driver_model.dart';
import '../model/UsedSetup.dart';
import '../repository/breakage_happen_repository.dart';
import '../repository/breakage_repository.dart';
import '../repository/setup_repository.dart';

class SessionService {
  late SessionRepository sessionRepository;
  late TrackRepository trackRepository;
  late CommentRepository commentRepository;
  late ParticipationRepository participationRepository;
  late DriverRepository driverRepository;
  late SetupRepository setupRepository;
  late UsedSetupRepository usedSetupRepository;
  late BreakageRepository breakageRepository;
  late BreakageHappenRepository breakageHappenRepository;

  late List<Session> listSessions;
  late List<Track> listTracks;
  late List<Comment> listComments;
  late List<Participation> listParticipations;
  late List<Driver> listDrivers;
  late List<Setup> listSetups;
  late List<UsedSetup> listUsedSetups;
  late List<Breakage> listBreakages;
  late List<BreakageHappen> listBreakagesHappened;

  SessionService() {
    sessionRepository = SessionRepository();
    trackRepository = TrackRepository();
    commentRepository = CommentRepository();
    participationRepository = ParticipationRepository();
    driverRepository = DriverRepository();
    setupRepository = SetupRepository();
    usedSetupRepository = UsedSetupRepository();
    breakageRepository = BreakageRepository();
    breakageHappenRepository = BreakageHappenRepository();

    listTracks = trackRepository.listTracks;
    listSessions = sessionRepository.listSessions;
    listComments = commentRepository.listComments;
    listParticipations = participationRepository.listParticipations;
    listDrivers = driverRepository.listDrivers;
    listSetups = setupRepository.listSetups;
    listUsedSetups = usedSetupRepository.listSetupsUsed;
    listBreakages = breakageRepository.listBreakages;
    listBreakagesHappened = breakageHappenRepository.listBreakagesHappened;
  }

  void updateLists() {
    listTracks = trackRepository.listTracks;
    listSessions = sessionRepository.listSessions;
    listComments = commentRepository.listComments;
    listParticipations = participationRepository.listParticipations;
    listDrivers = driverRepository.listDrivers;
    listSetups = setupRepository.listSetups;
    listUsedSetups = usedSetupRepository.listSetupsUsed;
    listBreakages = breakageRepository.listBreakages;
    listBreakagesHappened = breakageHappenRepository.listBreakagesHappened;
  }

  List<Comment> getCommentsBySessionId(int sessionId) {
    return listComments
        .where((element) => element.sessione.id == sessionId)
        .toList();
  }

  void deleteComment(Comment comment) {
    commentRepository.delete(comment);
    updateLists();
  }

  void modifyComment(
      Comment oldComment, String newDescrizione, String newFlag) {
    commentRepository.modifyComment(oldComment, newDescrizione, newFlag);
    updateLists();
  }

  void addComment(String newDescrizione, String newFlag, Session session) {
    commentRepository.addComment(newDescrizione, newFlag, session);
    updateLists();
  }

  Track findTrackByName(String trackName) {
    return listTracks.where((element) => element.nome == trackName).first;
  }

  Session findSessionById(int sessionId) {
    return listSessions.where((element) => element.id == sessionId).first;
  }

  void modifySession(Session newSession) {
    sessionRepository.modifySession(newSession);
    updateLists();
  }

  void addSession(Session newSession) {
    sessionRepository.addSession(newSession);
    updateLists();
  }

  List<Participation> findParticipationsBySessionId(int sessionId) {
    return listParticipations
        .where((element) => element.sessione.id == sessionId)
        .toList();
  }

  List<Driver> findDriversNotParticipatingSession(int sessionId) {
    return [];
  }

  void addNewParticipation(String hour, String min, String sec, String mil,
      String _newDriverParticipationId, int sessionId) {
    /*
    Driver driver = listDrivers
        .where((element) => element.id == int.parse(_newDriverParticipationId))
        .first;
    int maxOrdine = findParticipationsBySessionId(sessionId)
        .map<int>((obj) => obj.ordine) // Extract the ordine attribute
        .reduce((currentMax, value) => currentMax > value ? currentMax : value);
    String newDriverChange = hour + ":" + min + ":" + sec + "." + mil;
    Session session = findSessionById(sessionId);

    Participation newParticipation = Participation(
        listParticipations.last.id + 1,
        driver,
        session,
        maxOrdine + 1,
        newDriverChange);

    participationRepository.addNewParticipation(newParticipation);

    updateLists();

     */
  }

  List<UsedSetup> findUsedSetupsBySessionId(int sessionId) {
    return listUsedSetups
        .where((element) => element.sessione.id == sessionId)
        .toList();
  }

  List<Setup> findSetupNotUsedDuringSession(int sessionId) {
    List<UsedSetup> usedSetups = findUsedSetupsBySessionId(sessionId);

    List<Setup> setupNotUsed = listSetups.where((setup) {
      return !usedSetups.any((usedSetup) => usedSetup.setup.id == setup.id);
    }).toList();

    return setupNotUsed;
  }

  void addNewUsedSetup(
      int sessionId, String newSetupUsedId, String newComment) {
    Session session = findSessionById(sessionId);

    Setup setup = findSetupById(newSetupUsedId);

    UsedSetup newUsedSetup = UsedSetup(
        id: listUsedSetups.last.id + 1,
        sessione: session,
        setup: setup,
        commento: newComment);

    usedSetupRepository.addNewUsedSetup(newUsedSetup);

    updateLists();
  }

  Setup findSetupById(String newSetupUsedId) {
    return listSetups
        .where((element) => element.id.toString() == newSetupUsedId)
        .first;
  }

  Breakage findBrekageById(String newBreakageHappenedBreakageId) {
    return listBreakages
        .where((element) => element.id.toString() == newBreakageHappenedBreakageId)
        .first;
  }

  List<BreakageHappen> findBreakagesHappenedDuringSession(int sessionId) {
    return listBreakagesHappened
        .where((element) => element.sessione.id == sessionId)
        .toList();
  }

  void addNewBreakageHappened(String newBreakageHappenedBreakageId,
      String description, bool colpaPilota, int sessionId) {

    Session session = findSessionById(sessionId);
    Breakage breakage = findBrekageById(newBreakageHappenedBreakageId);

    BreakageHappen breakageHappen = BreakageHappen(listBreakagesHappened.last.id + 1, description, session, breakage, colpaPilota);

    breakageHappenRepository.addBreakageHappend(breakageHappen);

    updateLists();
  }


}
