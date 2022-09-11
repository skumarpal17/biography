import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Gallery extends StatefulWidget {
  final String gallery;
  const Gallery({Key? key, required this.gallery}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebviewScaffold(url: widget.gallery),
    );
  }
}
