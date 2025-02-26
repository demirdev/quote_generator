import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_generator/features/quote/quote.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quote_generator/common/common.dart';
import 'package:quote_generator/features/shared/shared.dart';
import 'package:quote_generator/features/shared/widgets/display_message_card.dart';

class CreateByYouScreen extends StatelessWidget {
  static CreateByYouScreen builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const CreateByYouScreen();

  const CreateByYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      body: BodyAndAppBarNestedScrollView(
        appBarTitle: l10n.app_bar_create_by_you,
        actions: [
          IconButton(
            onPressed: () => context.push(RoutesName.settings),
            icon: const FaIcon(FontAwesomeIcons.gear),
          ),
          Padding(
            padding: Dimensions.kPaddingHorizontalSmall,
            child: IconButton(
              onPressed: () => context.push(RoutesName.createQuote),
              icon: const FaIcon(
                FontAwesomeIcons.plus,
              ),
            ),
          ),
        ],
        body: Consumer(
          builder: (ctx, ref, child) {
            final quoteState = ref.watch(getQuotesProvider);
            final quotes = quoteState.allQuotes;
            final isLoading = quoteState.isLoading;
            final message = quoteState.message;

            return isLoading
                ? const LoadingView()
                : message.isNotEmpty
                    ? DisplayErrorMessage(message: message)
                    : quotes.isEmpty
                        ? Center(
                            child: Padding(
                              padding: Dimensions.kPaddingAllLarge,
                              child: EmptyQuoteCard(
                                displayIcon: FontAwesomeIcons.list,
                                displayText: l10n.empty_card_created_by_you,
                              ),
                            ),
                          )
                        : ListOfQuotes(
                            key: const Key('CreatedByYouScreen'),
                            quotes: quotes,
                          );
          },
        ),
      ),
    );
  }
}
