import 'package:flutter/material.dart';
import 'package:samba_public_app/widgets/app_network_image.dart';

typedef ImageUrl = String;

class InstrumentListTile extends StatefulWidget {
  const InstrumentListTile({
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.imageUrl,
    super.key,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final ImageUrl imageUrl;

  @override
  State<InstrumentListTile> createState() => _InstrumentListTileState();
}

class _InstrumentListTileState extends State<InstrumentListTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ExpansionTile(
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: AppImageNetwork(
            widget.imageUrl,
            height: 48,
            width: 48,
            fit: BoxFit.cover,
          ),
        ),
        trailing: isExpanded
            ? const Icon(Icons.music_note)
            : const Icon(Icons.music_note_outlined),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(widget.title),
        subtitle: Text(widget.subtitle),
        onExpansionChanged: (expanded) {
          setState(() {
            isExpanded = expanded;
          });
        },
        children: [
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'This is a longer description of the instrument. It could be a few paragraphs long.',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 400,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      widget.onTap();
                    },
                    child: const Text('Learn More'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
