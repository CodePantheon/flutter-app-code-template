import 'package:flutter/material.dart';

import 'helper_widgets.dart';

class FutureWidget<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(T item) builder;

  const FutureWidget({this.future, this.builder});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return builder(snapshot.data);
        } else if (snapshot.hasError) {
          return ErrorIndicator(error: snapshot.error);
        } else {
          return LoadingIndicator();
        }
      },
    );
  }
}
