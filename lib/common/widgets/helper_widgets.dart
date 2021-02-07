import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          width: 50.0,
          height: 50.0,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class ErrorIndicator extends StatelessWidget {
  final Object error;

  const ErrorIndicator({@required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "ERROR IN LOADING:\n" + error.toString(),
        style: TextStyle(color: Colors.red, fontSize: 18.0),
      ),
    );
  }
}

class NoDataIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "No Data Found",
          style: TextStyle(color: Colors.white, fontSize: 24.0),
        ),
      ),
    );
  }
}