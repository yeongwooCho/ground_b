import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ground_b/manufacturing/component/manufacturing_request_card.dart';
import 'package:ground_b/manufacturing/model/manufacturing_request_model.dart';
import 'package:ground_b/manufacturing/view/manufacturing_detail_screen.dart';

import '../../common/layout/default_layout.dart';

class VerticalRequestItemList extends StatelessWidget {
  final List<ManufacturingRequestModel> manufacturingRequests;

  const VerticalRequestItemList({
    super.key,
    required this.manufacturingRequests,
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
          final manufacturingRequest = manufacturingRequests[index];
          return GestureDetector(
            onTap: () {
              context.pushNamed(
                ManufacturingDetailScreen.routeName,
                pathParameters: {"id": manufacturingRequest.id},
              );
            },
            child:
                ManufacturingRequestCard.fromModel(model: manufacturingRequest),
          );
        },
        separatorBuilder: (_, index) {
          return const SizedBox(height: 20.0);
        },
        itemCount: manufacturingRequests.length,
      ),
    );
  }
}
