import 'package:flutter/material.dart';
import 'package:samba_public_app/router/router.dart';

class InstrumentsTab extends StatelessWidget {
  const InstrumentsTab({super.key});

  static final route = AppBaseRoute(
    path: '/instruments',
    builder: (context, state, controller) => PrimaryScrollController(
      controller: controller,
      child: const InstrumentsTab(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: PrimaryScrollController.of(context),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Instrument $index'),
          onTap: () {},
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: 100,
    );
  }
}
