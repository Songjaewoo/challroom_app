import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../core/error/api_exception.dart';
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
    // 유저 조회·수정은 서버에서 `/auth` 라우터가 맡고 있다 — 별도 `/users` 라우터는 없다.
    final res = await _dio.get<Map<String, dynamic>>('/auth/me');
    return User.fromJson(res.data!);
  }

  @override
  Future<User> updateProfile(ProfileUpdateReq req) async {
    final res = await _dio.patch<Map<String, dynamic>>('/auth/me', data: req.toJson());
    return User.fromJson(res.data!);
  }

  @override
  Future<String> uploadAvatar(XFile image) async {
    // 서버에 아직 업로드 엔드포인트가 없다 — 사진 없이 닉네임만으로 프로필 설정은
    // 계속 되니, 여기서만 막고 화면에 이유를 그대로 보여준다.
    throw const ApiException(
      statusCode: 501,
      code: 'AVATAR_UPLOAD_NOT_SUPPORTED',
      message: '아직 프로필 사진 업로드는 지원하지 않아요. 닉네임만으로 계속할 수 있어요.',
    );
  }
}
