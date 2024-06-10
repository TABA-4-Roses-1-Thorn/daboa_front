import '../models/user_setting_model.dart';

class UserSettingController {
  final UserSettingModel _userSettingModel = UserSettingModel();

  Future<Map<String, dynamic>> getUserInfo() {
    return _userSettingModel.fetchUserInfo();
  }
}
