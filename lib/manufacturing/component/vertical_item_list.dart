import 'package:flutter/material.dart';
import 'package:ground_b/manufacturing/component/manufacturing_card.dart';
import 'package:ground_b/manufacturing/model/manufacturing_model.dart';

import '../../common/layout/default_layout.dart';

class VerticalItemList extends StatelessWidget {
  final List<ManufacturingModel> manufactures;

  const VerticalItemList({
    super.key,
    required this.manufactures,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
            top: 8.0, bottom: 40.0, right: 12.0, left: 12.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final manufacture = manufactures[index];
          return GestureDetector(
            onTap: () {
              // context.pushNamed(
              //   PersonalTrainingDetailScreen.routeName,
              //   pathParameters: {"id": pt.id},
              // );
            },
            child: ManufacturingCard.fromModel(model: manufacture),
          );
        },
        separatorBuilder: (_, index) {
          return const SizedBox(height: 20.0);
        },
        itemCount: manufactures.length,
      ),
    );
  }
}
