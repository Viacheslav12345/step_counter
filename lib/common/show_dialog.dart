import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showOkDialog(
    {required String? title, String? imageUrl, required BuildContext context}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade800,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          title: Text(
            title ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          content: SizedBox(
            height: 150,
            width: 150,
            child: CachedNetworkImage(
              imageUrl: imageUrl!,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Container(
                child: CircularProgressIndicator(
                    value: downloadProgress.progress, color: Colors.white60),
              ),
            ),
          ),
          actionsPadding: const EdgeInsets.only(bottom: 15),
          actions: [
            Center(
              child: SizedBox(
                height: 30,
                width: 100,
                child: CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.blueGrey,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).canvasColor,
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      });
}
