import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin {

  // define the controller for the animation
  late AnimationController _controller;
  // define the animation
  late Animation<double> _animation;
  // define the path of the logo
  String logo = 'logo_polimarche_colori.png';

   @override
  void initState() {
    super.initState();

    // sets the value of the controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this
    );

    // sets the value of the animation
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate
    );

    // add a listener to the animation
    _animation.addStatusListener((status) {
      // checks if the animation is completed
      if (status == AnimationStatus.completed) {
        // removes the current route and add '/login' route to the stack
        Navigator.popAndPushNamed(
            context,
            '/login'
        );
      }
    });

    // starts the animation
    _controller.forward();
  }

  // called when _LoadingState is removed
  @override
  void dispose() {
    // cleans up the resource related to the animation
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Image(
            image: AssetImage(
              'assets/$logo'
            ),
          )
        ),
      ),
    );
  }
}
