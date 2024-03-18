import 'package:flutter/material.dart';
import 'package:samba_public_app/router/go_route_scroll_tab.dart';

class ParadesTab extends StatelessWidget {
  const ParadesTab({super.key});

  static final route = GoRouteScrollTab(
    path: '/parades',
    builder: (context, state, controller) => PrimaryScrollController(
      controller: controller,
      child: const ParadesTab(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parades'),
      ),
      body: ListView.builder(
        controller: PrimaryScrollController.of(context),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Parade $index'),
            onTap: () {},
          );
        },
        itemCount: 100,
      ),
    );
  }
}
