import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insurance_challenge/presentation/common_widgets/icon.dart';
import 'package:insurance_challenge/resource/assets.gen.dart';
import 'package:insurance_challenge/resource/colors.gen.dart';
import 'package:insurance_challenge/resource/string_resource.dart';
import 'package:insurance_challenge/utils/app_router.dart';
import 'package:insurance_challenge/utils/extensions.dart';
import 'package:insurance_challenge/utils/navigation.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                left: context.mediaQuery.size.width * 0.1,
                right: context.mediaQuery.size.width * 0.1,
                top: context.mediaQuery.size.width * 0.1,
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: context.tr(StringRes.tagLine.name),
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        letterSpacing: 0.7,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: context.tr(StringRes.productName.name),
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ColorName.yellow600,
                            height: 1.5,
                            letterSpacing: 0.7,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Divider(color: ColorName.yellow700),
                  ),
                  Text(
                    context.tr(StringRes.appDescription.name),
                    style: context.textTheme.titleLarge,
                  )
                ],
              ),
            ),
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SvgPicture.asset(
                Assets.iconsOrnamentLanding.path,
                width: context.mediaQuery.size.width,
                fit: BoxFit.fitWidth,
              ),
              WrappedIcon(
                padding: const EdgeInsets.all(16),
                margin: EdgeInsets.only(
                  bottom: context.mediaQuery.size.height * 0.1,
                ),
                decoration: BoxDecoration(
                  color: ColorName.yellow400,
                  borderRadius: BorderRadius.circular(100),
                ),
                icon: Icons.arrow_forward_rounded,
                size: 30,
                onTap: _onContinueClick,
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> _onContinueClick() async {
    dynamic result = await Navigation.push(context, AppRouter.login());

    if (result != null && mounted) {
      Navigation.pushReplacement(context, AppRouter.home());
    }
  }
}
