import 'package:adventure_time_quote_generator/features/quote_generator/presentation/bloc/quote_bloc.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/presentation/widgets/quote_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../colors.dart';
import '../images.dart';
import 'inner_shadow.dart';
import 'loading_widget.dart';
import 'message_display.dart';

class BmoScreen extends StatelessWidget {
  const BmoScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      decoration: BoxDecoration(
        color: BmoColors.SCREEN,
        borderRadius: BorderRadius.all(
          Radius.circular(24.0),
        ),
      ),
      child: Container(
        child: buildBlocBuilder(),
      ),
    );
  }
}

BlocBuilder<QuoteBloc, QuoteState> buildBlocBuilder() {
  return BlocBuilder<QuoteBloc, QuoteState>(
    builder: (BuildContext context, state) {
      if (state is QuoteEmpty) {
        return BmoFaceSmile();
      } else if (state is QuoteLoading) {
        return LoadingWidget();
      } else if (state is QuoteLoaded) {
        return QuoteDisplay(
          quote: state.quote,
        );
      } else if (state is QuoteError) {
        return MessageDisplay(
          message: state.errorMessage,
        );
      } else
        return BmoFaceSmile();
    },
  );
}

class BmoFaceSmile extends StatelessWidget {
  const BmoFaceSmile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 60,
        right: 60,
        top: 60,
        bottom: 90.0,
      ),
      child: Image.asset(
        BmoImages.faceSmile,
      ),
    );
  }
}
