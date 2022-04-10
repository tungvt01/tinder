import 'dart:async';
import 'package:tinder/core/utils/validations.dart';
import 'package:tinder/presentation/resources/index.dart';
import 'package:tinder/presentation/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../index.dart';

class PropertyController {
  String text = '';
  final BehaviorSubject<String> errorMessage = BehaviorSubject<String>();
  final PublishSubject<bool> isValid = PublishSubject<bool>();

  PropertyController({
    String initTextValue = '',
    String initMessage = '',
    bool initValidValue = true,
  }) {
    text = initTextValue;
    errorMessage.add(initMessage);
    isValid.add(initValidValue);
  }
}

class ValidatedInputField extends StatefulWidget {
  final TextStyle? style;

  final String? hintText;
  final TextStyle? hintStyle;

  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  final ValidatorFunction? validator;

  final Function(String)? onInputChanged;
  final Function(String)? onInputSubmitted;

  final bool readOnly;

  final Function(bool)? onFocusChanged;

  final bool obscureText;
  final bool isShowObscureControl;

  final PropertyController? propertyController;
  final ImageProvider? suffixImage;
  final ImageProvider? prefixImage;

  final EdgeInsetsGeometry? contentPadding;

  final Color? backgrondColor;
  final String? confirmText;
  final bool? upperCase;

  const ValidatedInputField(
      {this.style,
      this.hintStyle,
      this.hintText,
      this.keyboardType,
      this.inputFormatters,
      this.validator,
      this.onInputChanged,
      this.readOnly = false,
      this.onFocusChanged,
      this.obscureText = false,
      this.isShowObscureControl = false,
      this.propertyController,
      this.suffixImage,
      this.contentPadding,
      this.backgrondColor,
      this.prefixImage,
      this.confirmText,
      this.upperCase,
      this.onInputSubmitted,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ValidatedInputWidgetState();
}

class _ValidatedInputWidgetState extends State<ValidatedInputField> {
  bool _obscureText = false;
  PropertyController? _propertyController;
  final TextEditingController _textEditingController = TextEditingController();
  String _errorMesssage = '';
  bool _isValid = true;

  StreamSubscription? _messageValuSub;
  StreamSubscription? _isValidValudSub;
  StreamSubscription? _textValueSub;

  @override
  void initState() {
    super.initState();
    _propertyController = widget.propertyController ?? PropertyController();
    _obscureText = widget.obscureText;
    _textValueSub = _propertyController?.errorMessage.listen((value) {
      setState(() {
        _errorMesssage = value;
      });
    });
    _isValidValudSub = _propertyController?.isValid.listen((value) {
      setState(() {
        _isValid = value;
      });
    });
    if (_propertyController?.text != null) {
      _textEditingController.text = _propertyController!.text;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _messageValuSub?.cancel();
    _isValidValudSub?.cancel();
    _textValueSub?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: widget.backgrondColor ??
                    (widget.readOnly ? AppColors.gray : Colors.transparent),
                border: Border.all(
                    color:
                        !_isValid ? AppColors.ancent : AppColors.gray[700]!)),
            child: Focus(
              onFocusChange: (hasFocus) {
                if (widget.onFocusChanged != null) {
                  widget.onFocusChanged!(hasFocus);
                }
              },
              child: Row(
                children: [
                  widget.prefixImage != null
                      ? _buildIcon(widget.prefixImage!)
                      : Container(),
                  _buildInputTextField(),
                  widget.suffixImage != null
                      ? _buildIcon(widget.suffixImage!)
                      : Container(),
                  _buildShowHideIcon(),
                ],
              ),
            ),
          ),
          Visibility(
              visible: !_isValid,
              child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: ErrorMessageWidget(_errorMesssage)))
        ],
      ),
    );
  }

  _buildInputTextField() {
    return Expanded(
      child: TextField(
        style: widget.style ?? bodyLarge,
        obscureText: _obscureText,
        readOnly: widget.readOnly,
        controller: _textEditingController,
        inputFormatters: widget.inputFormatters,
        textCapitalization: (widget.upperCase ?? false)
            ? TextCapitalization.characters
            : TextCapitalization.none,
        keyboardType: widget.keyboardType,
        onSubmitted: (value) {
          if (widget.onInputSubmitted != null) {
            widget.onInputSubmitted!(value);
          }
        },
        onChanged: (text) {
          if (widget.validator != null) {
            setState(() {
              if (widget.validator != null) {
                _isValid = widget.validator!(text, widget.confirmText);
              }
            });
          }
          if (widget.onInputChanged != null) widget.onInputChanged!(text);
          widget.propertyController?.text = text;
        },
        decoration: InputDecoration(
            contentPadding: widget.contentPadding ??
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle ??
                bodyLarge.copyWith(
                  color: AppColors.gray[400],
                )),
      ),
    );
  }

  _buildIcon(ImageProvider image) {
    return SizedBox(
      width: 20,
      height: 20,
      child: Image(
        fit: BoxFit.contain,
        image: image,
        color: Colors.white,
      ),
    );
  }

  _buildShowHideIcon() {
    return widget.isShowObscureControl
        ? IconButton(
            iconSize: 16,
            icon: SvgPicture.asset(_obscureText
                ? AppImages.icShowPassword
                : AppImages.icHidePassword),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
        : Container();
  }
}
