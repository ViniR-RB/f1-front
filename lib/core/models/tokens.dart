// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TokenModel {
  final String refresh;
  final String access;
  TokenModel({
    required this.refresh,
    required this.access,
  });

  TokenModel copyWith({
    String? refresh,
    String? access,
  }) {
    return TokenModel(
      refresh: refresh ?? this.refresh,
      access: access ?? this.access,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'refresh': refresh,
      'access': access,
    };
  }

  factory TokenModel.fromMap(dynamic map) {
    return TokenModel(
      refresh: map['refresh'] as String,
      access: map['access'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenModel.fromJson(String source) =>
      TokenModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TokenModel(refresh: $refresh, access: $access)';

  @override
  bool operator ==(covariant TokenModel other) {
    if (identical(this, other)) return true;

    return other.refresh == refresh && other.access == access;
  }

  @override
  int get hashCode => refresh.hashCode ^ access.hashCode;
}
