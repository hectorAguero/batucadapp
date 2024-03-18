import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppImageNetwork extends StatelessWidget {
  const AppImageNetwork(this.url, {super.key});

  final String url;

  @override
  Widget build(BuildContext context) {
    /// This is a simple wrapper around [Image.network] to make it easier to
    /// switch to extended_image later.
    return Image.network(url);
  }
}

typedef AppNetworkImage = NetworkImage;
