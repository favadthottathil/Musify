import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FeedbackForm extends StatelessWidget {
   FeedbackForm({super.key});

  final formkey = GlobalKey<FormState>();

  final feedbackController = TextEditingController();

  final nameController = TextEditingController();

  Future sendEmail() async {
    final serviceId = 'service_0u6f9je';
    final templateId = 'template_p0r3jzu';
    final userId = '811ZIT_0FVnlHqHhD';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json'
      },
      body: json.encode({
        "service_id": serviceId,
        "template_id": templateId,
        "user_id": userId,
        "template_params": {
          "name": nameController.text,
          "message": feedbackController.text
        }
      }),
    );

    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(218, 3, 16, 56),
        appBar: AppBar(
          title: const Text('Feedback Form'),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const SizedBox(height: 30),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    helperText: 'Enter Your Name',
                    helperStyle: const TextStyle(color: Colors.white, fontSize: 17),
                    hintText: 'Name',
                    hintStyle: const TextStyle(fontSize: 20),
                    filled: true,
                    fillColor: Colors.white54,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  maxLines: 4,
                  controller: feedbackController,
                  decoration: InputDecoration(
                    helperText: 'Enter Your Feedback',
                    helperStyle: const TextStyle(color: Colors.white, fontSize: 17),
                    hintText: 'feedback....',
                    hintStyle: const TextStyle(fontSize: 20),
                    filled: true,
                    fillColor: Colors.white54,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: () {
                    // String feedback = feedbackController.text;
                    // sendEmail(feedback);

                    sendEmail();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.black,
                        content: Text('successfull'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.send),
                  label: const Text('Send feedback'),
                ),
              ],
            ),
          ),
        ));
  }
}
