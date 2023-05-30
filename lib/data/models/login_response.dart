import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final List<String> login_response;
  final bool isLoggedIn;
  final String error_code;

  LoginResponse({
    required this.login_response,
    required this.isLoggedIn,
    required this.error_code,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
