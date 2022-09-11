import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Movie extends StatefulWidget {
  final String movie;
  const Movie({Key? key, required this.movie}) : super(key: key);

  @override
  State<Movie> createState() => _MovieState();
}

class _MovieState extends State<Movie> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebviewScaffold(url: widget.movie),
    );
  }
}
