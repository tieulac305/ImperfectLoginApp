import 'package:equatable/equatable.dart';

/// các state emit từ credentials bloc
abstract class CredentialsState extends Equatable{
  /// các state tạo ra khi form được tạo
  /// bloc này phải chờ và xử lí lỗi nữa
  const CredentialsState();

  @override
  List<Object?> get props => [];
}

/// khởi tạo
class CredentialsInitial extends CredentialsState{
  const CredentialsInitial();
}

/// bấm đăng nhập rồi đang chờ
class CredentialsLoginLoading extends CredentialsState{
  const CredentialsLoginLoading();
}

/// bấm đăng kí rồi đang chờ
class CredentialsRegisterLoading extends CredentialsState{
  const CredentialsRegisterLoading();
}

/// tài khoản không đúng
class CredentialsLoginFailure extends CredentialsState{
  const CredentialsLoginFailure();
}

/// form đăng kí không hợp lệ
/// ở đây kiểm tra email đúng và password xịn
class CredentialsRegisterFailure extends CredentialsState{
  const CredentialsRegisterFailure();
}