import '../model/Driver.dart';
import '../model/Member.dart';
import '../model/Workshop.dart';

class TeamService {

  late List<Member> members;

  late List<Workshop> workshops;

  late List<Driver> drivers;

  TeamService() {
    members = [
      Member(0, "Alessandro", "AA", DateTime(2001, 10, 10, 0, 0, 0), "S1097941@univpm.it", "3927602953", "Caporeparto", Workshop("Aereodinamica")),
      Member(1097941, "Francesco", "AA", DateTime(2001, 10, 10, 0, 0, 0), "S1097941@univpm.it", "3927602953", "Caporeparto", Workshop("Telaio")),
      Member(2, "Antonio", "AA", DateTime(2001, 10, 10, 0, 0, 0), "S1097941@univpm.it", "3927602953", "Manager", Workshop("")),
      Member(21, "Ponzio", "AA", DateTime(2001, 10, 10, 0, 0, 0), "S1097941@univpm.it", "3927602953", "Caporeparto", Workshop("Battery pack")),
      Member(5, "M", "AA", DateTime(2001, 10, 10, 0, 0, 0), "S1097941@univpm.it", "3927602953", "Membro", Workshop("Battery pack")),
      Member(789, "Ponzio", "AA", DateTime(2001, 10, 10, 0, 0, 0), "S1097941@univpm.it", "3927602953", "Caporeparto", Workshop("Battery pack")),
      Member(15, "Ponzio", "AA", DateTime(2001, 10, 10, 0, 0, 0), "S1097941@univpm.it", "3927602953", "Caporeparto", Workshop("Marketing")),
    ];

    workshops = [
      Workshop("Aereodinamica"),
      Workshop("Telaio"),
      Workshop("Battery pack"),
      Workshop("Marketing"),
      Workshop("Elettronica"),
      Workshop("Dinamica"),
    ];

    drivers = [
      Driver(1, Member(1097941, "Francesco", "AA", DateTime(2001, 10, 10, 0, 0, 0), "S1097941@univpm.it", "3927602953", "Caporeparto", Workshop("Telaio")), 80, 180),
      Driver(4, Member(789, "Ponzio", "AA", DateTime(2001, 10, 10, 0, 0, 0), "S1097941@univpm.it", "3927602953", "Caporeparto", Workshop("Battery pack")), 80, 180),
    ];
  }


  void addNewDriver(
      int height,
      double weight,
      Member member
      ) {

    drivers.add(
        Driver(0,
            member,
            weight,
            height)
    );


  }

}