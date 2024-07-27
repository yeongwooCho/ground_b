import 'package:flutter/material.dart';

import '../../common/const/colors.dart';
import '../../common/const/text_styles.dart';
import '../../common/utils/data_utils.dart';
import '../model/review_model.dart';

class ReviewContainer extends StatelessWidget {
  final String title;
  final List<ReviewModel> reviews;

  const ReviewContainer({
    super.key,
    required this.title,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: MyTextStyle.bodyTitleBold,
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  '더보기',
                  style: MyTextStyle.descriptionRegular.copyWith(
                    color: MyColor.darkGrey,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 8.0),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final review = reviews[index];

              return _ReviewCard(review: review);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 8.0);
            },
            itemCount: 3,
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final ReviewModel review;

  const _ReviewCard({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: MyColor.middleGrey,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              review.title,
              style: MyTextStyle.bodyMedium,
            ),
            const SizedBox(height: 4.0),
            Text(
              DataUtils.convertDateTimeToDateString(datetime: review.createdAt),
              style: MyTextStyle.descriptionRegular.copyWith(
                color: MyColor.darkGrey,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(review.description, style: MyTextStyle.descriptionRegular),
          ],
        ),
      ),
    );
  }
}
