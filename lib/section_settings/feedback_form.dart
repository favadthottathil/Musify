// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server/gmail.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class FeedbackForm extends StatefulWidget {
//   const FeedbackForm({super.key});

//   @override
//   State<FeedbackForm> createState() => _FeedbackFormState();
// }

// class _FeedbackFormState extends State<FeedbackForm> {
//   final formkey = GlobalKey<FormState>();

//   final feedbackController = TextEditingController();

//   final nameController = TextEditingController();

//   Future sendEmail() async {
//     final uri = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
//     const serviceId = "service_0u6f9je";
//     const templateId = "template_p0r3jzu";
//     const userId = "";
//     final response = await http.post(url,
//     headers: {'Content-Type' : 'application/json'},
//     body: json.encode({"service_id" :  })



    
    
    
    
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: const Color.fromARGB(218, 3, 16, 56),
//         appBar: AppBar(
//           title: const Text('Feedback Form'),
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(30),
//           child: Column(
//             children: [
//               const SizedBox(height: 30),
//               TextFormField(
//                 controller: nameController,
//                 decoration: InputDecoration(
//                   helperText: 'Enter Your Name',
//                   helperStyle: const TextStyle(color: Colors.white, fontSize: 17),
//                   hintText: 'Name',
//                   hintStyle: const TextStyle(fontSize: 20),
//                   filled: true,
//                   fillColor: Colors.white54,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30),
//               TextFormField(
//                 controller: feedbackController,
//                 decoration: InputDecoration(
//                   helperText: 'Enter Your Feedback',
//                   helperStyle: const TextStyle(color: Colors.white, fontSize: 17),
//                   hintText: 'feedback....',
//                   hintStyle: const TextStyle(fontSize: 20),
//                   filled: true,
//                   fillColor: Colors.white54,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               ElevatedButton.icon(
//                 onPressed: () {
//                   String feedback = feedbackController.text;
//                   sendEmail(feedback);
//                 },
//                 icon: const Icon(Icons.send),
//                 label: const Text('Send feedback'),
//               ),
//             ],
//           ),
//         ));
//   }
// }
