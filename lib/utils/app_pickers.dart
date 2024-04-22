import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class AppPickers {
  AppPickers._();

  static Future<XFile?> pickImage(BuildContext context) async {
    final ImageSource? imageSource =
        await showOptionSelectionSheet<ImageSource>(
      context: context,
      options: {
        for (final value in ImageSource.values)
          value.name[0].toUpperCase() + value.name.substring(1): value,
      },
    );

    if (imageSource == null) return null;
    final ImagePicker picker = ImagePicker();
    return picker.pickImage(source: imageSource);
  }

  static Future<T?> showOptionSelectionSheet<T>({
    required BuildContext context,
    String? title,
    required Map<String, T> options,
  }) {
    return showCupertinoModalPopup<T>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(title ?? 'Choose an Option'),
        actions: options.keys
            .map(
              (key) => CupertinoActionSheetAction(
                child: Text(key),
                onPressed: () {
                  Navigator.pop(context, options[key]);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
