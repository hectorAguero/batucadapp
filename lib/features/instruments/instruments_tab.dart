import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:samba_public_app/extensions/media_query_context_extension.dart';
import 'package:samba_public_app/router/router.dart';
import 'package:sliver_tools/sliver_tools.dart';

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
    final isSmallScreen = context.querySize.isSmallScreen;
    return CustomScrollView(
      slivers: [
        const CupertinoSliverNavigationBar(
          largeTitle: Text('Instruments'),
          backgroundColor: Colors.transparent,
          border: Border(),
        ),
        SliverLayoutBuilder(
          builder: (context, constraints) => SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 0 : constraints.crossAxisExtent * 0.1,
            ),
            sliver: SliverList.separated(
              itemBuilder: (context, index) => const InstrumentListItem(),
              separatorBuilder: (context, index) => const Divider(
                height: 1,
                thickness: 1,
                indent: 16,
                endIndent: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class InstrumentListItem extends StatelessWidget {
  const InstrumentListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      splashColor: Colors.transparent,
      onTap: () {},
      leading: const Card(
        child: SizedBox(
          height: 80,
          width: 80,
          child: Icon(Icons.music_note),
        ),
      ),
      title: const Text('Instrument'),
      subtitle: const Text('Description'),
    );
  }
}
