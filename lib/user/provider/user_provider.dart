import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ground_b/common/utils/data_utils.dart';
import 'package:ground_b/manufacturing/model/enum/main_material_status.dart';
import 'package:ground_b/manufacturing/model/enum/manufacturing_category_status.dart';
import 'package:ground_b/manufacturing/model/manufacturing_request_model.dart';
import 'package:ground_b/manufacturing/provider/manufacturing_provider.dart';

import '../../common/const/data.dart';
import '../model/user_model.dart';

final userProvider = StateNotifierProvider<UserStateNotifier, UserModelBase>(
  (ref) => UserStateNotifier(ref: ref),
);

class UserStateNotifier extends StateNotifier<UserModelBase> {
  final Ref ref;

  UserStateNotifier({
    required this.ref,
  }) : super(UserModelLoading()) {
    initItems(ref: ref);
  }

  void updateInfo({
    required String name,
    required String phone,
    required String email,
  }) {
    state = (state as UserModel).copyWith(
      name: name,
      phone: phone,
      email: email,
    );
  }

  void updateRecentlyViewedItems({
    required String recentlyViewedItem,
  }) {
    final user = state as UserModel;
    if (user.recentlyViewedItems.contains(recentlyViewedItem)) {
      state = user.copyWith(recentlyViewedItems: [
        ...user.recentlyViewedItems
            .where((element) => element != recentlyViewedItem),
        recentlyViewedItem,
      ]);
    } else {
      state = user.copyWith(recentlyViewedItems: [
        ...user.recentlyViewedItems,
        recentlyViewedItem,
      ]);
    }
  }

  void initItems({required Ref ref}) {
    final manufactures =
        ref.watch(manufacturingRandomByCurrentSituationProvider);

    state = defaultUserModel.copyWith(manufacturingRequests: [
      ...manufactures.mapIndexed(
        (index, element) => ManufacturingRequestModel(
          id: index.toString(),
          manufacturing: element,
          categoryStatus: ManufacturingCategoryStatus
              .values[index % (ManufacturingCategoryStatus.values.length)],
          majorMaterials: MainMaterialStatus
              .values[index % (ManufacturingCategoryStatus.values.length)],
          uploadFile: 'uploadFile',
          requestedTerm: requestedTerms[index],
          createdAt: DataUtils.getRandomDateTime(dividerAt: DateTime.now()),
        ),
      ),
    ]);
  }
}
