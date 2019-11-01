import 'package:flutter/material.dart';

import 'ColorsHelper.dart';

class ProgressDialog {
  static ProgressDialog instanst = ProgressDialog();

  showProgress(BuildContext context) async {
    return await showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            children: <Widget>[
              Center(
                child: WillPopScope(
                  onWillPop: () async => false,
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        AppColors.primaryColor),
                  ),
                ),
              )
            ],
          );
        });
  }

  dismissDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
