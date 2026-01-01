import 'package:flutter/material.dart';
import 'PdfViewerScreen.dart'; // استورد الملف اللي فيه الـ Viewer

class ContractPdfButton extends StatelessWidget {
  final String? pdfUrl;

  const ContractPdfButton({super.key, this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (pdfUrl == null || pdfUrl!.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("لا يوجد ملف PDF")),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PdfViewerScreen(pdfUrl: pdfUrl!),
            ),
          );
        }
      },
      child: Container(
        width: 180,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.deepOrangeAccent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.picture_as_pdf, color: Colors.white),
              SizedBox(width: 8),
              Text(
                "عرض العقد",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
