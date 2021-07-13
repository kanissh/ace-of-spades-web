import 'package:ace_of_spades/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class FillEvaluation extends StatefulWidget {
  final Map<String, dynamic> evalDocument;

  FillEvaluation({Map<String, dynamic> evalDocument}) : this.evalDocument = evalDocument;

  @override
  _FillEvaluationState createState() => _FillEvaluationState();
}

class _FillEvaluationState extends State<FillEvaluation> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.evalDocument['course_code'].toString()),
          centerTitle: true,
        ),
        body: widget.evalDocument['form_url'].toString().isNotEmpty
            ? SingleChildScrollView(
                child: Html(
                data:
                    '<iframe src="${widget.evalDocument['form_url']}" width=${MediaQuery.of(context).size.width} height=${MediaQuery.of(context).size.height * 0.9} frameborder="0" marginheight="0" marginwidth="0">Loading…</iframe>',
              ))
            : Center(
                child: Text(
                  'Form not available at the moment',
                  style: subtitle16,
                ),
              ),
      ),
    );
  }
}
