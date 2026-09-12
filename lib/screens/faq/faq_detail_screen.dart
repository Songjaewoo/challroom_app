import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../models/faqs.dart';

/// 자주 묻는 질문 상세 — 목록에서 이미 불러온 [faq] 를 그대로 받아 보여준다(다시 조회하지 않는다).
class FaqDetailScreen extends StatelessWidget {
  const FaqDetailScreen({required this.faq, super.key});

  final Faq faq;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: AppColors.accentSoft, borderRadius: BorderRadius.circular(6)),
                child: Text(
                  faq.category,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.inkMuted),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Q', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primary)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      faq.question,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.ink,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(height: 1, color: AppColors.border),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('A', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.success)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      faq.answer,
                      style: const TextStyle(fontSize: 14, color: AppColors.ink, height: 1.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
