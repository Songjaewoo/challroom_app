import '../../models/faqs.dart';
import '../../repositories/faq_repository.dart';

/// `API_BASE_URL` 이 없을 때(지금 상태) 자주 묻는 질문 화면을 미리 보기 위한 샘플 데이터.
class LocalFaqRepository implements FaqRepository {
  const LocalFaqRepository();

  static const _faqs = [
    Faq(
      id: 1,
      category: '계정',
      question: '닉네임은 나중에 바꿀 수 있나요?',
      answer: '네, 언제든 바꿀 수 있어요. 설정 > 프로필 편집에서 닉네임과 프로필 사진을 수정할 수 있습니다.',
    ),
    Faq(
      id: 2,
      category: '계정',
      question: '로그인한 계정을 다른 소셜 계정으로 바꿀 수 있나요?',
      answer: '아직은 소셜 계정 전환 기능을 지원하지 않아요. 다른 계정으로 로그인하려면 기존 계정을 로그아웃한 뒤 새 계정으로 다시 로그인해 주세요.',
    ),
    Faq(
      id: 3,
      category: '방 / 챌린지',
      question: '방은 몇 명까지 초대할 수 있나요?',
      answer: '현재는 인원 제한이 따로 없어요. 초대 코드나 링크만 있으면 누구나 들어올 수 있습니다.',
    ),
    Faq(
      id: 4,
      category: '방 / 챌린지',
      question: '초대 코드는 얼마 동안 유효한가요?',
      answer: '한 번 발급한 코드는 방장이 새 코드를 다시 만들기 전까지 계속 유효해요. 코드를 바꾸고 싶으면 방 > 멤버 화면에서 "새 코드 발급"을 눌러주세요.',
    ),
    Faq(
      id: 5,
      category: '방 / 챌린지',
      question: '방장이 방을 나가면 방은 어떻게 되나요?',
      answer: '방장이 방을 나가면 방에 남은 멤버 중 한 명이 자동으로 새 방장이 됩니다.',
    ),
    Faq(
      id: 6,
      category: '영상',
      question: '유튜브·인스타그램 영상도 챌린지로 올릴 수 있나요?',
      answer: '네. 외부 링크 영상은 시스템 브라우저로 재생되고, 직접 촬영해 올린 영상은 앱 안에서 바로 재생됩니다.',
    ),
    Faq(
      id: 7,
      category: '영상',
      question: '올린 영상을 나중에 지울 수 있나요?',
      answer: '제출한 영상은 본인이 언제든 지울 수 있어요. 제출 영상의 더보기 메뉴에서 삭제를 선택해 주세요.',
    ),
    Faq(
      id: 8,
      category: '기타',
      question: '부적절한 콘텐츠는 어떻게 신고하나요?',
      answer: '방 상세 화면의 "⋮" 메뉴에서 "신고하기"를 눌러 신고할 수 있어요. 신고된 콘텐츠는 검토 후 조치됩니다.',
    ),
  ];

  @override
  Future<List<Faq>> fetchFaqs() async => _faqs;
}
