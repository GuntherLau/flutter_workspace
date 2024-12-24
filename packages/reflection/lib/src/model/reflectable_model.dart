import 'package:reflectable/reflectable.dart';

class ReflectorModel extends Reflectable {
  const ReflectorModel()
      : super(
    invokingCapability,
    typingCapability,
    metadataCapability,
    declarationsCapability,
    typeCapability,           // 允许反射类型
    reflectedTypeCapability,  // 允许访问 `reflectedType`
    declarationsCapability,   // 允许访问类的声明信息
  );
}