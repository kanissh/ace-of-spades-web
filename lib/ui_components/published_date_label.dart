import 'package:ace_of_spades/notices/notice_object.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PublishedDateLabel extends StatelessWidget {
  const PublishedDateLabel({
    Key key,
    @required NoticeObject noticeObject,
  })  : _noticeObject = noticeObject,
        super(key: key);

  final NoticeObject _noticeObject;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.yellow, borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Text(
          DateFormat('dd MMM yyyy').format(_noticeObject.publishedDate),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }
}
