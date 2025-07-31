import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:project/models/user.dart';
import 'package:project/services/database_service.dart';
import 'package:project/utils/show_toast.dart';
import 'package:project/widgets/auth_button.dart';
import 'package:project/widgets/form_text_field.dart';
import 'package:toastification/toastification.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:project/providers/user_provider.dart';

class EditProfileScreen extends StatefulWidget {
  final bool isOrg;
  const EditProfileScreen({super.key, required this.isOrg});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final DatabaseService _databaseService = DatabaseService();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController organizationNameController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();

  bool _saving = false;

  late UserModel currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = Provider.of<UserProvider>(context, listen: false).user!;
    nameController.text = currentUser.name;
    phoneController.text = currentUser.phoneNumber;
  }

  Future<void> _handleSave() async {
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String organizationName = organizationNameController.text.trim();

    if (name.isEmpty || phone.isEmpty) {
      showToast(
        'All fields are required.',
        ToastificationType.error,
        context,
      );
      return;
    }

    setState(() => _saving = true);

    try {
      await _databaseService.updateUserProfile(
        name: name,
        phone: phone,
        organizationName: !widget.isOrg ? organizationName : null,
      );

      final updatedUser = currentUser.copyWith(
        name: name,
        phoneNumber: phone,
        organizationName: !widget.isOrg ? organizationName : null,
      );

      if (!mounted) return;
      Provider.of<UserProvider>(context, listen: false).setUser(updatedUser);

      showToast(
        'Profile updated successfully!',
        ToastificationType.success,
        context,
      );

      Navigator.pop(context, true);
    } catch (e) {
      if (mounted) {
        showToast(
          'Failed to update profile.',
          ToastificationType.error,
          context,
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Gap(10.h),
                FormTextField(
                  controller: nameController,
                  hintText: 'Full Name',
                  keyboardType: TextInputType.text,
                ),
                Gap(15.h),
                widget.isOrg
                    ? FormTextField(
                        controller: organizationNameController,
                        hintText: 'Organization Name',
                        keyboardType: TextInputType.text,
                      )
                    : Container(),
                Gap(15.h),
                FormTextField(
                  controller: phoneController,
                  hintText: 'Phone Number',
                  keyboardType: TextInputType.phone,
                ),
                Gap(15.h),
                _saving
                    ? LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.black,
                        size: 30.sp,
                      )
                    : AuthButton(
                        onPressed: _handleSave,
                        text: 'Done',
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
