import 'package:flutter/material.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class TextFormFieldSearch extends StatelessWidget {
  final TextEditingController txtController;
  final Widget suffixIcon;
  TextFormFieldSearch({this.txtController, this.suffixIcon});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Material(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: TextFormField(
          autovalidate: true,
          controller: txtController,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          validator: Validators.minLength(3, "Min 3 Character"),
        ),
      ),
    );
  }
}
