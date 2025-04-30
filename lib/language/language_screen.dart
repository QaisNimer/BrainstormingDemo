import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../controller/lang_controller.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(AppLocalizations.of(context)!.welcome_to_salah),
          Text(
            AppLocalizations.of(
              context,
            )!.enjoy_af_a_stand_smooth_food_delivery_at_your_door_step,
          ),
          Text(AppLocalizations.of(context)!.get_delivery_on_time),
          Text(
            AppLocalizations.of(
              context,
            )!.order_your_favorite_food_with_in_the_plam_of_your_handand_the_zone_of_your_comfort,
          ),

          TextButton(
            onPressed: () {
              Provider.of<LangController>(
                context,
                listen: false,
              ).changeLang(langCode: "ar");
            },
            child: Text("Arabic"),
          ),
          TextButton(
            onPressed: () {
              Provider.of<LangController>(
                context,
                listen: false,
              ).changeLang(langCode: "en");
            },
            child: Text("English"),
          ),
        ],
      ),
    );
  }
}
