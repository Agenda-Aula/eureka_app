import 'package:equatable/equatable.dart';


class Auth extends Equatable {
  final String email;
  final String displayName;
  final String profileUrl;

  Auth(this.email, this.displayName, this.profileUrl);

  @override
  List<Object> get props => [email, displayName];
}
