import '../../models/notices.dart';
import '../../repositories/notice_repository.dart';

/// `API_BASE_URL` 이 없을 때(지금 상태) 공지사항 화면을 미리 보기 위한 샘플 데이터.
class LocalNoticeRepository implements NoticeRepository {
  const LocalNoticeRepository();

  static final _notices = [
    Notice(
      id: 1,
      title: '챌룸 앱 정식 출시 안내',
      createdAt: DateTime(2026, 9, 1),
      isPinned: true,
      content:
          '안녕하세요, 챌룸입니다.\n\n'
          '오늘부터 챌룸이 정식으로 문을 엽니다. 좋아하는 챌린지 영상을 발견하면 방을 만들어 '
          '친구들을 초대하고, 같은 영상을 따라 찍어 서로 비교해보세요.\n\n'
          '앞으로도 더 편하게 즐기실 수 있도록 계속 다듬어 나가겠습니다. 많은 관심 부탁드립니다.',
    ),
    Notice(
      id: 2,
      title: '9월 정기 점검 안내 (9/15 02:00 ~ 04:00)',
      createdAt: DateTime(2026, 9, 10),
      content:
          '더 안정적인 서비스 제공을 위해 아래 일정으로 정기 점검을 진행합니다.\n\n'
          '• 일시: 9월 15일 02:00 ~ 04:00 (약 2시간)\n'
          '• 영향: 점검 시간 동안 로그인 및 영상 업로드가 일시 제한됩니다.\n\n'
          '이용에 불편을 드려 죄송합니다. 더 나은 서비스로 찾아뵙겠습니다.',
    ),
    Notice(
      id: 3,
      title: '커뮤니티 이용 가이드라인 업데이트',
      createdAt: DateTime(2026, 9, 5),
      content:
          '모두가 즐겁게 이용할 수 있는 챌룸을 만들기 위해 커뮤니티 가이드라인을 일부 다듬었습니다.\n\n'
          '- 타인을 비방하거나 불쾌감을 주는 콘텐츠는 제한될 수 있어요.\n'
          '- 저작권을 침해하는 영상은 신고 후 삭제될 수 있어요.\n'
          '- 초대 코드는 실제로 아는 친구에게만 공유해 주세요.\n\n'
          '자세한 내용은 설정 > 이용약관에서 확인하실 수 있어요.',
    ),
    Notice(
      id: 4,
      title: '추석 연휴 고객센터 운영 안내',
      createdAt: DateTime(2026, 8, 28),
      content:
          '추석 연휴 기간(9/16 ~ 9/18) 동안 고객센터 운영이 일시 중단됩니다.\n\n'
          '연휴 이후 순차적으로 문의에 답변드릴 예정이니 너그러운 양해 부탁드립니다.\n'
          '즐거운 명절 보내세요!',
    ),
  ];

  @override
  Future<List<Notice>> fetchNotices() async {
    // 고정 공지가 맨 위, 그 안에서는(고정이든 아니든) 최신순.
    return [..._notices]..sort((a, b) {
      if (a.isPinned != b.isPinned) return a.isPinned ? -1 : 1;
      return b.createdAt.compareTo(a.createdAt);
    });
  }
}
