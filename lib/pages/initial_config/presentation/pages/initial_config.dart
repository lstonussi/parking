import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parking/utils/validators.dart';
import 'package:parking/values/app_texts.dart';

class InitialConfig extends StatelessWidget {
  const InitialConfig({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final FocusNode _nameFocus = FocusNode(), _quantityFocus = FocusNode();

    return Scaffold(
      appBar: AppBar(title: const Text('Parking')),
      body: LayoutBuilder(
        builder: (_, contraints) => Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: (contraints.maxWidth * .1),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      focusNode: _nameFocus,
                      decoration: const InputDecoration(
                        label: Text(AppTexts.parkingName),
                      ),
                      validator: (value) {
                        return validateFormName(value);
                      },
                    ),
                    TextFormField(
                      focusNode: _quantityFocus,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ], // Only numbers can be entered
                      decoration: const InputDecoration(
                        label: Text(AppTexts.parkingSpaceQuantityAvailable),
                      ),
                      validator: (value) {
                        return validateFormQuantity(value);
                      },
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.amber,
                fixedSize: const Size(81, 48),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // if (widget.emailController.text.contains('@facebook')) {
                  //   showSMMessageDialog(
                  //     context: context,
                  //     title: UITexts.confirmEmail,
                  //     description:
                  //         '${UITexts.theEmail} ${widget.emailController.text} ${UITexts.isRightforContact}',
                  //     positiveItem: UITexts.yes,
                  //     positiveAction: () => _request(),
                  //     negativeItem: UITexts.no,
                  //     negativeAction: () {},
                  //   );
                  // } else {
                  //   _request();
                  // }
                }
              },
              child: const Text(
                AppTexts.save,
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}
