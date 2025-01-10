import 'category.dart';
import 'category_icon.dart';
import 'emoji_internal_data.dart';

class Group {
  final Category category;
  final CategoryIcon icon;
  final String title;
  final List<String> names;
  final List<List<EmojiInternalData>> pages = [];

  Group(this.category, this.icon, this.title, this.names);
}