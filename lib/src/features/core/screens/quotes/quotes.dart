import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/src/constants/colors.dart';
import 'package:habit_tracker/src/features/core/screens/quotes/widgets/quote_card.dart';
import 'package:habit_tracker/src/features/core/screens/quotes/widgets/quoteclass.dart';

class QuotesList extends StatefulWidget {
  const QuotesList({super.key});

  @override
  State<QuotesList> createState() => _QuotesListState();
}

class _QuotesListState extends State<QuotesList> {
  List<Quote> quotes = [
    Quote(
        qtitle: 'Without Continual Growth',
        quoteText:
            '"Without continual growth and progress, such words as improvement, achievement, and success have no meaning."',
        author: '-Benjamin Franklin-'),
    Quote(
        qtitle: 'Do Better',
        quoteText:
            '"Do the best you can until you know better. Then when you know better, do better."',
        author: '-Maya Angelou-'),
    Quote(
        qtitle: 'Action is Important',
        quoteText:
            '"Stay afraid, but do it anyway. What’s important is the action. You don’t have to wait to be confident. Just do it and eventually the confidence will follow."',
        author: '-Carrie Fisher-'),
    Quote(
        qtitle: 'Struggle is Needed',
        quoteText: '"If there is no struggle, there is no progress."',
        author: '-Frederick Douglass-'),
    Quote(
        qtitle: 'Do Not be Afraid',
        quoteText:
            '"Be not afraid of growing slowly; be afraid only of standing still."',
        author: '-Chinese Proverb-'),
    Quote(
        qtitle: 'Take Control',
        quoteText:
            '"Incredible change happens in your life when you decide to take control of what you have power over instead of craving control over what you don’t."',
        author: '-Steve Maraboli-'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          headerQuotes(context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children:
                    quotes.map((quote) => QuoteCard(quote: quote)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding headerQuotes(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.navigate_before_rounded,
              size: 35,
              color: whiteColor,
            ),
          ),
          Expanded(
            child: Text(
              "Quotes",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(color: whiteColor),
            ),
          ),
          SizedBox(width: 40),
        ],
      ),
    );
  }
}
