import 'package:adventure_time_quote_generator/features/quote_generator/presentation/bloc/quote_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../images.dart';

class GenerateQuoteButton extends StatefulWidget {
  const GenerateQuoteButton({
    Key key,
  }) : super(key: key);

  @override
  _GenerateQuoteButtonState createState() => _GenerateQuoteButtonState();
}

class _GenerateQuoteButtonState extends State<GenerateQuoteButton> {
  String buttonImage;

  @override
  void initState() {
    super.initState();
    buttonImage = BmoImages.redOvalButton;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Image.asset(buttonImage),
      onTap: () => onTap(),
      onTapDown: (_) => onTapDown(),
      onTapUp: (_) => onTapUp(),
    );
  }

  void onTap() {
    dispatchGetRandomQuoteEvent();
  }

  void dispatchGetRandomQuoteEvent() {
    BlocProvider.of<QuoteBloc>(context).add(GetRandomQuoteEvent());
  }

  void onTapDown() {
    setState(() {
      buttonImage = BmoImages.redOvalButtonPressed;
    });
  }

  void onTapUp() {
    setState(() {
      buttonImage = BmoImages.redOvalButton;
    });
  }
}
