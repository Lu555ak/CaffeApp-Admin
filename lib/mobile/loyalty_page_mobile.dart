import 'dart:ui';

import 'package:caffe_app/models/menu_model.dart';
import 'package:caffe_app/utility/app_localizations.dart';
import 'package:caffe_app/utility/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../custom/confirm_button.dart';
import 'package:caffe_app/custom/credits_shop_component.dart';

import 'package:caffe_app/custom/credits_display.dart';

class LoyaltyPageMobile extends StatefulWidget {
  const LoyaltyPageMobile({super.key});

  @override
  State<LoyaltyPageMobile> createState() => _LoyaltyPageMobileState();
}

class _LoyaltyPageMobileState extends State<LoyaltyPageMobile> {
  final _pointsEuroAmountController = TextEditingController();
  final _pointsCreditAmountController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final roadMapControler = TextEditingController();
  final List<int> roadmap = [];
  final _showPointFormKey = GlobalKey<FormState>();

  int pointsEuroAmount = 1;
  int pointsCreditAmount = 1;

  @override
  void dispose() {
    _pointsEuroAmountController.dispose();
    _pointsCreditAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      CreditsDisplay(
          euroAmount: pointsEuroAmount,
          creditsAmount: pointsCreditAmount,
          onClick: () {
            _formulaEdit();
          }),
      Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            AppLocalizations.of(context).translate("credit_shop_text"),
            style: const TextStyle(color: subColor2, fontSize: 25, fontWeight: FontWeight.w900),
          )),
      Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: Menu().getCreditMenuItems.length,
          itemBuilder: (context, index) {
            return CreditsShopComponent(item: Menu().getCreditMenuItems[index]);
          },
        ),
      ),
    ]));
  }

  void _formulaEdit() {
    _pointsEuroAmountController.text = pointsEuroAmount.toString();
    _pointsCreditAmountController.text = pointsCreditAmount.toString();

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: const EdgeInsets.all(25),
              child: SingleChildScrollView(
                child: Column(children: [
                  Text(
                    AppLocalizations.of(context).translate("edit_formula_text"),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Form(
                    key: _showPointFormKey,
                    child: SizedBox(
                      height: 50,
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        SizedBox(
                          width: 22,
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(2),
                            ],
                            keyboardType: TextInputType.number,
                            controller: _pointsEuroAmountController,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: '-',
                            ),
                            autocorrect: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context).translate("warning_enter_price");
                              }
                              return null;
                            },
                          ),
                        ),
                        const Text(
                          "€ = ",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 22,
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(2),
                            ],
                            keyboardType: TextInputType.number,
                            controller: _pointsCreditAmountController,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: '-',
                            ),
                            autocorrect: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context).translate("warning_enter_price");
                              }
                              return null;
                            },
                          ),
                        ),
                        const Icon(
                          Icons.circle,
                          color: shinyColor,
                          size: 15,
                        )
                      ]),
                    ),
                  ),
                  ConfirmButton(onPress: () {
                    if (_showPointFormKey.currentState!.validate()) {
                      setState(() {
                        pointsEuroAmount = int.parse(_pointsEuroAmountController.text);
                        pointsCreditAmount = int.parse(_pointsCreditAmountController.text);
                      });
                      () async {
                        final DatabaseReference orderRef = FirebaseDatabase.instance.ref("loyalty");
                        await orderRef.set({
                          "euroRate": int.parse(_pointsEuroAmountController.text),
                          "creditsRate": int.parse(_pointsCreditAmountController.text)
                        });
                      };
                      Navigator.pop(context);
                    }
                  })
                ]),
              ),
            ),
          );
        });
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
