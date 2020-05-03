import 'package:adventure_time_quote_generator/features/quote_generator/domain/entities/quote.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/domain/usecases/get_random_quote.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/presentation/bloc/quote_bloc.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/presentation/colors.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/presentation/images.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/presentation/widgets/bmo_screen.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/presentation/widgets/generate_quote_button.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/presentation/widgets/generate_random_quote_button.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/presentation/widgets/inner_shadow.dart';
import 'package:adventure_time_quote_generator/features/quote_generator/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class BmoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BmoColors.BG,
      body: buildBody(context),
    );
  }

  BlocProvider<QuoteBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<QuoteBloc>(),
      child: Padding(
        padding: const EdgeInsets.all(33.0),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              BmoScreen(),
              SizedBox(
                height: 62.0,
              ),
              BmoBody(
                diskDrive: Image.asset(BmoImages.diskDrive),
                blueOvalButton: Image.asset(BmoImages.blueOvalButton),
                greenOvalButton: Image.asset(BmoImages.greenOvalButton),
                longOvalButtonLeft: Image.asset(BmoImages.longOvalButton),
                longOvalButtonRight: Image.asset(BmoImages.longOvalButton),
                plusButton: Image.asset(BmoImages.plusButton),
                redOvalButton: GenerateQuoteButton(),
                trinagleButton: Image.asset(BmoImages.traingleButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
