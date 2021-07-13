import 'package:ace_of_spades/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// TODO: refactor styles to a constant seperately

class MenuButton extends StatelessWidget {
  MenuButton({@required this.buttonIcon, @required this.buttonText, this.onTap});

  // TODO: make onTap required

  final IconData buttonIcon;
  final String buttonText;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextButton(
        // TODO: try ListTile for buttons
        onPressed: () {
          onTap();
        },
        child: SizedBox(
          height: 35,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: FaIcon(
                      buttonIcon,
                      color: menuIconColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    buttonText,
                    style: bodyText18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
