import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../common/component/custom_text_form_field.dart';
import '../../common/const/colors.dart';
import '../../common/const/text_styles.dart';
import '../../user/model/address_model.dart';

class DeliveryInfo extends ConsumerStatefulWidget {
  final AddressModel address;

  const DeliveryInfo({
    super.key,
    required this.address,
  });

  @override
  ConsumerState<DeliveryInfo> createState() => _DeliveryInfoState();
}

class _DeliveryInfoState extends ConsumerState<DeliveryInfo> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _detailAddressController =
      TextEditingController();
  final TextEditingController _memoController = TextEditingController();

  bool isSelectedEqual = true;

  @override
  Widget build(BuildContext context) {
    if (isSelectedEqual) {
      _nameController.text = widget.address.name;
      _phoneController.text = widget.address.phone;
      _addressController.text = widget.address.address;
      _detailAddressController.text = widget.address.detailAddress;
      _memoController.text = widget.address.memo;
    } else {
      _nameController.text = '';
      _phoneController.text = '';
      _addressController.text = '';
      _detailAddressController.text = '';
      _memoController.text = '';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '배송 정보',
            style: MyTextStyle.bodyTitleMedium,
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                '주문자 정보와 동일',
                style: MyTextStyle.descriptionRegular,
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isSelectedEqual = !isSelectedEqual;
                  });
                },
                icon: PhosphorIcon(
                  isSelectedEqual
                      ? PhosphorIcons.checkSquare(PhosphorIconsStyle.fill)
                      : PhosphorIcons.square(),
                  size: 24.0,
                  color: MyColor.text,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          _renderTitleAndForm(
            title: '받으시는 분',
            controller: _nameController,
          ),
          const SizedBox(height: 4.0),
          _renderTitleAndForm(
            title: '연락처',
            controller: _phoneController,
          ),
          const SizedBox(height: 4.0),
          _renderTitleAndForm(
            title: '주소',
            controller: _addressController,
          ),
          const SizedBox(height: 4.0),
          _renderTitleAndForm(
            title: '상세주소',
            controller: _detailAddressController,
          ),
          const SizedBox(height: 4.0),
          _renderTitleAndForm(
            title: '배송메모',
            controller: _memoController,
          ),
        ],
      ),
    );
  }

  Widget _renderTitleAndForm({
    required String title,
    required TextEditingController controller,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 100.0,
          child: Text(
            title,
            style: MyTextStyle.descriptionRegular,
          ),
        ),
        Expanded(
          child: CustomTextFormField(
            controller: controller,
            onChanged: (String value) {},
            onSaved: (String? newValue) {},
            validator: (String? value) {
              return null;
            },
            style: MyTextStyle.descriptionRegular,
          ),
        ),
      ],
    );
  }
}
