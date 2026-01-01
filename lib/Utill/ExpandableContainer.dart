import 'package:flutter/material.dart';

import '../helper/text_style.dart';

class ExpandableContainer extends StatefulWidget {
   ExpandableContainer({
    Key? key,
    required this.title,
    required this.isExpanded,
    required this.children,
  }) : super(key: key);

  final String title;
  bool isExpanded = false;
  final List<Widget> children;

  @override
  _ExpandableContainerState createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              widget.isExpanded = !widget.isExpanded;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title, style: CustomTextStyle.semiBold12Black),
              IconButton(
                onPressed: () {
                  setState(() {
                    widget.isExpanded = !widget.isExpanded;
                  });
                },
                icon: Icon(widget.isExpanded ? Icons.expand_less : Icons.expand_more),
              ),
            ],
          ),
        ),
        if (widget.isExpanded) ...widget.children,
      ],
    );
  }
}