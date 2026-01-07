import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Shared Prefs provider
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    "Shared Prefs lai hamile main.dart ma initialize garinxa, so timi dhukka basa ma dinxu hai",
  );
});

//Provider
final userSessionServiceProvider = Provider<UserSessionService>((ref) {
  return UserSessionService(prefs: ref.read(sharedPreferencesProvider));
});

class UserSessionService {
  final SharedPreferences _prefs;

  UserSessionService({required SharedPreferences prefs}) : _prefs = prefs;
  // Keys for Storing data
  static const String _keysIsLoggedIn = 'is_logged_in';
  static const String _keysUserId = 'user_id';
  static const String _keysUserEmail = 'user_email';
  static const String _keysUsername = 'username';
  static const String _keysUserFullName = 'user_full_name';
  static const String _keysUserPhoneNumber = 'user_phone_number';
  static const String _keysUserBatchId = 'user_batch_id';
  static const String _keysUserProfileImage = 'user_profile_image';

  //Store user session data
  Future<void> storeUserSession({
    required String userId,
    required String userEmail,
    required String username,
    required String fullName,
    required String? phoneNumber,
    required String? batchId,
    String? profileImage,
  }) async {
    await _prefs.setBool(_keysIsLoggedIn, true);
    await _prefs.setString(_keysUserId, userId);
    await _prefs.setString(_keysUserEmail, userEmail);
    await _prefs.setString(_keysUsername, username);
    await _prefs.setString(_keysUserFullName, fullName);
    if (phoneNumber != null) {
      await _prefs.setString(_keysUserPhoneNumber, phoneNumber);
    }
    if (batchId != null) {
      await _prefs.setString(_keysUserBatchId, batchId);
    }
    if (profileImage != null) {
      await _prefs.setString(_keysUserProfileImage, profileImage);
    }
  }

  //Clear user session data
  Future<void> clearUserService() async {
    await _prefs.remove(_keysUserId);
    await _prefs.remove(_keysUserBatchId);
    await _prefs.remove(_keysUserEmail);
    await _prefs.remove(_keysUserFullName);
    await _prefs.remove(_keysUserPhoneNumber);
    await _prefs.remove(_keysUsername);
    await _prefs.remove(_keysUserProfileImage);
    await _prefs.remove(_keysIsLoggedIn);
  }

  bool isLoggedIn() {
    return _prefs.getBool(_keysIsLoggedIn) ?? false;
  }

  String? getUserId() {
    return _prefs.getString(_keysUserId);
  }

  String? getUserEmail() {
    return _prefs.getString(_keysUserEmail);
  }

  String? getUsername() {
    return _prefs.getString(_keysUsername);
  }

  String? getFullName() {
    return _prefs.getString(_keysUserFullName);
  }

  String? getPhoneNumber() {
    return _prefs.getString(_keysUserPhoneNumber);
  }

  String? getBatchId() {
    return _prefs.getString(_keysUserBatchId);
  }

  String? getProfileImage() {
    return _prefs.getString(_keysUserProfileImage);
  }
}
