import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../models/users.dart';

/// 인터페이스인 이유는 하나 — 백엔드가 없을 때 [LocalUserRepository] 로 갈아끼워
/// 로그인→프로필 설정→홈 흐름을 기기에서 미리 볼 수 있게 하기 위해서다.
/// (`core/dev/local_backend.dart`, `providers.dart` 참고)
abstract interface class UserRepository {
  Future<User> fetchMe();

  Future<User> updateProfile(ProfileUpdateReq req);

  /// 프로필 사진을 올리고 서버에 저장된 URL을 받는다. [updateProfile] 에 그대로 넘긴다.
  Future<String> uploadAvatar(XFile image);
}

class DioUserRepository implements UserRepository {
  DioUserRepository(this._dio);

  final Dio _dio;

  @override
  Future<User> fetchMe() async {
    final res = await _dio.get<Map<String, dynamic>>('/users/me');
    return User.fromJson(res.data!);
  }

  @override
  Future<User> updateProfile(ProfileUpdateReq req) async {
    final res = await _dio.patch<Map<String, dynamic>>('/users/me', data: req.toJson());
    return User.fromJson(res.data!);
  }

  @override
  Future<String> uploadAvatar(XFile image) async {
    final form = FormData.fromMap({'file': await MultipartFile.fromFile(image.path, filename: image.name)});
    final res = await _dio.post<Map<String, dynamic>>('/users/me/avatar', data: form);
    return res.data!['url'] as String;
  }
}
