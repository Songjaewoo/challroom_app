import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/faqs.dart';
import '../providers.dart';

part 'faqs_controller.g.dart';

@riverpod
Future<List<Faq>> faqs(Ref ref) {
  return ref.watch(faqRepositoryProvider).fetchFaqs();
}
