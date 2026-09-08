---
name: flutter-arch
description: Flutter 앱의 레이어 아키텍처 규약. Screen → Controller → Repository → Model 계층 작성 규칙과 Riverpod 3 DI, 에러 처리, 라우팅, 테스트 패턴을 정의한다. 새 화면이나 도메인을 추가할 때, 기존 계층 코드를 수정할 때, 레이어 경계 위반을 점검할 때 사용한다.
---

# Flutter 레이어 아키텍처 규약

이 앱의 계층 구조와 작성 규칙이다. 새 코드는 여기 정의된 패턴을 그대로 따른다.

상태관리는 **Riverpod (코드젠)**, 구조는 **Layer-first** 다.

> 예제에 나오는 `Notice` 모델과 URL 경로는 문법을 보여주기 위한 가상의 것이다.
> **서버 API 계약(응답 형태·에러 코드·인증 흐름)은 이 문서가 다루지 않는다.**
> 이 문서는 "어느 계층에 무엇을 쓰는가"만 정한다.

## 계층 4개

```
┌───────────────────────────────────────────────────────┐
│  screens/ ──watch──> controllers/ ──> repositories/   │
│  widgets/                  │              │           │
│                            └─ AsyncValue  └─ Dio      │
│         ↑ providers.dart 에서 수동 조립               │
└───────────────────────────────────────────────────────┘
        공유: models/ · core/ · shared/
```

각 계층의 책임은 하나씩이다.

| 계층 | 하는 일 | 하지 않는 일 |
|------|---------|-------------|
| `screens/` | 상태를 읽어 위젯 트리를 만든다 | 계산, 분기, 통신 |
| `controllers/` | 비즈니스 로직, 상태 보유 | UI 접근, 직접 HTTP |
| `repositories/` | 통신, 모델 변환 | 상태 판단, 예외 의미 부여 |
| `models/` | 데이터 표현 | 로직 |

**Controller 는 값 하나를 반환하고 끝나는 게 아니라 살아있는 상태를 들고 있다.**
그래서 화면이 받는 타입은 `AsyncValue<T>` — 로딩·에러·데이터 세 상태를 한 타입이 담는다.
`isLoading` `errorMessage` 같은 플래그를 직접 만들지 않는다.

---

## 패키지 구조

```
lib/
├── main.dart                     앱 엔트리 — ProviderScope, MaterialApp.router
│
├── core/
│   ├── network/
│   │   ├── dio_client.dart        Dio 인스턴스 생성
│   │   └── api_interceptor.dart   헤더 주입 · 예외 변환
│   ├── error/
│   │   ├── api_exception.dart     ApiException
│   │   └── error_message.dart     예외 → 사용자 문구 변환
│   ├── router/
│   │   └── app_router.dart        go_router 설정 + 라우트 상수
│   ├── storage/
│   │   └── token_storage.dart     flutter_secure_storage 래퍼
│   └── theme/
│       └── app_theme.dart
│
├── models/                       freezed 모델 — {복수형}.dart
├── repositories/                 {도메인}_repository.dart
├── controllers/                  {도메인}_controller.dart
├── screens/                      {도메인}/{동작}_screen.dart
├── shared/                       공용 위젯 · 확장 · 포매터
│
└── providers.dart                DI 조립 지점

test/
├── controllers/                  Controller 단위 테스트
└── widgets/                      위젯 테스트
```

### 새 파일을 어디에 두는가

| 만들 것 | 위치 | 파일명 |
|---------|------|--------|
| 모델 | `lib/models/` | `{복수형}.dart` |
| Enum | `lib/models/enums.dart` | — (한 파일에 모은다) |
| Repository | `lib/repositories/` | `{도메인}_repository.dart` |
| Controller | `lib/controllers/` | `{도메인}_controller.dart` |
| 화면 | `lib/screens/{도메인}/` | `{동작}_screen.dart` |
| 재사용 위젯 | `lib/shared/widgets/` | `{개념}_{종류}.dart` |
| 화면 전용 위젯 | `lib/screens/{도메인}/widgets/` | `{개념}_{종류}.dart` |
| Repository provider | `lib/providers.dart` | — |
| 테스트 | `test/controllers/` | `{도메인}_controller_test.dart` |

파일명은 `snake_case`, 클래스명은 `PascalCase`. 모델 파일만 복수형(`notices.dart` 안에
`Notice`, `NoticeCreateReq`)이고 나머지는 단수형이다.

---

## 절대 규칙

이 6가지는 예외 없이 지킨다. 위반은 리뷰에서 반려 대상이다.

| # | 규칙 | 이유 |
|---|------|------|
| 1 | Screen 은 Repository 를 import 하지 않는다 | 계층 건너뛰기 금지 |
| 2 | Repository 는 `Dio` / `Response` / `DioException` 을 밖으로 내보내지 않는다 | HTTP 세부사항이 UI까지 새지 않게 |
| 3 | Controller 는 `BuildContext` 를 받지 않는다 | UI 의존 금지 — 테스트 가능성 |
| 4 | `ref.watch` 는 `build()` 안에서만, `ref.read` 는 콜백 안에서만 | 리빌드 루프·stale 값의 90%가 여기서 난다 |
| 5 | 모델은 전부 freezed immutable — 필드 직접 수정 금지, `copyWith` | Riverpod 이 `==` 로 리빌드를 거른다 |
| 6 | `setState` / `StatefulWidget` 은 순수 로컬 UI 상태에만 쓴다 | 서버에서 온 데이터는 전부 Controller 소유 |

6번의 "순수 로컬 UI 상태"란 애니메이션 컨트롤러, `TextEditingController`, 포커스, 펼침/접힘 정도다.
서버 응답에서 나온 값이 하나라도 섞이면 Controller 로 올린다.

---

## 버전 주의 — Riverpod 3 / freezed 3

이 프로젝트에 실제로 잡힌 버전이다 (Flutter 3.41.7 / Dart 3.11.5 기준):

| 패키지 | 버전 |
|---|---|
| flutter_riverpod / riverpod | 3.3.1 / 3.2.1 |
| riverpod_annotation / riverpod_generator | 4.0.2 / 4.0.3 |
| freezed / freezed_annotation | 3.2.5 / 3.1.0 |
| json_serializable / json_annotation | 6.13.0 / 4.11.0 |
| dio / go_router | 5.11.1 / 17.5.0 |

`abstract class X with _$X` 는 freezed 3부터의 문법이라 아래 예제는 그대로 유효하다.
웹 검색이나 오래된 블로그에서 본 2.x 예제와는 문법이 다르다. 아래를 그대로 쓴다.

| 항목 | 옛 문법 (쓰지 말 것) | 지금 문법 |
|---|---|---|
| provider 함수 인자 | `Future<int> foo(FooRef ref)` | `Future<int> foo(Ref ref)` — `Ref` 서브클래스 전부 삭제됨 |
| freezed 클래스 | `class Notice with _$Notice` | `abstract class Notice with _$Notice` |
| 파라미터 있는 Notifier | `FamilyNotifier` | `build(int id)` 로 인자만 받는다 |
| 테스트 컨테이너 | `ProviderContainer()` + 수동 dispose | `ProviderContainer.test()` — 자동 dispose |

### 함정 1 — 프로바이더가 자동 재시도한다

Riverpod 3부터 **초기화에 실패한 프로바이더는 지수 백오프로 무한 재시도한다** (200ms → 6.4s).
없는 리소스를 조회한 것처럼 영구히 실패하는 경우에도 계속 두드린다. `main.dart` 에서 반드시 막는다.

```dart
void main() {
  runApp(
    ProviderScope(
      retry: (retryCount, error) {
        // 4xx 는 다시 보내도 결과가 같다 — 재시도하지 않는다.
        if (error is ApiException && error.statusCode < 500) return null;
        if (retryCount >= 3) return null;
        return Duration(milliseconds: 200 * (1 << retryCount));
      },
      child: const App(),
    ),
  );
}
```

### 함정 2 — 예외가 `ProviderException` 으로 감싸진다

`ref.read(p.future)` 를 `try/catch` 로 잡으면 원래 예외가 아니라 `ProviderException` 이 온다.

```dart
// ✗ 안 잡힌다
try { await ref.read(noticeListProvider.future); }
on ApiException { ... }

// ✓
try { await ref.read(noticeListProvider.future); }
on ProviderException catch (e) {
  if (e.exception is ApiException) { ... }
}

// ✓ AsyncValue 로 읽으면 원래 예외 그대로 — 이쪽을 기본으로 쓴다
final notices = ref.watch(noticeListProvider);
if (notices.error is ApiException) { ... }
```

**규칙: UI 에서는 `try/catch` 대신 `AsyncValue` 를 본다.**

---

## 모델 규약 — `lib/models/{복수형}.dart`

### 네이밍

| 용도 | 패턴 | 예시 |
|------|------|------|
| 요청 바디 | `{도메인}{동작}Req` | `NoticeCreateReq` |
| 응답·엔티티 | 단순 명사형 | `Notice`, `User` |
| 중첩 구조 | `{개념}Info` | `AuthorInfo` |
| 화면 | `{도메인}{동작}Screen` | `NoticeListScreen` |
| Controller | `{도메인}{동작}` | `NoticeList`, `NoticeDetail` |

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notices.freezed.dart';
part 'notices.g.dart';

@freezed
abstract class Notice with _$Notice {
  const factory Notice({
    required int id,
    required String title,
    String? content,
    @Default(<String>[]) List<String> tags,
    required DateTime createdAt,
  }) = _Notice;

  factory Notice.fromJson(Map<String, dynamic> json) => _$NoticeFromJson(json);
}

@freezed
abstract class NoticeCreateReq with _$NoticeCreateReq {
  const factory NoticeCreateReq({
    required String title,
    String? content,
  }) = _NoticeCreateReq;

  factory NoticeCreateReq.fromJson(Map<String, dynamic> json) =>
      _$NoticeCreateReqFromJson(json);
}
```

규칙:

- `abstract class` + `with _$X` 고정 (freezed 4)
- `part` 선언 두 줄 — `.freezed.dart` 와 `.g.dart` 둘 다 필요하다
- nullable 이 아닌 필드는 `required`, 기본값이 있으면 `@Default(...)`
- 리스트/맵 필드는 `@Default(<T>[])` 로 non-null 을 유지한다 — `null` 체크가 UI 로 번지지 않게
- 서버 키 이름이 Dart 필드명과 다를 때만 `@JsonKey(name: ...)` 를 붙인다. 전체 규칙이 필요하면
  클래스마다 붙이지 말고 `build.yaml` 의 `field_rename` 으로 한 번에 정한다

### 페이지네이션은 제네릭 하나로 끝낸다

도메인마다 `NoticePage` `UserPage` 를 만들지 않는다.

```dart
@Freezed(genericArgumentFactories: true)
abstract class Paged<T> with _$Paged<T> {
  const factory Paged({
    required List<T> items,
    required int total,
    required int totalPages,
  }) = _Paged<T>;

  factory Paged.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$PagedFromJson(json, fromJsonT);
}
```

```dart
Paged<Notice>.fromJson(json, (e) => Notice.fromJson(e! as Map<String, dynamic>));
```

### Enum

```dart
// lib/models/enums.dart
@JsonEnum(alwaysCreate: true)
enum NoticeType {
  @JsonValue('normal') normal,
  @JsonValue('urgent') urgent;

  String get label => switch (this) {
    NoticeType.normal => '일반',
    NoticeType.urgent => '긴급',
  };
}
```

`enums.dart` 도 `part 'enums.g.dart';` 를 선언한다 — `@JsonEnum(alwaysCreate: true)` 가
`_$NoticeTypeEnumMap` 을 여기에 생성한다.

한글 라벨은 Enum 안에 `label` 게터로 응집시킨다. 화면마다 `switch` 를 다시 쓰지 않는다.
서버가 앱이 모르는 값을 보낼 수 있으면 fallback 을 준다 — 값 하나 추가됐다고 앱이 죽지 않게.
`unknownEnumValue` 는 `@JsonEnum` 이 아니라 그 Enum 을 쓰는 **모델 필드의 `@JsonKey`** 에 붙는다.

```dart
@JsonKey(unknownEnumValue: NoticeType.normal) required NoticeType type,
```

---

## 1. Repository — `lib/repositories/{도메인}_repository.dart`

```dart
import 'package:dio/dio.dart';
import '../models/notices.dart';

class NoticeRepository {
  NoticeRepository(this._dio);

  final Dio _dio;

  Future<List<Notice>> fetchNotices() async {
    final res = await _dio.get<List<dynamic>>('/notices');
    return (res.data ?? const [])
        .map((e) => Notice.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Notice> fetchNotice(int id) async {
    final res = await _dio.get<Map<String, dynamic>>('/notices/$id');
    return Notice.fromJson(res.data!);
  }

  Future<Notice> createNotice(NoticeCreateReq req) async {
    final res = await _dio.post<Map<String, dynamic>>('/notices', data: req.toJson());
    return Notice.fromJson(res.data!);
  }
}
```

규칙:

- 생성자로 `Dio` 만 받는다. `Ref` 를 받지 않는다 — Repository 는 Riverpod 을 모른다
- 반환 타입은 모델 또는 `void`. `Response` 를 그대로 넘기지 않는다
- 상태 판단(없음·권한·중복)을 하지 않는다. 예외는 인터셉터가 `ApiException` 으로 바꿔 던지고,
  그 의미를 해석하는 것은 Controller 의 책임이다
- `try/catch` 를 쓰지 않는다
- **응답에서 알맹이를 꺼내는 공통 처리는 인터셉터 한 곳에서 한다.** Repository 마다
  `res.data['data']` 같은 코드를 반복하지 않는다

---

## 2. Controller — `lib/controllers/{도메인}_controller.dart`

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/notices.dart';
import '../providers.dart';

part 'notice_controller.g.dart';

@riverpod
class NoticeList extends _$NoticeList {
  @override
  Future<List<Notice>> build() {
    return ref.watch(noticeRepositoryProvider).fetchNotices();
  }

  Future<void> create(NoticeCreateReq req) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(noticeRepositoryProvider).createNotice(req);
      return ref.read(noticeRepositoryProvider).fetchNotices();
    });
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}

/// 파라미터가 필요하면 build() 의 인자로 받는다 — 사용처는 noticeDetailProvider(id).
@riverpod
class NoticeDetail extends _$NoticeDetail {
  @override
  Future<Notice> build(int id) {
    return ref.watch(noticeRepositoryProvider).fetchNotice(id);
  }
}
```

규칙:

- `build()` 는 **초기 상태를 만드는 곳**이다. 여기서 다른 프로바이더를 건드리거나 부수효과를 내지 않는다
- 상태를 바꾸는 메서드는 `AsyncValue.guard` 로 감싼다 — 예외가 `AsyncError` 로 들어가고,
  `try/catch` 를 쓸 일이 없어진다
- 쓰기 후 목록 갱신은 `invalidateSelf()` 또는 위처럼 재조회. 로컬에서 리스트를 손으로 수정하지 않는다
- `build()` 안에서는 `ref.watch`, 메서드 안에서는 `ref.read` (절대 규칙 4)
- 에러 코드로 분기해야 하면 **여기서** 한다. 화면에서 코드를 보지 않는다
- Controller 가 다른 Controller 를 `ref.watch` 하는 것은 허용된다. 순환만 만들지 않는다

### 낙관적 갱신이 필요할 때

응답을 기다리지 않고 UI 를 먼저 바꿔야 하면, 실패 시 되돌릴 이전 상태를 반드시 잡아둔다.

```dart
Future<void> toggle(int id) async {
  final previous = state;
  state = AsyncData([...]);          // 먼저 반영
  try {
    await ref.read(noticeRepositoryProvider).toggle(id);
  } catch (_) {
    state = previous;                 // 실패하면 롤백
    rethrow;
  }
}
```

---

## 3. Screen — `lib/screens/{도메인}/{동작}_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/notice_controller.dart';
import '../../core/error/error_message.dart';
import '../../shared/widgets/error_view.dart';

class NoticeListScreen extends ConsumerWidget {
  const NoticeListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notices = ref.watch(noticeListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('공지사항')),
      body: notices.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorView(
          message: e.toUserMessage(),
          onRetry: () => ref.invalidate(noticeListProvider),
        ),
        data: (list) => list.isEmpty
            ? const EmptyView(message: '등록된 공지가 없어요.')
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, i) => NoticeCard(notice: list[i]),
              ),
      ),
    );
  }
}
```

규칙:

- 기본은 `ConsumerWidget`. 로컬 상태가 필요하면 `ConsumerStatefulWidget`
- **`build()` 는 `ref.watch` + 위젯 트리 반환이 전부다.** 계산·분기 로직을 넣지 않는다
- `loading` / `error` / `data` **세 가지를 전부 처리한다.** 로딩만 처리하고 에러를 빠뜨리지 않는다
- 위젯 생성자에 `const` 를 붙일 수 있으면 붙인다
- `build()` 가 60줄을 넘으면 위젯으로 쪼갠다. 함수(`Widget _buildXxx()`)로 쪼개지 말고
  **클래스로** 뽑는다 — 함수는 리빌드 범위를 줄여주지 않는다

### 사용자 동작 처리

```dart
onPressed: () async {
  await ref.read(noticeListProvider.notifier).create(req);

  if (!context.mounted) return;        // await 뒤 context 사용 전 필수
  context.go(RoutePath.noticeList);
},
```

`await` 뒤에 `context` 를 쓰기 전에는 항상 `context.mounted` 를 확인한다.

### 에러를 스낵바로 띄울 때

```dart
ref.listen(noticeListProvider, (prev, next) {
  if (next case AsyncError(:final error)) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error.toUserMessage())),
    );
  }
});
```

`ref.listen` 은 부수효과 전용이다. 화면 그리기는 `ref.watch` 로만 한다.

---

## 4. DI — `lib/providers.dart`

**Repository provider 는 전부 여기 모은다.** Controller provider 는 `@riverpod` 이 클래스에
붙으므로 Controller 파일에 남는다.

```dart
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'core/network/api_interceptor.dart';
import 'core/storage/token_storage.dart';
import 'repositories/notice_repository.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
TokenStorage tokenStorage(Ref ref) => const TokenStorage();

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(BaseOptions(
    baseUrl: const String.fromEnvironment('API_BASE_URL'),
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  dio.interceptors.add(ApiInterceptor(ref.watch(tokenStorageProvider)));
  return dio;
}

@riverpod
NoticeRepository noticeRepository(Ref ref) => NoticeRepository(ref.watch(dioProvider));
```

규칙:

- 함수 인자는 `Ref` — `DioRef` 같은 서브클래스는 Riverpod 3에서 삭제됐다
- 앱 전체가 하나만 써야 하는 것(`Dio`, 저장소)은 `@Riverpod(keepAlive: true)`
- 나머지는 `@riverpod` — 아무도 안 보면 자동 정리된다
- 의존은 `ref.watch` 로 받는다. `ref.read` 로 받으면 갱신이 전파되지 않는다
- 서버 주소는 코드에 박지 않는다. `--dart-define=API_BASE_URL=...` 로 주입한다

---

## 5. 라우팅 — `lib/core/router/app_router.dart`

```dart
abstract final class RoutePath {
  static const login = '/login';
  static const noticeList = '/notices';
  static const noticeDetail = '/notices/:id';

  static String noticeDetailOf(int id) => '/notices/$id';
}

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: RoutePath.noticeList,
    redirect: (context, state) {
      final loggedIn = ref.read(authControllerProvider).value != null;
      return loggedIn ? null : RoutePath.login;
    },
    routes: [
      GoRoute(path: RoutePath.login, builder: (_, __) => const LoginScreen()),
      GoRoute(path: RoutePath.noticeList, builder: (_, __) => const NoticeListScreen()),
      GoRoute(
        path: RoutePath.noticeDetail,
        builder: (_, state) => NoticeDetailScreen(
          id: int.parse(state.pathParameters['id']!),
        ),
      ),
    ],
  );
}
```

규칙:

- 경로 문자열은 `RoutePath` 상수로만 쓴다. 화면에서 `'/notices/3'` 처럼 직접 쓰지 않는다
- 경로에 값을 끼워야 하면 `noticeDetailOf(3)` 같은 헬퍼를 상수 옆에 둔다
- 인증 분기는 `redirect` 한 곳에서. 화면마다 로그인 체크를 넣지 않는다
- 화면 전환은 `Navigator.push` 대신 `context.go` / `context.push`

---

## 6. 에러 처리 — `lib/core/error/`

```dart
// api_exception.dart
class ApiException implements Exception {
  const ApiException({
    required this.statusCode,
    required this.code,
    required this.message,
  });

  final int statusCode;
  final String code;      // 서버가 준 에러 코드
  final String message;   // 사용자 노출 문구

  @override
  String toString() => 'ApiException($statusCode $code): $message';
}

class NetworkException implements Exception {
  const NetworkException();
}
```

```dart
// error_message.dart
extension ErrorMessageX on Object {
  String toUserMessage() => switch (this) {
    ApiException(:final message) => message,
    NetworkException() => '네트워크 연결을 확인해 주세요.',
    _ => '알 수 없는 오류가 발생했습니다.',
  };
}
```

규칙:

- `DioException` → `ApiException` 변환은 **인터셉터 한 곳**에서만 한다.
  Repository / Controller / Screen 어디에도 `DioException` 이 나오면 안 된다 (절대 규칙 2)
- Dio 는 인터셉터가 무엇을 던지든 호출자에게는 `DioException` 을 던진다. 그래서
  `core/network/dio_client.dart` 의 `ApiDio` 가 `fetch()` 를 감싸 `DioException.error` 에 담긴
  `ApiException` / `NetworkException` 을 꺼내 다시 던진다. **이 두 파일이 변환의 전부다** —
  Repository 에 `try/catch` 를 추가해 풀지 않는다
- 사용자에게 보일 문구는 `toUserMessage()` 한 곳에서 만든다. 화면마다 문구를 짓지 않는다
- **서버가 주는 응답 형태와 에러 코드가 무엇이든, 그 해석은 인터셉터 안에서 끝난다.**
  서버 규약이 바뀌면 `core/network/api_interceptor.dart` 한 파일만 고친다

---

## 7. 테스트 — `test/`

Repository 를 가짜로 갈아끼우고 Controller 를 검증한다.

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';

class MockNoticeRepository extends Mock implements NoticeRepository {}

void main() {
  test('목록을 불러온다', () async {
    final repo = MockNoticeRepository();
    when(repo.fetchNotices).thenAnswer((_) async => [_notice(id: 1), _notice(id: 2)]);

    // ProviderContainer.test 는 테스트 종료 시 자동으로 dispose 된다 (Riverpod 3)
    final container = ProviderContainer.test(
      overrides: [noticeRepositoryProvider.overrideWithValue(repo)],
    );

    expect(await container.read(noticeListProvider.future), hasLength(2));
  });

  test('생성에 실패하면 AsyncError 가 된다', () async {
    final repo = MockNoticeRepository();
    when(repo.fetchNotices).thenAnswer((_) async => []);
    when(() => repo.createNotice(any())).thenThrow(
      const ApiException(statusCode: 409, code: 'DUPLICATED', message: '중복입니다.'),
    );

    final container = ProviderContainer.test(
      overrides: [noticeRepositoryProvider.overrideWithValue(repo)],
    );
    await container.read(noticeListProvider.future);

    await container.read(noticeListProvider.notifier).create(_req());

    expect(container.read(noticeListProvider), isA<AsyncError<List<Notice>>>());
  });
}
```

규칙:

- `ProviderContainer.test()` 를 쓴다 — 수동 `addTearDown(container.dispose)` 가 필요 없다
- 실제 HTTP 를 타지 않는다. 항상 Repository 를 override 한다
- 성공 경로만 보지 말고 **에러 경로를 한 건 이상** 검증한다

---

## 새 도메인 추가 순서

아래 순서대로 **한 번에 전부** 만든다. 중간에 멈추고 사용자에게 되묻지 않는다.

1. `lib/models/{복수형}.dart` — freezed 모델 (+ 필요한 Enum 은 `models/enums.dart`)
2. `dart run build_runner build` — 코드 생성
3. `lib/repositories/{도메인}_repository.dart` — Repository
4. `lib/providers.dart` — `{도메인}RepositoryProvider` 추가 (**누락 주의**)
5. `lib/controllers/{도메인}_controller.dart` — Controller
6. `lib/screens/{도메인}/{동작}_screen.dart` — 화면
7. `lib/core/router/app_router.dart` — `RoutePath` 상수 + `GoRoute` 등록
8. `test/controllers/{도메인}_controller_test.dart` — 테스트
9. build_runner 재실행 → 검증 명령 3종

`part` 선언을 쓰는 파일(모델·Controller·providers)을 만들거나 고친 뒤에는 **반드시 build_runner 를
다시 돌린다.** 생성 파일(`*.g.dart`, `*.freezed.dart`)은 직접 수정하지 않는다.

---

## 코드를 사용자에게 보여주기 전에 항상 실행

세 가지 모두 통과해야 끝난 것이다. 순서대로 실행한다.

```bash
dart run build_runner build
dart analyze
flutter test
```

`dart analyze` 에서 에러가 나면 `// ignore:` 로 덮지 말고 실제 타입을 맞춰 고친다.
생성 파일에서 나는 에러는 대부분 build_runner 를 안 돌린 탓이다 — 먼저 1번을 다시 실행한다.

### analysis_options.yaml

`strict-casts` / `strict-inference` 를 처음부터 켜 둔다. 나중에 켜면 고칠 게 산더미가 된다.

```yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  language:
    strict-casts: true
    strict-inference: true
    strict-raw-types: true
  errors:
    invalid_annotation_target: ignore   # freezed + json_serializable 조합의 오탐
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"

formatter:
  page_width: 120

linter:
  rules:
    - always_declare_return_types
    - avoid_print
    - prefer_const_constructors
    - prefer_const_declarations
    - prefer_final_locals
    - unawaited_futures
    - use_build_context_synchronously
```

`custom_lint` + `riverpod_lint` 를 붙이면 `ref.watch` 오용 같은 Riverpod 전용 실수를 잡아준다.
붙였다면 `dart run custom_lint` 도 함께 돌린다.

**지금은 붙일 수 없다.** Dart 3.11 에서 쓸 수 있는 `custom_lint` 는 `freezed_annotation ^2.2.0`
을 요구해서 freezed 3 과 공존하지 못한다. Flutter SDK 를 Dart 3.12+ 로 올린 뒤 다시 시도한다.

### 프로젝트 초기 설정

```bash
flutter pub add flutter_riverpod riverpod_annotation dio go_router \
                freezed_annotation json_annotation flutter_secure_storage
flutter pub add --dev build_runner riverpod_generator freezed json_serializable \
                      flutter_lints mocktail
```

버전은 `flutter pub add` 가 그때의 최신으로 잡는다. 잡힌 메이저 버전이 위 "버전 주의" 표와
다르면 **표가 아니라 설치된 버전의 문법을 따르고, 이 문서를 고친다.**

`main.dart` 는 `ProviderScope` 로 감싸고 `retry` 를 반드시 지정한다 (함정 1).

```dart
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      theme: AppTheme.light,
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}
```
