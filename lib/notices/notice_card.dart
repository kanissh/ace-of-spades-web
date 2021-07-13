import 'package:ace_of_spades/constants.dart';
import 'package:ace_of_spades/notices/notice_details.dart';
import 'package:ace_of_spades/ui_components/published_date_label.dart';
import 'package:flutter/material.dart';

import 'notice_object.dart';

class NoticeCard extends StatelessWidget {
  final NoticeObject _noticeObject;

  NoticeCard({NoticeObject noticeObject}) : this._noticeObject = noticeObject;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => NoticeDetails(noticeObject: _noticeObject)));
      },
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _noticeObject.title,
                style: bodyText18b,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                _noticeObject.desc,
                style: subtitle16,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              PublishedDateLabel(noticeObject: _noticeObject),
            ],
          ),
        ),
      ),
    );
  }
}
