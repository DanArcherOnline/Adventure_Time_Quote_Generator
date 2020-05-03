import 'package:adventure_time_quote_generator/features/quote_generator/domain/entities/quote.dart';
import 'package:flutter/material.dart';

class QuoteDisplay extends StatelessWidget {
  final Quote quote;
  const QuoteDisplay({
    @required this.quote,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(quote.quote),
              SizedBox(
                height: 16.0,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '- ${quote.character}',
                  style: Theme.of(context).textTheme.body2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
