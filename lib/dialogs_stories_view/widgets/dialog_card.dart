import 'package:flutter/material.dart';

class DialogCard extends StatefulWidget {
  const DialogCard({super.key, required this.text, required this.translate, required this.isLeftSide});

  final String text;
  final String translate;
  final bool isLeftSide;

  @override
  State<DialogCard> createState() => _DialogCardState();
}

class _DialogCardState extends State<DialogCard> {
  bool isShowTranslate = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.isLeftSide ? Color(0xFFF7ECE4) : Color(0xFFF7E0E3),
        shape: BeveledRectangleBorder(
          borderRadius: widget.isLeftSide
              ? BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16))
              : BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16)),
        ),
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isShowTranslate ? widget.translate : widget.text),
                TextButton(
                    onPressed: () => {
                          setState(() {
                            isShowTranslate = !isShowTranslate;
                          })
                        },
                    child:
                        Text(isShowTranslate ? 'Translate' : 'Show original'))
              ],
            )));
  }
}
