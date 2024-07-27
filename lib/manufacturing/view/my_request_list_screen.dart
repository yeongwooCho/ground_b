import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ground_b/manufacturing/component/vertical_request_item_list.dart';
import 'package:ground_b/manufacturing/provider/current_situation_provider.dart';
import 'package:ground_b/user/model/user_model.dart';
import 'package:ground_b/user/provider/user_provider.dart';

import '../../common/const/colors.dart';
import '../../common/const/text_styles.dart';
import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';

class MyRequestListScreen extends ConsumerWidget {
  static String get routeName => 'my_request_list';

  const MyRequestListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider) as UserModel;
    final currentSituations = ref.watch(currentSituationProvider);
    final selectedCurrentSituation =
        ref.watch(currentSituationSelectedProvider);

    return DefaultLayout(
      appbar: const DefaultAppBar(title: '나의 생산요청 현황'),
      child: Column(
        children: [
          SizedBox(
            height: 64.0,
            child: ListView.separated(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                final currentSituation = currentSituations[index];

                return Container(
                  decoration: BoxDecoration(
                    color: selectedCurrentSituation == currentSituation
                        ? MyColor.primary
                        : null,
                    border: Border.all(
                      width: 1.0,
                      color: selectedCurrentSituation == currentSituation
                          ? MyColor.empty
                          : MyColor.middleGrey,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      ref
                          .read(currentSituationSelectedProvider.notifier)
                          .state = currentSituation;
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        currentSituation.label,
                        style: MyTextStyle.bodyRegular.copyWith(
                          color: selectedCurrentSituation == currentSituation
                              ? MyColor.white
                              : null,
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(width: 8.0);
              },
              itemCount: currentSituations.length,
            ),
          ),
          Expanded(
            child: VerticalRequestItemList(
                manufacturingRequests: user.manufacturingRequests),
          ),
        ],
      ),
    );
  }
}
