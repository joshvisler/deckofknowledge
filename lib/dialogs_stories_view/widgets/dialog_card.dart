import 'package:flutter/material.dart';

class DialogCard extends StatefulWidget {
  const DialogCard(
      {super.key,
      required this.text,
      required this.translate,
      required this.isLeftSide});

  final String text;
  final String translate;
  final bool isLeftSide;

  @override
  State<DialogCard> createState() => _DialogCardState();
}

class _DialogCardState extends State<DialogCard> {
  String _text = '';
  String _translate = '';
  bool _isLeftSide = false;
  bool _displayTranslate = false;

  @override
  void initState() {
    super.initState();
    _text = widget.text;
    _translate = widget.translate;
    _isLeftSide = widget.isLeftSide;
    _displayTranslate = false;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _isLeftSide ? const Color(0xFFF7E0E3) : const Color(0xFFF7ECE4),
      shape: RoundedRectangleBorder(
        borderRadius: _isLeftSide
            ? const BorderRadius.only(
                bottomRight: Radius.circular(15.0),
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0))
            : const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_displayTranslate ? _translate : _text),
            TextButton(
                onPressed: () => {
                      setState(() {
                        _displayTranslate = !_displayTranslate;
                      })
                    },
                child: Text(!_displayTranslate ? 'Translate' : 'Show original'))
          ],
        ),
      ),
    );
  }
}
