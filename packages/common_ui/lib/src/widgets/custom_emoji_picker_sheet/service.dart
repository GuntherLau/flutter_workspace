


import 'dart:convert';

import 'package:flutter/services.dart';

import 'model/emoji_data.dart';
import 'model/emoji_internal_data.dart';

class CustomEmojiPickerService {

  static final CustomEmojiPickerService _instance = CustomEmojiPickerService._internal();
  CustomEmojiPickerService._internal();
  static CustomEmojiPickerService get instance => _instance;

  final List<EmojiInternalData> _emojis = [];

  Future<List<EmojiInternalData>> loadData() async {
    if(_emojis.isNotEmpty) {
      return _emojis;
    }
    const path = 'packages/common_ui/assets/json/emoji.json';
    String data = await rootBundle.loadString(path);
    final emojiList = json.decode(data);
    for (var emojiJson in emojiList) {
      EmojiInternalData data = EmojiInternalData.fromJson(emojiJson);
      _emojis.add(data);
    }
    return _emojis;
  }

  List<EmojiInternalData> searchEmoji(String text) {
    List<EmojiInternalData> newEmojis = _emojis.where((element) {
      return element.shortName!.toLowerCase().contains(text);
    }).toList();
    return newEmojis;
  }

  EmojiData? findById(String id, { int skin = 0 }) {
    for (var emoji in _emojis) {
      if(emoji.id == id) {
        EmojiData emojiData = EmojiData(
          id: emoji.id,
          name: emoji.name,
          unified: emoji.unifiedForSkin(skin),
          char: emoji.charForSkin(skin),
          category: emoji.category,
          skin: skin,
        );
        return emojiData;
      }
    }
    return null;
  }

}