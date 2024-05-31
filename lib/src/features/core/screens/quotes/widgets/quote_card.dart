import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/src/constants/colors.dart';
import 'package:habit_tracker/src/constants/sizes.dart';
import 'package:habit_tracker/src/features/core/screens/quotes/widgets/quoteclass.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;

  QuoteCard({
    super.key,
    required this.quote,
  });
  // this.showFullQuote = false

  @override
  Widget build(BuildContext context) {
    // String truncatedQuote = quote.quoteText.split('.').take(2).join('. ') + '.';

    bool expanded = false;
    return GestureDetector(
      onTap: () {
        quotesDialogBox(context);
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(defaultSize, 12.0, defaultSize, 0),
        elevation: 0,
        color: darkColor,
        child: Container(
          decoration: BoxDecoration(
            color: darkColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      quote.qtitle,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: whiteColor,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      quote.quoteText,
                      maxLines: expanded
                          ? null
                          : 2, // Expand to show full text if expanded is true
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: whiteColor,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      quote.author,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: whiteColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0, // Adjust divider height as needed
                thickness: 1.0, // Adjust divider thickness as needed
                color: Colors.white, // Adjust divider color
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> quotesDialogBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: whiteColor,
          title: Text(
            quote.qtitle,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  quote.quoteText,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    quote.author,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: black,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                height: 45,
                width: 300,
                decoration: BoxDecoration(
                  color: greyColor, // Background color of the box
                  borderRadius: BorderRadius.circular(8.0),
                  // Border radius of the box
                ),
                child: Center(
                  child: Text("Dismiss",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: whiteColor)),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
