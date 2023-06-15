import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_generator/features/quote/quote.dart';
import 'package:quote_generator/common/common.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({super.key, required this.quote});

  final Quote quote;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final autherTextStyle = textTheme.labelLarge?.copyWith(
      letterSpacing: quote.letterSpacing,
      color: colorScheme.onSurface,
    );
    final quoteTextSyle = TextStyle(
      color: colorScheme.onSurface,
      fontSize: quote.fontSize,
      wordSpacing: quote.wordSpacing,
      letterSpacing: quote.letterSpacing,
      fontWeight: Helpers.fontWeightList[quote.fontWeight],
    );

    final backgroundColor = Helpers.intToColor(quote.backgroundColor);
    final unselectedIconsColor = colorScheme.onPrimary;
    final displayFavoriteIcon = quote.isFavorite == 1
        ? FontAwesomeIcons.solidHeart
        : FontAwesomeIcons.heart;
    final selectedIconColor = quote.isFavorite == 1
        ? colorScheme.tertiaryContainer
        : unselectedIconsColor;

    return Card(
      elevation: 2,
      color: Colors.grey[50],
      shape: RoundedRectangleBorder(
        borderRadius: Dimensions.kBorderRadiusAllSmallest,
      ),
      borderOnForeground: false,
      child: Column(
        children: [
          InkWell(
            borderRadius: Dimensions.kBorderRadiusAllSmallest,
            onTap: () {
              context.pushNamed(
                RoutesName.detailScreen,
                params: {'id': '${quote.id}'},
              );
            },
            child: Container(
              width: double.infinity,
              padding: Dimensions.kPaddingAllLarge,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Dimensions.kRadiusAllSmallest,
                  topRight: Dimensions.kRadiusAllSmallest,
                ),
              ),
              child: Column(
                children: [
                  FaIcon(
                    FontAwesomeIcons.quoteRight,
                    size: Dimensions.iconSizeSmall,
                    color: colorScheme.onSurface,
                  )
                      .animate(
                        onPlay: (controller) => controller.repeat(),
                      )
                      .scale(duration: 3.seconds)
                      .rotate(),
                  Text(
                    quote.text,
                    textAlign: Helpers.textAlignList[quote.textAlign],
                    style: quoteTextSyle,
                    maxLines: 5,
                  )
                      .animate()
                      .fade(
                        duration: Constants.kAnimationDuration,
                      )
                      .fadeIn(),
                  Dimensions.kVerticalSpaceMedium,
                  Text(
                    '- ${quote.author}',
                    maxLines: 1,
                    style: autherTextStyle,
                  )
                      .animate()
                      .fade(
                        duration: Constants.kAnimationDuration,
                      )
                      .fadeIn(),
                ],
              ),
            ),
          ),
          Consumer(
            builder: (ctx, ref, child) {
              return Container(
                height: Dimensions.kQuoteCardFooterHigh,
                padding: Dimensions.kPaddingAllSmall,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Dimensions.kHorizontalSpaceLarge,
                    QuoteCardButton(
                      child: FaIcon(
                        displayFavoriteIcon,
                        size: Dimensions.iconSizeSmallest,
                        color: selectedIconColor,
                      ),
                      onPressed: () async {
                        await ref
                            .read(updateQuoteProvider.notifier)
                            .updateFavorite(quote);
                      },
                    ),
                    Dimensions.kHorizontalSpaceLarge,
                    QuoteCardButton(
                      child: FaIcon(
                        FontAwesomeIcons.copy,
                        size: Dimensions.iconSizeSmallest,
                        color: unselectedIconsColor,
                      ),
                      onPressed: () async {
                        //copy to clipboard
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
