import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:project/screens/home/organizer/home.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/database_service.dart';
import 'package:project/services/place_service.dart';
import 'package:project/utils/show_toast.dart';
import 'package:project/widgets/location_card.dart';
import 'package:toastification/toastification.dart';

class EventLocationsScreen extends StatefulWidget {
  final File imageFile;
  final String eventName;
  final String description;
  final String eventType;
  final String category;
  final DateTime date;
  final List<Map<String, dynamic>> ticketsType;

  const EventLocationsScreen({
    super.key,
    required this.imageFile,
    required this.eventName,
    required this.description,
    required this.eventType,
    required this.category,
    required this.date,
    required this.ticketsType,
  });

  @override
  State<EventLocationsScreen> createState() => _EventLocationsScreenState();
}

class _EventLocationsScreenState extends State<EventLocationsScreen> {
  final PlaceService _placeService = PlaceService();
  final List<EventLocation> _locations = [];
  bool _isLoading = false;

  void _addLocation() {
    setState(() {
      _locations.add(EventLocation());
    });
  }

  void _removeLocation(int index) {
    setState(() {
      _locations.removeAt(index);
    });
  }

  int get _totalTickets {
    return _locations.fold(0, (sum, location) => sum + location.ticketCount);
  }

  bool get _allLocationsValid {
    return _locations.isNotEmpty &&
        _locations.every((location) =>
            location.selectedPlace != null && location.ticketCount > 0);
  }

  Future<String> uploadToUploadcare(File file) async {
    final dio = Dio();
    String fileUrl;
    final data = FormData.fromMap({
      'UPLOADCARE_PUB_KEY': '7438886172631afe26cb',
      'UPLOADCARE_STORE': '1',
      'file': await MultipartFile.fromFile(file.path),
    });

    try {
      final response = await dio.post(
        'https://upload.uploadcare.com/base/',
        data: data,
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );
      fileUrl = "https://ucarecdn.com/${response.data['file']}/";
      return fileUrl;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _saveEvent() async {
    if (!_allLocationsValid) {
      showToast(
        'Please add at least one location with valid details.',
        ToastificationType.error,
        context,
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final locations = _locations
          .map((location) => {
                'address': location.selectedPlace!.formattedAddress,
                'name': location.selectedPlace!.name,
                'placeId': location.selectedPlace!.placeId,
                'latitude': location.selectedPlace!.latitude,
                'longitude': location.selectedPlace!.longitude,
                'ticketCount': location.ticketCount,
              })
          .toList();

      final imageUrl = await uploadToUploadcare(widget.imageFile);

      await DatabaseService().saveEventToDatabase(
        imageUrl: imageUrl,
        eventName: widget.eventName,
        description: widget.description,
        locations: locations,
        eventType: widget.eventType,
        category: widget.category,
        date: widget.date,
        organizerId: AuthService().currentUser!.uid,
        totalTickets: _totalTickets,
        ticketsType: widget.ticketsType,
      );

      if (!mounted) return;

      showToast(
        'Event created successfully!',
        ToastificationType.success,
        context,
      );

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Home()),
        (route) => false,
      );
    } catch (e) {
      if (context.mounted) {
        String errorMessage = 'Something went wrong. Please try again.';

        if (e.toString().contains('SocketException')) {
          errorMessage = 'No internet connection. Please check your network.';
        }

        showToast(
          errorMessage,
          ToastificationType.error,
          context,
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'Event Locations',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Event Locations',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: _addLocation,
                          icon: const Icon(Icons.add, color: Colors.white),
                          label: const Text(
                            'Add Location',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(20.h),
                    ..._locations.asMap().entries.map((entry) {
                      final index = entry.key;
                      final location = entry.value;
                      return LocationCard(
                        key: ValueKey(index),
                        location: location,
                        index: index,
                        placeService: _placeService,
                        onRemove: () => _removeLocation(index),
                        onLocationUpdated: () => setState(() {}),
                      );
                    }),
                    if (_locations.isNotEmpty) ...[
                      Gap(20.h),
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Tickets:',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _totalTickets.toString(),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    Gap(100.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _locations.isNotEmpty
          ? Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 25.w),
              child: FloatingActionButton.extended(
                onPressed: _saveEvent,
                backgroundColor: Colors.black,
                label: _isLoading
                    ? Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white,
                          size: 30.sp,
                        ),
                      )
                    : Text(
                        'Save Event',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class EventLocation {
  PlaceDetails? selectedPlace;
  int ticketCount = 0;
  final TextEditingController ticketController = TextEditingController();

  EventLocation() {
    ticketController.addListener(() {
      final value = int.tryParse(ticketController.text) ?? 0;
      ticketCount = value;
    });
  }

  void dispose() {
    ticketController.dispose();
  }
}
