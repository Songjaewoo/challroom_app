import 'package:challroom_app/controllers/comments_controller.dart';
import 'package:challroom_app/core/error/api_exception.dart';
import 'package:challroom_app/models/comments.dart';
import 'package:challroom_app/models/enums.dart';
import 'package:challroom_app/providers.dart';
import 'package:challroom_app/repositories/comment_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCommentRepository extends Mock implements CommentRepository {}

const _target = (type: CommentTargetType.challenge, id: 1);

void main() {
  setUpAll(() {
    registerFallbackValue(_target);
  });

  late MockCommentRepository repo;

  setUp(() {
    repo = MockCommentRepository();
  });

  ProviderContainer makeContainer() => ProviderContainer.test(
    overrides: [commentRepositoryProvider.overrideWithValue(repo)],
    retry: (retryCount, error) => null,
  );

  test('대상의 댓글 목록을 불러온다', () async {
    final comments = [Comment(id: 1, nickname: '민지', text: '화이팅', createdAt: DateTime(2026, 1, 1))];
    when(() => repo.fetchComments(_target)).thenAnswer((_) async => comments);

    final container = makeContainer();

    expect(await container.read(commentsProvider(_target).future), comments);
    verify(() => repo.fetchComments(_target)).called(1);
  });

  test('조회에 실패하면 AsyncError 가 된다', () async {
    when(
      () => repo.fetchComments(any()),
    ).thenThrow(const ApiException(statusCode: 404, code: 'NOT_FOUND', message: '찾을 수 없어요.'));

    final container = makeContainer();
    await container.read(commentsProvider(_target).future).catchError((_) => const <Comment>[]);

    expect(container.read(commentsProvider(_target)), isA<AsyncError<List<Comment>>>());
  });

  test('댓글을 올리면 기존 목록 끝에 이어붙는다', () async {
    final existing = [Comment(id: 1, nickname: '민지', text: '화이팅', createdAt: DateTime(2026, 1, 1))];
    final posted = Comment(id: 2, nickname: '나', text: '나도 참여!', createdAt: DateTime(2026, 1, 2));

    when(() => repo.fetchComments(_target)).thenAnswer((_) async => existing);
    when(() => repo.postComment(_target, '나도 참여!')).thenAnswer((_) async => posted);

    final container = makeContainer();
    await container.read(commentsProvider(_target).future);

    await container.read(commentsProvider(_target).notifier).post('나도 참여!');

    expect(container.read(commentsProvider(_target)).value, [...existing, posted]);
    verify(() => repo.postComment(_target, '나도 참여!')).called(1);
  });

  test('빈 문자열은 올리지 않는다', () async {
    when(() => repo.fetchComments(_target)).thenAnswer((_) async => const []);

    final container = makeContainer();
    await container.read(commentsProvider(_target).future);

    await container.read(commentsProvider(_target).notifier).post('   ');

    verifyNever(() => repo.postComment(any(), any()));
  });
}
