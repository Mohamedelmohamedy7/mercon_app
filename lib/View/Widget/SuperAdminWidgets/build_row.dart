import 'package:flutter/material.dart';

Widget buildRow(
    String label,
    String value, {
      Color? color,
      void Function()? onTap,
    }) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Expanded(
          child: Text(
            "$label:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          flex: 2,
          child: InkWell(
            onTap: onTap,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: color,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: color == null ? 0 : 8.0,
                      vertical: color == null ? 0 : 4.0),
                  child: Text(
                    value,
                    style:
                    TextStyle(color: color != null ? Colors.white : null),
                  ),
                )),
          ),
        ),
      ],
    ),
  );
}