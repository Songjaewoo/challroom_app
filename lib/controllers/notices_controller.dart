import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/notices.dart';
import '../providers.dart';

part 'notices_controller.g.dart';

@riverpod
Future<List<Notice>> notices(Ref ref) {
  return ref.watch(noticeRepositoryProvider).fetchNotices();
}
