extension EnumExtension on String {
  String get capitalize => '${this[0].toUpperCase()}${substring(1)}';
}

extension RemoveAccentsExtension on String {
  String get removeAccents {
    const accentsMap = <String, String>{
      '[àáâãäå]': 'a',
      '[èéêë]': 'e',
      '[ìíîï]': 'i',
      '[òóôõöø]': 'o',
      '[ùúûü]': 'u',
      '[ÿ]': 'y',
      '[ç]': 'c',
    };

    return accentsMap.entries.fold(toLowerCase(), (currentString, entry) {
      return currentString.replaceAll(
        RegExp(entry.key, caseSensitive: false),
        entry.value,
      );
    });
  }
}
