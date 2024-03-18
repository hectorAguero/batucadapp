class Instrument {
  const Instrument({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  final int id;
  final String name;
  final String description;
  final String imageUrl;
}

const mockInstrument = Instrument(
  id: 1,
  name: 'Guitar',
  description: 'Description of the guitar.',
  imageUrl: 'https://source.unsplash.com/random/?instrument',
);
