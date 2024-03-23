import 'package:flutter/material.dart';
import 'package:samba_public_app/extensions/hardcoded_extension.dart';

class InstrumentDetailsSummary extends StatelessWidget {
  const InstrumentDetailsSummary({
    required this.details,
    super.key,
  });

  final String details;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                '''
Amet ut minim aliquip ea reprehenderit ad aliqua fugiat ipsum. Eu adipisicing irure non commodo consequat consectetur nisi enim sit sunt ad in laboris. Qui voluptate officia laborum cupidatat culpa dolore consequat proident nisi culpa.
    
Occaecat laborum aliquip duis incididunt enim dolor proident labore. Culpa cillum nostrud et in occaecat nulla quis qui amet nostrud pariatur voluptate deserunt. Pariatur excepteur officia amet voluptate deserunt tempor non eiusmod incididunt adipisicing eu Lorem ipsum aliqua. Duis ex esse nisi aute.
    
Incididunt sit enim nisi nostrud officia exercitation non labore incididunt laboris eu. Duis aliquip fugiat consequat consequat magna tempor culpa dolore duis do veniam ad ipsum. Qui irure incididunt ea elit cupidatat aliquip ut. Cupidatat consectetur do est veniam esse minim eu anim ullamco commodo et culpa nostrud. Aliqua anim id anim officia in et ad et aliqua ipsum. Est laboris nulla proident incididunt. Lorem laborum officia duis culpa ipsum cillum occaecat Lorem laborum proident.
    
Lorem incididunt ullamco eiusmod voluptate cillum. Tempor deserunt enim nisi ex velit deserunt aliquip mollit. Do commodo nisi ea sit sint duis sint exercitation dolor proident. Duis Lorem enim labore laboris officia commodo anim veniam non ea elit. Aliquip id consectetur labore dolore aliqua ullamco culpa consectetur minim Lorem. Et eiusmod laboris laborum aliqua officia excepteur consequat aliquip aliquip occaecat dolore commodo culpa.
    
Laborum ullamco non aliqua nisi laboris. Anim ullamco velit laboris occaecat non commodo ut. Minim velit in ad velit. Est exercitation incididunt elit quis deserunt. Amet quis commodo cillum exercitation ut reprehenderit aliqua deserunt velit Lorem consequat tempor sit duis.
              '''
                    .hardcoded,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
