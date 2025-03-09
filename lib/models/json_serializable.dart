/// Firebase Firestore JSON Serializable
/// 획일화된 Firestore 데이터를 JSON으로 직렬화하기 위한 추상 클래스
/// Template Method Pattern을 활용하여 toJson() 메서드를 추상화
abstract class JsonSerializable {
  Map<String, dynamic> toJson();
}