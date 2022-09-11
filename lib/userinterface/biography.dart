import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Biography extends StatefulWidget {
  final String biography;
  const Biography({Key? key, required this.biography}) : super(key: key);

  @override
  State<Biography> createState() => _BiographyState();
}

class _BiographyState extends State<Biography> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebviewScaffold(url: widget.biography),
    );
  }
}
