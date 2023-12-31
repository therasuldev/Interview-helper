import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:interview_helper/src/utils/decorations/view_utils.dart';

class OpenPDFView extends StatefulWidget {
  final String filePath;

  const OpenPDFView({super.key, required this.filePath});

  @override
  State<OpenPDFView> createState() => _OpenPDFViewState();
}

class _OpenPDFViewState extends State<OpenPDFView> {
  int currentPage = 0;
  PDFViewController? pdfViewController;
  final controller = TextEditingController();

  void setPage(int page) {
    setState(() => currentPage = page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          _PageInputField(controller: controller),
          _NavigationButton(
            controller: controller,
            pdfViewController: pdfViewController,
            setPage: setPage,
          ),
        ],
      ),
      body: PDFView(
        filePath: widget.filePath,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: false,
        pageFling: false,
        defaultPage: currentPage,
        onViewCreated: (PDFViewController controller) {
          pdfViewController = controller;
        },
        onPageChanged: (int? page, int? total) {
          setState(() => currentPage = page ?? 0);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (pdfViewController != null) {
            setPage(currentPage + 1);
            await pdfViewController!.setPage(currentPage);
          }
        },
        child: const Icon(
          Icons.arrow_downward,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _PageInputField extends StatelessWidget {
  const _PageInputField({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 40,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          label: Text(
            'Page',
            style: ViewUtils.ubuntuStyle(
              color: Colors.grey.shade300,
              fontSize: 12,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        style: TextStyle(color: Colors.grey.shade300),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          // Only numbers will be written
          FilteringTextInputFormatter.allow(RegExp(r'^\d*$')),
          // Cannot write more than 3 digits
          FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}$')),
        ],
      ),
    );
  }
}

class _NavigationButton extends StatelessWidget {
  final TextEditingController controller;
  final PDFViewController? pdfViewController;
  final Function(int) setPage;

  const _NavigationButton({
    required this.controller,
    required this.pdfViewController,
    required this.setPage,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        if (pdfViewController != null) {
          int page = int.tryParse(controller.value.text.trim()) ?? (await pdfViewController!.getCurrentPage())!;
          setPage(page);
          await pdfViewController!.setPage(page);
        }
      },
      icon: const Icon(Icons.arrow_forward),
    );
  }
}
