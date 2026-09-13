import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../controllers/auth_controller.dart';
import '../../models/faqs.dart';
import '../../models/notices.dart';
import '../../models/pick_videos.dart';
import '../../models/rooms.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/challenge/challenge_detail_screen.dart';
import '../../screens/faq/faq_detail_screen.dart';
import '../../screens/faq/faq_list_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/notice/notice_detail_screen.dart';
import '../../screens/notice/notice_list_screen.dart';
import '../../screens/notifications/notifications_screen.dart';
import '../../screens/profile/profile_edit_screen.dart';
import '../../screens/profile/profile_setup_screen.dart';
import '../../screens/report/report_screen.dart';
import '../../screens/room/create_room_screen.dart';
import '../../screens/room/join_room_screen.dart';
import '../../screens/room/room_detail_screen.dart';
import '../../screens/room/room_edit_screen.dart';
import '../../screens/room/room_members_screen.dart';
import '../../screens/splash/splash_screen.dart';
import '../../screens/video/asset_video_player_screen.dart';

part 'app_router.g.dart';

/// 경로 문자열은 전부 여기 모은다. 화면에서 `'/rooms/3'` 처럼 직접 쓰지 않는다.
abstract final class RoutePath {
  static const splash = '/splash';
  static const login = '/login';
  static const profileSetup = '/profile-setup';
  static const profileEdit = '/profile-edit';
  static const home = '/';
  static const roomDetail = '/rooms/:id';
  static const roomMembers = '/rooms/:id/members';
  static const roomEdit = '/rooms/:id/edit';
  static const challengeDetail = '/challenges/:id';

  /// `extra` 로 [PickVideo]? 를 넘긴다 — PICK 영상의 "+" 로 들어오면 그 영상이 이미
  /// 채워진 채로 시작하고, 바텀 네비게이션 "만들기" 로 들어오면 `null`(직접 채운다).
  static const createRoom = '/create-room';

  /// 초대 코드를 입력해 방에 들어간다 — "내 방" 탭의 "코드로 참여" 로 들어온다.
  static const joinRoom = '/join-room';

  static const notifications = '/notifications';

  /// `extra` 로 [ReportScreenArgs] 를 넘긴다 — 챌린지 원본 영상이든 제출 영상이든 이 화면
  /// 하나를 같이 쓴다.
  static const report = '/report';

  static const noticeList = '/notices';
  static const noticeDetail = '/notices/:id';
  static const faqList = '/faqs';
  static const faqDetail = '/faqs/:id';

  static String roomDetailOf(int id) => '/rooms/$id';
  static String roomMembersOf(int id) => '/rooms/$id/members';
  static String roomEditOf(int id) => '/rooms/$id/edit';
  static String challengeDetailOf(int id) => '/challenges/$id';
  static String noticeDetailOf(int id) => '/notices/$id';
  static String faqDetailOf(int id) => '/faqs/$id';

  /// 우리가 파일을 갖고 있는(번들된) 영상만 이 경로로 재생한다 — 외부 링크는
  /// 인앱 브라우저로 따로 연다(`openVideoInAppBrowser`, 라우팅을 안 탄다).
  /// `extra` 로 [AssetVideoArgs] 를 넘긴다 — PICK 영상·챌린지 원본 영상 등 번들 파일을
  /// 재생하는 곳이면 어디서나 같은 방식으로 쓴다.
  static const assetVideoPlayer = '/asset-video-player';
}

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  // 로그인 상태가 바뀔 때마다 redirect 를 다시 태운다.
  // 라우터 자체를 다시 만들면 내비게이션 스택이 날아가므로 watch 로 재생성하지 않는다.
  final refresh = ValueNotifier(0);
  ref.listen(authProvider, (_, _) => refresh.value++);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: RoutePath.splash,
    refreshListenable: refresh,
    // 인증 분기는 여기 한 곳에서만 한다. 화면마다 로그인 체크를 넣지 않는다.
    redirect: (context, state) {
      final auth = ref.read(authProvider);
      final location = state.matchedLocation;

      // 저장된 토큰을 최초로 확인하는 중(아직 값이 하나도 없음)에만 스플래시에 머문다.
      // `auth.hasValue` 를 안 보면 `refresh()`(프로필 편집 저장 등)로 재조회할 때마다
      // 잠깐 isLoading 이 되는데, 그때마다 지금 화면이 어디든 스플래시로 튕겨나갔다가
      // 로딩이 끝나도 `atEntry` 가 아니라 못 돌아오는 버그가 있었다.
      if (auth.isLoading && !auth.hasValue) {
        return location == RoutePath.splash ? null : RoutePath.splash;
      }

      // Riverpod 3 에서 nullable 접근자는 `value` 다 (`valueOrNull` 은 없어졌다).
      final user = auth.value;
      if (user == null) return location == RoutePath.login ? null : RoutePath.login;

      // 닉네임이 없는 신규 유저는 프로필부터 채운다.
      final needsProfile = user.nickname == null || user.nickname!.isEmpty;
      if (needsProfile) return location == RoutePath.profileSetup ? null : RoutePath.profileSetup;

      final atEntry = location == RoutePath.login || location == RoutePath.splash || location == RoutePath.profileSetup;
      return atEntry ? RoutePath.home : null;
    },
    routes: [
      GoRoute(path: RoutePath.splash, builder: (_, _) => const SplashScreen()),
      GoRoute(path: RoutePath.login, builder: (_, _) => const LoginScreen()),
      GoRoute(path: RoutePath.profileSetup, builder: (_, _) => const ProfileSetupScreen()),
      GoRoute(path: RoutePath.profileEdit, builder: (_, _) => const ProfileEditScreen()),
      GoRoute(path: RoutePath.home, builder: (_, _) => const HomeScreen()),
      GoRoute(
        path: RoutePath.roomDetail,
        builder: (_, state) {
          final id = int.parse(state.pathParameters['id']!);
          return RoomDetailScreen(roomId: id);
        },
      ),
      GoRoute(
        path: RoutePath.roomMembers,
        builder: (_, state) {
          final id = int.parse(state.pathParameters['id']!);
          return RoomMembersScreen(roomId: id);
        },
      ),
      GoRoute(
        path: RoutePath.roomEdit,
        builder: (_, state) {
          final id = int.parse(state.pathParameters['id']!);
          final room = state.extra! as RoomDetail;
          return RoomEditScreen(roomId: id, initial: room);
        },
      ),
      GoRoute(path: RoutePath.joinRoom, builder: (_, _) => const JoinRoomScreen()),
      GoRoute(path: RoutePath.notifications, builder: (_, _) => const NotificationsScreen()),
      GoRoute(
        path: RoutePath.report,
        builder: (_, state) {
          final args = state.extra! as ReportScreenArgs;
          return ReportScreen(target: args.target, targetLabel: args.targetLabel);
        },
      ),
      GoRoute(path: RoutePath.noticeList, builder: (_, _) => const NoticeListScreen()),
      GoRoute(
        path: RoutePath.noticeDetail,
        builder: (_, state) => NoticeDetailScreen(notice: state.extra! as Notice),
      ),
      GoRoute(path: RoutePath.faqList, builder: (_, _) => const FaqListScreen()),
      GoRoute(path: RoutePath.faqDetail, builder: (_, state) => FaqDetailScreen(faq: state.extra! as Faq)),
      GoRoute(
        path: RoutePath.challengeDetail,
        builder: (_, state) {
          final id = int.parse(state.pathParameters['id']!);
          return ChallengeDetailScreen(challengeId: id);
        },
      ),
      GoRoute(
        path: RoutePath.createRoom,
        builder: (_, state) => CreateRoomScreen(initialPickVideo: state.extra as PickVideo?),
      ),
      GoRoute(
        path: RoutePath.assetVideoPlayer,
        builder: (_, state) {
          final args = state.extra! as AssetVideoArgs;
          return AssetVideoPlayerScreen(title: args.title, assetPath: args.assetPath);
        },
      ),
    ],
  );
}
