import 'package:flutter/material.dart';
import 'package:notex/utils/ColorsHelper.dart';

class RoundedButton extends StatelessWidget {
  double _width;
  String _text;
  Color _textColor;
  Color _backgroundColor;
  double _roundRaduis;
  Widget _preIcon;
  Function _onClick;

  Function get onClick => _onClick;

  set onClick(Function value) {
    _onClick = value;
  }

  RoundedButton(
      {width = double.infinity,
      text = "",
      textColor = Colors.white,
      backgroundColor = null,
      preIcon = null,
      roundRaduis = 5.0,
      onPressed = null,
      @required onClick = null}) {
    this._width = width;
    this._text = text;
    this._textColor = textColor;
    this._backgroundColor =
        (backgroundColor != null) ? backgroundColor : AppColors.primaryColor;
    this._roundRaduis = roundRaduis;
    this._preIcon = preIcon;
    this._onClick = onClick;
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onClick,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(_roundRaduis)),
      color: _backgroundColor,
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize:
              (_preIcon != null) ? MainAxisSize.max : MainAxisSize.min,
          children: <Widget>[
            (_preIcon != null) ? _preIcon : Container(),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                _text,
                style: TextStyle(color: _textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
