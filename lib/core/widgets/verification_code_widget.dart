import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinCodeWidget extends StatelessWidget {
  const PinCodeWidget({Key? key, this.onCompleted, this.onChange}) : super(key: key);
  final Function(String)? onCompleted;
  final Function(String)? onChange;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Pinput(
        length: 4,
        androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
        onCompleted: onCompleted,
        onChanged: onChange,
      ),
    );
  }
}
