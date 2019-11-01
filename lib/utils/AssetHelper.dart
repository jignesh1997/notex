import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgHelper {
  static final Widget appLogo = SvgImage.asset(
    AssetNames.appLogo,
    new Size(150.0, 150.0),
  );
  static final Widget ic_google = SvgImage.asset(
    AssetNames.ic_google,
    new Size(22.0, 22.0),
  );
  static final Widget ic_facebook = SvgImage.asset(
    AssetNames.ic_facebook,
    new Size(22.0, 22.0),
  );
}

class AssetNames {
  static final String appLogo = 'assets/notepad.svg';
  static final String ic_google = 'assets/google_icon.svg';
  static final String ic_facebook = 'assets/facebook_icon.svg';
}
