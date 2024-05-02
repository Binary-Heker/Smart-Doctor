class ChatMessageModel {
  final String text;
  final String role;

  ChatMessageModel({
    required this.text,
    required this.role,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      text: json['parts'][0]['text'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'parts': [
        {
          'text': text,
        }
      ],
      'role': role,
    };
  }
}