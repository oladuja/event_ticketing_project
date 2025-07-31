import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:project/utils/show_toast.dart';
import 'package:toastification/toastification.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showToast(
        'Message sent successfully',
        ToastificationType.success,
        context,
      );
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        title: const Text(
          'Contact Us',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'We’d love to hear from you!',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              Gap(24.h),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter your name' : null,
              ),
              Gap(16.h),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your email';
                  } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              Gap(16.h),
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                maxLines: 4,
                validator: (value) => value == null || value.isEmpty
                    ? 'Enter your message'
                    : null,
              ),
              Gap(24.h),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 14.w),
                ),
                child: const Text(
                  'Send Message',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
