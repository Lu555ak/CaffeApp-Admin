import 'package:caffe_app/utility/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:caffe_app/utility/constants.dart';

import 'package:caffe_app/models/menu_model.dart';

class CreditsShopComponent extends StatelessWidget {
  final MenuItem item;

  const CreditsShopComponent({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: subColor,
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: subColor2.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(-5, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Flexible(
                flex: 2,
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              item.getName,
                              style: const TextStyle(color: subColor2, fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                        ],
                      ),
                    ))),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${AppLocalizations.of(context).translate("price_text")}: ",
                      style: const TextStyle(color: subColor2, fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(item.getCreditPrice.toString(),
                              style: const TextStyle(color: shinyColor, fontSize: 22.5, fontWeight: FontWeight.w600)),
                          const Icon(
                            Icons.circle,
                            color: shinyColor,
                          )
                        ],
                      )),
                ]),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
