import 'package:flutter/material.dart';

class DetailsSummary extends StatelessWidget {
  const DetailsSummary({required this.detailsDescription, super.key});

  final String detailsDescription;

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Amet ut minim aliquip ea reprehenderit ad aliqua fugiat ipsum. Eu adipisicing irure non commodo consequat consectetur nisi enim sit sunt ad in laboris. Qui voluptate officia laborum cupidatat culpa dolore consequat proident nisi culpa.',
    );
  }
}
