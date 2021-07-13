import 'package:ace_of_spades/constants.dart';
import 'package:ace_of_spades/notices/notice_object.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticeDetails extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final NoticeObject _noticeObject;

  NoticeDetails({@required NoticeObject noticeObject}) : this._noticeObject = noticeObject;

  _displaySnackBar(BuildContext context, String message) {
    if (message == null || message.isEmpty) {
      message = 'Unexpected error occurred';
    } else {
      message = 'Cannot open $message\nPlease check if the link is valid';
    }

    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _launchUrl(String _url, BuildContext context) async {
    final url = _url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _displaySnackBar(context, url);
    }
  }

  List<Widget> buildLinksList(List<dynamic> list, BuildContext context) {
    List<Widget> widgetList = List();
    for (var item in list) {
      widgetList.add(
        InkWell(
          onTap: () {
            _launchUrl(item['url'], context);
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Text(
              item['display_text'],
              style: linkText18b,
            ),
          ),
        ),
      );
    }

    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _noticeObject.title,
                  style: title22b,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Published on ' +
                      DateFormat('dd MMM yyy').format(_noticeObject.publishedDate) +
                      ' at ' +
                      DateFormat(DateFormat.HOUR24_MINUTE).format(_noticeObject.publishedDate),
                  style: subtitle16i,
                ),
                SizedBox(height: 20),
                Text(
                  _noticeObject.desc,
                  style: bodyText18,
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: buildLinksList(_noticeObject.fileList, context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
