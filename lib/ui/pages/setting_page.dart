import 'package:flutter/material.dart';
import 'package:hw_sport/constants/strings.dart';
import 'package:hw_sport/ui/components/button_with_two_images.dart';
import 'package:hw_sport/ui/components/with_bottom_buttons.dart';
import 'package:hw_sport/ui/pages/privacy_policy_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../constants/colors.dart';
import '../../constants/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  double _volume = 1;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((shared){
      var sharedVolume = shared.getDouble(sharedSound);
      if (sharedVolume != null) {
        setState(() {
          _volume = sharedVolume;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: WithBottomButtons(
            disabledButton: 2,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 80,
                        child: Align(
                            alignment: Alignment.center,
                            child: settingText(settingString)
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: settingText(soundString),
                            ),
                            FractionallySizedBox(
                              widthFactor: 0.7,
                              child: SfSliderTheme(
                                data: SfSliderThemeData(
                                  activeTrackHeight: 10,
                                  inactiveTrackHeight: 10,
                                  activeTrackColor: soundBarBackgroundColor,
                                  inactiveTrackColor: soundBarColor,
                                  thumbStrokeColor: soundThumbStrokeColor,
                                  thumbStrokeWidth: 7,
                                  thumbRadius: 12,
                                  thumbColor: soundThumbColor
                                ),
                                child: SfSlider(
                                    value: _volume,
                                    onChangeEnd: (finalValue) {
                                      SharedPreferences.getInstance().then((shared){
                                        shared.setDouble(sharedSound, _volume);
                                      });
                                    },
                                    onChanged: (newValue) {
                                      setState(() {
                                        _volume = newValue;
                                      });
                                    }
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: settingText(shareTextString)
                            ),
                            Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.center,
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 70
                                  ),
                                  child: const AspectRatio(
                                    aspectRatio: 135/116,
                                    child: ButtonWithTwoImages(
                                        isEnabled: true,
                                        imageAssetPressed: "res/images/button_share(pressed).png",
                                        imageAssetUnpressed: "res/images/button_share.png",
                                        disabledImageAsset: "res/images/button_share.png",
                                        action: null
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: settingText(privacyPolicyString)
                            ),
                            Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.center,
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      maxWidth: 70
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 135/116,
                                    child: ButtonWithTwoImages(
                                        isEnabled: true,
                                        imageAssetPressed: "res/images/button_privacy_policy(pressed).png",
                                        imageAssetUnpressed: "res/images/button_privacy_policy.png",
                                        disabledImageAsset: "res/images/button_privacy_policy.png",
                                        action: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) => const PrivacyPolicyPage())
                                          );
                                        }
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ]
                ),
              ),
            )
        )
    );
  }

  Text settingText(String text) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: -0.2,
        height: 1
      ),
    );
  }
}
