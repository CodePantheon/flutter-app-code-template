import 'package:flutter/material.dart';

import 'helper_widgets.dart';

class StreamWidget<T> extends StatelessWidget {
  final Stream<T> stream;
  final Widget Function(T item) builder;

  const StreamWidget({this.stream, this.builder});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          return builder(null);
        }

        if (snapshot.hasData &&
            snapshot.connectionState != ConnectionState.waiting) {
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
