import 'package:flutter/material.dart';
import 'package:ground_b/manufacturing/component/manufacturing_request_card.dart';
import 'package:ground_b/manufacturing/model/manufacturing_request_model.dart';

import '../../common/layout/default_layout.dart';

class VerticalRequestItemList extends StatefulWidget {
  final List<ManufacturingRequestModel> manufacturingRequests;

  const VerticalRequestItemList({
    super.key,
    required this.manufacturingRequests,
  });

  @override
  State<VerticalRequestItemList> createState() =>
      _VerticalRequestItemListState();
}

class _VerticalRequestItemListState extends State<VerticalRequestItemList> {
  List<ManufacturingRequestModel> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
            top: 8.0, bottom: 40.0, right: 12.0, left: 12.0),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final manufacturingRequest = widget.manufacturingRequests[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                if (selectedItems.contains(manufacturingRequest)) {
                  selectedItems.remove(manufacturingRequest);
                } else {
                  selectedItems.add(manufacturingRequest);
                }
              });
            },
            child: ManufacturingRequestCard.fromModel(
              model: manufacturingRequest,
              isSelected: selectedItems.contains(manufacturingRequest),
            ),
          );
        },
        separatorBuilder: (_, index) {
          return const SizedBox(height: 20.0);
        },
        itemCount: widget.manufacturingRequests.length,
      ),
    );
  }
}
