import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../const/colors.dart';
import '../const/text_styles.dart';

class CustomDropDownMulti extends StatelessWidget {
  final List<String> dropdownList;
  final String hintText;
  final ValueChanged<List<String>> onChanged;
  final double dropdownHeight;

  const CustomDropDownMulti({
    super.key,
    required this.dropdownList,
    required this.hintText,
    required this.onChanged,
    required this.dropdownHeight,
  });

  @override
  Widget build(BuildContext context) {
    return MultiSelectDropDown(
      // controller: _controller,
      // type
      selectionType: SelectionType.multi,
      hint: hintText,
      hintStyle: MyTextStyle.descriptionRegular.copyWith(
        color: MyColor.darkGrey,
      ),

      onOptionSelected: (options) {
        onChanged(options.map((e) => e.label).toList());
      },
      onOptionRemoved: (index, option) {},

      options: dropdownList
          .mapIndexed((index, element) => ValueItem<int>(
                label: element,
                value: index,
              ))
          .toList(),
      maxItems: 2,

      chipConfig: ChipConfig(
        wrapType: WrapType.wrap,
        backgroundColor: MyColor.white,
        labelColor: MyColor.text,
        labelStyle: MyTextStyle.descriptionRegular,
        deleteIcon: PhosphorIcon(
          PhosphorIcons.x(),
          size: 20.0,
        ),
        deleteIconColor: MyColor.text,
        spacing: 4.0,
        runSpacing: 0.0,
      ),

      // 일반 상태
      optionTextStyle: MyTextStyle.descriptionRegular,
      optionsBackgroundColor: MyColor.empty,

      // 선택된 상태
      selectedOptionBackgroundColor: MyColor.lightGrey,
      selectedOptionTextColor: MyColor.primary,
      showChipInSingleSelectMode: true,
      selectedOptionIcon: PhosphorIcon(
        PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
      ),

      // top
      borderRadius: 8.0,
      borderColor: MyColor.middleGrey,
      borderWidth: 1.0,
      clearIcon: null,

      // bottom
      dropdownHeight: dropdownHeight,
      dropdownBorderRadius: 8.0,
      focusedBorderColor: MyColor.primary,
      focusedBorderWidth: 2.0,

      // // 선택된 데이터
      // selectedOptions: keywords
      //     .mapIndexed((index, element) {
      //       if (user.keywords.contains(element)) {
      //         return ValueItem<int>(
      //           label: element,
      //           value: index,
      //         );
      //       } else {
      //         return const ValueItem<int>(
      //           label: '',
      //           value: -1,
      //         );
      //       }
      //     })
      //     .where((element) => element.value != -1)
      //     .toList(),
    );
  }
}
