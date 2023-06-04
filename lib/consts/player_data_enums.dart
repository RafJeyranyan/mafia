// abstract class CardType {
//   static const String black = "black";
//   static const String red = "red";
//   static const String don = "don";
//   static const String sheriff = "sheriff";
// }

enum CardType {
  red,
  black,
  don,
  sheriff,
  leader;

  // Stsring toJson() = name;4
  static CardType fromJson(String json) => values.byName(json);
}
