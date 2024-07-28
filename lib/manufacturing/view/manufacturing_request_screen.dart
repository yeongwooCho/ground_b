import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ground_b/common/component/custom_ink_well_button.dart';
import 'package:ground_b/common/component/custom_text_form_field.dart';
import 'package:ground_b/common/component/default_button.dart';
import 'package:ground_b/common/const/colors.dart';
import 'package:ground_b/common/const/text_styles.dart';
import 'package:ground_b/common/view/completion_screen.dart';
import 'package:ground_b/manufacturing/provider/category_provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';
import '../provider/manufacturing_provider.dart';

class ManufacturingRequestScreen extends ConsumerStatefulWidget {
  static String get routeName => 'manufacturing_request';

  final String id;

  const ManufacturingRequestScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<ManufacturingRequestScreen> createState() =>
      _ManufacturingRequestScreenState();
}

class _ManufacturingRequestScreenState
    extends ConsumerState<ManufacturingRequestScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  String selectedCategory = '';
  String mainMaterial = '';

  @override
  Widget build(BuildContext context) {
    final manufacture = ref.watch(manufacturingDetailProvider(widget.id));
    final categories = ref.watch(manufacturingCategoriesProvider);

    return DefaultLayout(
      appbar: const DefaultAppBar(title: '생산요청'),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(manufacture.mainImageUrl),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '제작사 정보',
                    style: MyTextStyle.bodyTitleBold,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    manufacture.title,
                    style: MyTextStyle.bodyRegular,
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '카테고리',
                    style: MyTextStyle.bodyTitleBold,
                  ),
                  const SizedBox(height: 8.0),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: categories
                        .map(
                          (e) => CustomInkWellButton(
                            title: e.label,
                            onTap: () {
                              setState(() {
                                selectedCategory = e.label;
                              });
                            },
                            isSelected: selectedCategory == e.label,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '주요소재',
                    style: MyTextStyle.bodyTitleBold,
                  ),
                  const SizedBox(height: 8.0),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children:
                        ['데님', '벨벳', '쉬폰', '실크', '울', '리넨', '레자', '캐시미어', '기타']
                            .map(
                              (e) => CustomInkWellButton(
                                title: e,
                                onTap: () {
                                  setState(() {
                                    mainMaterial = e;
                                  });
                                },
                                isSelected: mainMaterial == e,
                              ),
                            )
                            .toList(),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '업로드',
                    style: MyTextStyle.bodyTitleBold,
                  ),
                  Text(
                    '참고 레퍼런스가 있다면 업로드해주세요!',
                    style: MyTextStyle.descriptionRegular.copyWith(
                      color: MyColor.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  SecondaryButton(
                    onPressed: () async {
                      // await getImage();
                    },
                    child: const Text('파일 업로드'),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '요청사항',
                    style: MyTextStyle.bodyTitleBold,
                  ),
                  const SizedBox(height: 8.0),
                  CustomTextFormField(
                    onChanged: (String value) {},
                    onSaved: (String? newValue) {},
                    validator: (String? value) {
                      return null;
                    },
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 40.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              child: PrimaryButton(
                onPressed: () {
                  context.goNamed(CompletionScreen.routeName, pathParameters: {
                    'title':
                        '제작 요청이\n완료되었습니다.:제작사 확인 후 고객님의\n연락처로 답변이 전달될 예정입니다!',
                  });
                },
                child: const Text('요청하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> getImage() async {
  //   // pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
  //   final XFile? pickedFile =
  //       await _picker.pickImage(source: ImageSource.gallery);
  //
  //   // 이미지를 정상적으로 가져왔다면 텍스트 인식 실행
  //   if (pickedFile != null) {
  //     setState(() {
  //       image = XFile(pickedFile.path); // 가져온 이미지를 _image에 저장
  //     });
  //   }
  // }
}
