import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  /// The function `pushNamed` is used to navigate to a new route in Flutter using the route name and
  /// optional arguments.
  ///
  /// Args:
  ///   routeName (String): The name of the route to navigate to. It is typically a string that represents
  /// the route's identifier or path.
  ///   arguments (Object): The `arguments` parameter is an optional parameter that allows you to pass
  /// data to the new route when navigating using the `pushNamed` method. It can be of any type
  /// (`Object?`), meaning you can pass any object as an argument. This allows you to send data from the
  /// current route
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamed(routeName, arguments: arguments);

  /// The function `pushReplacementNamed` is used to navigate to a new route and replace the current route
  /// in the navigation stack.
  ///
  /// Args:
  ///   routeName (String): The name of the route to push and replace the current route with.
  ///   arguments (Object): The `arguments` parameter is an optional parameter that allows you to pass
  /// data to the new route when using the `pushReplacementNamed` method. It can be of any type
  /// (`Object?`), allowing you to pass any kind of data you need to the new route.
  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);

  /// The function `pushNamedAndRemoveUntil` is a Dart function that navigates to a named route and
  /// removes all previous routes until a certain condition is met.
  ///
  /// Args:
  ///   routeName (String): The name of the route to push onto the navigator's stack.
  ///   arguments (Object): The `arguments` parameter is an optional object that can be passed to the new
  /// route being pushed. It can be used to provide additional data or parameters to the new route.
  ///   predicate (RoutePredicate): The `predicate` parameter is a function that determines whether a
  /// route should be removed from the navigation stack. It takes a `Route` object as input and returns a
  /// boolean value. If the function returns `true`, the route will be removed from the stack. If it
  /// returns `false`, the route
  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
          {Object? arguments, required RoutePredicate predicate}) =>
      Navigator.of(this)
          .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);

  /// The function "pop" is used to navigate back to the previous screen.
  void pop() => Navigator.of(this).pop();
}
