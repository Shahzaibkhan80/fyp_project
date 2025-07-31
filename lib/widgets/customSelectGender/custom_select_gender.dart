import 'package:flutter/material.dart';
import 'package:fyp_project/constant/appStrings/app_string.dart';
import 'package:fyp_project/constant/appText/app_text.dart';
import 'package:fyp_project/view_modal/provider/generalProvider/general_provider.dart';
import 'package:provider/provider.dart';

class CustomSelectGender extends StatelessWidget {
  const CustomSelectGender({super.key});

  @override
  Widget build(BuildContext context) {
    final gender = Provider.of<GeneralProvider>(context);
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: AppText(
            title: Appstrings.authRegisterGenderText,
            color: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.color, // Theme color use karein
            fontSize: 16,
          ),
        ),
        SizedBox(height: 10),
        DropdownMenu(
          width: MediaQuery.of(context).size.width * 0.9,
          hintText: Appstrings.authRegisterGender,
          textStyle: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: 16,
          ),
          dropdownMenuEntries: ["Male", "Female"].map((gender) {
            return DropdownMenuEntry(
              label: gender,
              value: gender,
            );
          }).toList(),
          onSelected: (value) {
            if (value != null) {
              gender.selectgender = value;
              print('Gender selected: $value');
            }
          },
        )
      ],
    );
  }
}
