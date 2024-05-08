import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/extensions/theme_of_context_extension.dart';

typedef ImageUrl = String;

class InstrumentListTile extends StatefulWidget {
  const InstrumentListTile({
    required this.title,
    required this.originalTitle,
    required this.subtitle,
    required this.onTap,
    required this.imageUrl,
    required this.index,
    super.key,
  });

  const InstrumentListTile.skeleton({super.key})
      : title = 'Instrument',
        originalTitle = 'Original Title',
        subtitle = 'Subtitle' * 50,
        imageUrl = '',
        onTap = null,
        index = 0;

  final String title;
  final String originalTitle;
  final String subtitle;
  final VoidCallback? onTap;
  final ImageUrl imageUrl;
  final int index;

  static const double cardMaxWidth = 480;

  @override
  State<InstrumentListTile> createState() => _InstrumentListTileState();
}

class _InstrumentListTileState extends State<InstrumentListTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 0.5],
              colors: [
                if (widget.index.isEven) ...[
                  context.colorScheme.primaryContainer,
                  context.colorScheme.secondaryContainer,
                ] else ...[
                  context.colorScheme.secondaryContainer,
                  context.colorScheme.primaryContainer,
                ],
              ],
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: widget.title,
                              style: context.headlineSmall.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            if (widget.title != widget.originalTitle)
                              TextSpan(
                                text: ' ${widget.originalTitle}',
                                style: context.titleLarge.copyWith(
                                  color: context.colorScheme.onSurfaceVariant,
                                ),
                              ),
                          ],
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.headlineSmall.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            widget.subtitle,
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Flexible(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            child: AspectRatio(
                              aspectRatio: 8 / 9,
                              child: Skeleton.replace(
                                child: ExtendedImage.network(
                                  widget.imageUrl,
                                  gaplessPlayback: true,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
