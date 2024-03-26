import 'package:flutter/material.dart';
import 'package:samba_public_app/common_widgets/app_fade_in_image.dart';
import 'package:samba_public_app/extensions/hardcoded_extension.dart';
import 'package:samba_public_app/extensions/media_query_context_extension.dart';

typedef ImageUrl = String;

class InstrumentListTile extends StatefulWidget {
  const InstrumentListTile({
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.imageUrl,
    this.backgroundColor,
    super.key,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final ImageUrl imageUrl;
  final Color? backgroundColor;

  static const double cardMaxWidth = 400;

  @override
  State<InstrumentListTile> createState() => _InstrumentListTileState();
}

class _InstrumentListTileState extends State<InstrumentListTile> {
  @override
  Widget build(BuildContext context) {
    final isSmallScreen = context.querySize.isSmallScreen;
    return SizedBox(
      height: isSmallScreen ? 208 : 264,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: widget.backgroundColor,
        margin: const EdgeInsets.all(8),
        child: InkWell(
          onTap: isSmallScreen ? widget.onTap : null,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        '''
This is a longer description of the instrument. It could be a few paragraphs long, Fugiat do occaecat laboris est non minim minim voluptate sunt Lorem ullamco dolor. Amet in qui minim consectetur et. Nulla irure non fugiat sunt do ex ea ut culpa.'''
                            .hardcoded,
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          child: AppFadeInImage(
                            widget.imageUrl,
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (!isSmallScreen)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: TextButton(
                              onPressed: widget.onTap,
                              child: Text('View Details'.hardcoded),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
