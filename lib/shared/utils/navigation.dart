import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

@override
bool canTransitionFrom(TransitionRoute<dynamic> previousRoute) {
  return previousRoute is MaterialPageRoute;
}

// NAVIGATE TO THE NEXT SCREEN AND STILL GO BACK TO PREVIOUS SCREEN
void push(BuildContext context, {Widget? screen}) {
  Navigator.push(context, CupertinoPageRoute(builder: (context) => screen!));
}

// NAVIGATE TO THE NEXT SCREEN WITHOUT GOING BACK TO THE PREVIOUS SCREEN
void pushReplacement(BuildContext context, {Widget? screen}) {
  Navigator.pushReplacement(
      context, CupertinoPageRoute(builder: (context) => screen!));
}

void pushRemove(BuildContext context, {Widget? screen}) {
  Navigator.pushAndRemoveUntil(context,
      CupertinoPageRoute(builder: (context) => screen!), (route) => false);
}

void pop(BuildContext context) {
  Navigator.pop(context);
}

// CUSTOMISE PAGE TRANSITION
class PageTransition extends PageRouteBuilder {
  final Widget? child;

  PageTransition({
    this.child,
  }) : super(
            pageBuilder: (context, animation, secondaryAnimation) {
              return child!;
            },
            transitionDuration: const Duration(milliseconds: 100),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                transformHitTests: false,
                position: Tween(begin:const  Offset(1.0, 0.0), end: Offset.zero)
                    .animate(animation),
                child: SlideTransition(
                  position: Tween(begin: Offset.zero, end: const Offset(-1.0, 0.0))
                      .animate(secondaryAnimation),
                  child: child,
                ),
              );
            });
}

class SlideUpRoute extends PageRouteBuilder {
  final Widget? page;
  SlideUpRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}