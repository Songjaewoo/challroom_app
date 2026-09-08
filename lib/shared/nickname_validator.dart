/// 닉네임 형식 검증. 2~10자, 한글/영문/숫자만 허용한다.
abstract final class NicknameValidator {
  static final _pattern = RegExp(r'^[a-zA-Z0-9가-힣]{2,10}$');

  static const message = '2~10자, 한글/영문/숫자만 가능';

  static bool isValid(String value) => _pattern.hasMatch(value);
}
