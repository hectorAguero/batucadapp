import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef InstrumentId = int;

class InstrumentDetailsPage extends StatelessWidget {
  const InstrumentDetailsPage({required this.id, super.key});

  final InstrumentId id;

  static GoRoute route = GoRoute(
    path: 'details/:id',
    builder: (context, state) {
      final pathParams = state.extra! as Map<String, dynamic>;
      final id = pathParams['id'] as int;
      print('id: $id');
      return InstrumentDetailsPage(id: id);
    },
  );

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Instruments'),
            border: Border(),
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
