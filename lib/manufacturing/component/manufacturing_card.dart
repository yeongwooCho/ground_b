import 'package:flutter/material.dart';
import 'package:ground_b/manufacturing/model/manufacturing_model.dart';

import '../../common/const/colors.dart';
import '../../common/const/text_styles.dart';
import '../model/enum/manufacturing_category_status.dart';

class ManufacturingCard extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String mainImageUrl;
  final int numberOfProgress;
  final List<String> tags;
  final List<String> referenceImageUrls;
  final ManufacturingCategoryStatus categoryStatus;

  final bool isDetail; // 상세 페이지 여부
  final String? heroKey; // 히어로 위젯 키

  const ManufacturingCard({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.mainImageUrl,
    required this.numberOfProgress,
    required this.tags,
    required this.referenceImageUrls,
    required this.categoryStatus,
    this.isDetail = false,
    this.heroKey,
  });

  factory ManufacturingCard.fromModel({
    required ManufacturingModel model,
    bool isDetail = false,
  }) {
    return ManufacturingCard(
      heroKey: model.id,
      id: model.id,
      title: model.title,
      description: model.description,
      mainImageUrl: model.mainImageUrl,
      numberOfProgress: model.numberOfProgress,
      tags: model.tags,
      referenceImageUrls: model.referenceImageUrls,
      categoryStatus: model.categoryStatus,
      isDetail: isDetail,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width - 24;

    return Container(
      decoration: BoxDecoration(
        color: MyColor.empty,
        boxShadow: isDetail
            ? []
            : [
                const BoxShadow(
                  color: MyColor.shadow,
                  blurRadius: 8.0,
                  spreadRadius: 2.0,
                ),
              ],
      ),
      child: ClipRRect(
        borderRadius:
            isDetail ? BorderRadius.circular(0.0) : BorderRadius.circular(16.0),
        child: Container(
          color: MyColor.white,
          child: Column(
            children: [
              Hero(
                tag: ObjectKey(heroKey),
                child: Image.asset(
                  mainImageUrl,
                  fit: BoxFit.fill,
                  height: 200.0,
                  width: isDetail ? double.infinity : cardWidth,
                  // height: 200.0,
                ),
              ),
              SizedBox(
                width: isDetail ? double.infinity : cardWidth,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    right: 16.0,
                    bottom: 16.0,
                    left: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        title,
                        style: MyTextStyle.bodyBold,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "제작사 진행건수 $numberOfProgress건",
                        style: MyTextStyle.bodyRegular.copyWith(
                          color: MyColor.darkGrey,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children:
                            tags.map((e) => _renderTag(title: e)).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderTag({
    required String title,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: MyColor.primary,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0,
          ),
          child: Text(
            "#$title",
            style: MyTextStyle.descriptionRegular.copyWith(
              color: MyColor.primary,
            ),
          ),
        ),
      ),
    );
  }
}
