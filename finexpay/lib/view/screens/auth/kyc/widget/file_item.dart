import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_coin/constants/my_strings.dart';
import 'package:local_coin/data/controller/kyc_controller/kyc_controller.dart';

import 'package:local_coin/data/model/kyc/KycResponseModel.dart';
import 'package:local_coin/view/screens/auth/kyc/widget/choose_file_list_item.dart';

class FileWidget extends StatefulWidget {

  final int index;

  const FileWidget({Key? key,required this.index}) : super(key: key);

  @override
  State<FileWidget> createState() => _FileWidgetState();
}

class _FileWidgetState extends State<FileWidget> {
  @override
  Widget build(BuildContext context) {

    return GetBuilder<KycController>(builder: (controller){
      FormModel? model=controller.formList[widget.index];
      return SizedBox(
        child:InkWell(
          onTap: (){
            controller.pickFile(widget.index);
          }, child: ChooseFileItem(fileName: model.selectedValue??MyStrings.chooseFile.tr,)),
      );
    });
  }
}
