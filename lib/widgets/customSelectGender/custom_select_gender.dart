import 'package:flutter/material.dart';
import 'package:fyp_project/constant/appStrings/app_string.dart';
import 'package:fyp_project/constant/appText/app_text.dart';

import '../../constant/appColors/app_color.dart';

class CustomSelectGender extends StatelessWidget {
  const CustomSelectGender({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: AppText(
            title: Appstrings.authRegisterGenderText,
            color: AppColors.blackTextClr,
            fontSize: 16,
          ),
        ),
        // DropdownButtonFormField(
        //   items: ["Male", "Female"].map((selectgender) {
        //     return DropdownMenuItem(
        //       value: selectgender,
        //       child: Text(selectgender),
        //     );
        //   }).toList(),
        //   onChanged: (value) {},
        //   hint: AppText(title: Appstrings.authRegisterGender),
        // ),
        SizedBox(height: 10),
        DropdownMenu(
          width: MediaQuery.of(context).size.width * 0.9,
          hintText: Appstrings.authRegisterGender,
          textStyle: TextStyle(color: Colors.black, fontSize: 16),
          dropdownMenuEntries: ["Male", "Female"].map((gender) {
            return DropdownMenuEntry(
              label: gender,
              value: gender,
            );
          }).toList(),
        )
      ],
    );
  }
}
