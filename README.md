# polimarche


The goal of the work is represented by the development of a mobile application that efficiently manages the entire team of the Polimarche Racing Team, a team from the Polytechnic University of the Marche region that competes in the international Formula SAE championship.
The main problem that led to the development of the software is related to the team's previous method of managing information. Previously, all this information was recorded on paper sheets or separate Excel documents. With the introduction of the app, it is now possible to store all this information in one place. This makes access to information regarding various car setup parameters or test sessions much more convenient and organized.
The application has been entirely produced using Flutter, a framework created by Google that provides developers with a set of tools useful for developing cross- platform applications.
Among the various functional requirements, the application must provide the ability to distinguish between 3 different types of users. The first is the mana- ger, who within Polimarche corresponds to the Team Leader. The second group comprises all the department heads, i.e., the members who lead the various de- partments of the team. The third and final level groups together all the remaining members.
Furthermore, the app must allow the team to perform CRU (Create, Read, Update) actions on elements of greater importance such as setups and test sessions.
Based on the authentication level, the functionalities change. For example, only managers and department heads can add and/or modify a setup or a session. From this information, an architectural plan for the software development has been created.
The backend has been implemented in two different ways. Initially, Fire- base was used, a platform developed by Google that provides developers with a set of cloud services, such as Firestore for managing data and Fireauth for authentication.
Due to the limitations of Firebase, in case there is a need to increase the app's functionalities in the future, such as inserting and displaying all the data collected by sensors during a test session, a program has been implemented using Spring Boot, a framework based on Spring that allows creating an API. The application uses only Firebase.
As for the front-end, the software has been developed in Flutter. The ap- plication's infrastructure is represented by the service repository pattern, which allows separating the business logic (service) from data management (repository) to promote code modularity and maintainability.
