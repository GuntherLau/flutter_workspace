class EmojiData {
  final String? id;
  final String? name;
  final String? unified;
  final String char;
  final String? category;
  final int skin;

  const EmojiData({
    required this.id,
    required this.name,
    required this.unified,
    required this.char,
    required this.category,
    required this.skin,
  });

  EmojiData copyWith({
    String? id,
    String? name,
    String? unified,
    String? char,
    String? category,
    int? skin,
  }) {
    return EmojiData(
      id: id?? this.id,
      name: name?? this.name,
      unified: unified?? this.unified,
      char: char?? this.char,
      category: category?? this.category,
      skin: skin?? this.skin,
    );
  }

  @override
  String toString() {
    return 'EmojiData{id: $id, name: $name, unified: $unified, char: $char, category: $category, skin: $skin}';
  }
}