import 'package:ace_of_spades/config/db.config.dart';
import 'package:ace_of_spades/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _feedbackFormKey = GlobalKey<FormState>();

  CollectionReference feedbackCollection = FirebaseFirestore.instance.collection(DbConfigPath.FEEDBACK);
  TextEditingController subjectTextController = TextEditingController();
  TextEditingController messageTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _feedbackFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Subject', style: bodyText18b),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: subjectTextController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: 'Reporting bug or Suggestion...',
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return '*Subject is required';
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Message', style: bodyText18b),
                SizedBox(height: 5),
                TextFormField(
                  controller: messageTextController,
                  maxLines: 8,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: 'Enter message...',
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return '*Message is required';
                    } else if (value.length <= 10) {
                      return '*Please provide a meaning full message';
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                    'Please note that your email is automatically recorded when submitting a feedback. This is solely for the purpose of preventing spam feedbacks.',
                    style: subtitle16i),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  onPressed: () {
                    if (_feedbackFormKey.currentState.validate()) {
                      feedbackCollection.add({
                        'email': FirebaseAuth.instance.currentUser.email,
                        'subject': subjectTextController.text,
                        'message': messageTextController.text
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Feedback Sent!!!'),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.green[500],
                        ),
                      );

                      _feedbackFormKey.currentState.reset();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'Oops!!! Please check the data entered and try again.',
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red[500],
                      ));
                    }
                  },
                  child: Text('Submit'),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
