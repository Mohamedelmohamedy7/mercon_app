import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;
  final Function? onTap;
  DashboardCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            //  color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            //border: Border.all(color:  Colors.grey!,),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 8),
                    Container(
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle, // Makes the container a circle
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            icon,
                            size: 28,
                            color: Colors.white,
                          ),
                        )),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        value,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: color),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
