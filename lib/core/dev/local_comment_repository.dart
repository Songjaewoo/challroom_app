import '../../models/comments.dart';
import '../../models/enums.dart';
import '../../repositories/comment_repository.dart';
import '../../repositories/user_repository.dart';

/// `API_BASE_URL` 이 없을 때(지금 상태) 댓글 시트를 미리 보기 위한 샘플 데이터.
///
/// [LocalRoomRepository] 처럼 `commentRepositoryProvider` 가 `keepAlive` 라, 시트를 열었다
/// 닫아도(화면을 옮겨 다녀도) 작성한 댓글이 앱이 켜 있는 동안은 남아있다.
///
/// 그리드 타일 배지의 `Submission.commentCount`/`ChallengeDetail.commentCount` 는 별도의
/// 정적 숫자다 — 실제 서버라면 이 목록 길이와 같은 값일 것들이, 목업이라 두 저장소로
/// 나뉘어 있다. 시트 안의 댓글 수는 이 목록이 정확한 출처다.
///
/// 작성자 닉네임은 [UserRepository] 로 물어본다(직접 [LocalDevBackend] 를 들고 있지 않는다) —
/// 그래야 `userRepositoryProvider` 를 목(mock)으로 바꿔치기한 테스트에서도 실제 로그인한
/// 유저 이름으로 댓글이 달린다.
class LocalCommentRepository implements CommentRepository {
  LocalCommentRepository(this._userRepository);

  final UserRepository _userRepository;

  final _comments = <String, List<Comment>>{
    _key(CommentTargetType.challenge, -1): [
      Comment(
        id: 1,
        nickname: '하늘',
        text: '이거 보고 바로 방 만들었어요 다들 콜?',
        createdAt: DateTime.now().subtract(const Duration(seconds: 40)),
        likeCount: 2,
      ),
      Comment(
        id: 2,
        nickname: '민지',
        text: '3세트 자세 저래도 되는건가 ㅋㅋ 궁금하네',
        createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
        likeCount: 6,
      ),
      Comment(
        id: 3,
        nickname: '지수',
        text: '원본은 유튜브라 앱에선 못 봐요, 아래 링크로 재생돼요',
        createdAt: DateTime.now().subtract(const Duration(minutes: 42)),
      ),
    ],
    _key(CommentTargetType.submission, -1): [
      Comment(
        id: 4,
        nickname: '서준',
        text: '오 폼 미쳤다 ㅋㅋㅋ 나도 내일 찍어야지',
        createdAt: DateTime.now().subtract(const Duration(minutes: 3)),
        likeCount: 4,
      ),
      Comment(
        id: 5,
        nickname: '지수',
        text: '마지막 세트 진짜 힘들어 보이는데 파이팅!!',
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        likeCount: 1,
      ),
    ],
    _key(CommentTargetType.submission, -2): [
      Comment(
        id: 6,
        nickname: '민지',
        text: '서준이 표정관리 실패 ㅋㅋㅋㅋ',
        createdAt: DateTime.now().subtract(const Duration(minutes: 20)),
        likeCount: 3,
      ),
    ],
    _key(CommentTargetType.submission, -4): [
      Comment(
        id: 7,
        nickname: '유나',
        text: '지수 승부욕 무엇 ㅋㅋㅋ',
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
        likeCount: 2,
      ),
      Comment(
        id: 8,
        nickname: '하늘',
        text: '눈 진짜 한번도 안 깜빡였다;;',
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
      Comment(
        id: 9,
        nickname: '민지',
        text: '나도 다음 방엔 이걸로 해야겠다',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        likeCount: 1,
      ),
    ],
  };

  var _nextId = 100;

  static String _key(CommentTargetType type, int id) => '${type.name}:$id';

  @override
  Future<List<Comment>> fetchComments(CommentTarget target) async {
    return List.unmodifiable(_comments[_key(target.type, target.id)] ?? const []);
  }

  @override
  Future<Comment> postComment(CommentTarget target, String text) async {
    final me = await _userRepository.fetchMe();
    final comment = Comment(id: _nextId++, nickname: me.nickname ?? '나', text: text, createdAt: DateTime.now());

    _comments.putIfAbsent(_key(target.type, target.id), () => []).add(comment);
    return comment;
  }
}
