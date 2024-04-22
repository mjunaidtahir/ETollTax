import 'package:flutter/material.dart';

class AppBottomSheet {
  AppBottomSheet._();

  static Future<T?> showScrollableBottomSheet<T>({
    required BuildContext context,
    double minChildSize = 0.4,
    Widget Function(BuildContext context, ScrollController scrollController)?
        builder,
  }) {
    return showModalBottomSheet<T>(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: DraggableScrollableSheet(
            initialChildSize: minChildSize + 0.1,
            minChildSize: minChildSize,
            builder: (_, scrollController) {
              return Material(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 8,
                        width: MediaQuery.of(context).size.width * 0.20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey,
                        ),
                      ),
                      if (builder != null)
                        Flexible(child: builder(context, scrollController)),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  static Future<T?> showRatingCriteriaBottomSheet<T>({
    required BuildContext context,
    double minChildSize = 0.4,
    Widget Function(BuildContext context, ScrollController scrollController)?
        builder,
  }) {
    return showModalBottomSheet<T>(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: DraggableScrollableSheet(
            initialChildSize: minChildSize + 0.1,
            minChildSize: minChildSize,
            builder: (_, scrollController) {
              return Material(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rating Criteria",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Average is based on this rating criteria.",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (builder != null)
                        Flexible(child: builder(context, scrollController)),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
