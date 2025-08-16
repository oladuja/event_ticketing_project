import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:project/screens/home/organizer/event_locations_screen.dart';
import 'package:project/services/place_service.dart';

class LocationCard extends StatefulWidget {
  final EventLocation location;
  final int index;
  final PlaceService placeService;
  final VoidCallback onRemove;
  final VoidCallback onLocationUpdated;

  const LocationCard({
    super.key,
    required this.location,
    required this.index,
    required this.placeService,
    required this.onRemove,
    required this.onLocationUpdated,
  });

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  final TextEditingController _searchController = TextEditingController();
  List<PlaceSuggestion> _suggestions = [];
  bool _isSearching = false;
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    widget.location.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (widget.location.selectedPlace != null &&
        _searchController.text ==
            widget.location.selectedPlace!.formattedAddress) {
      setState(() {
        _suggestions = [];
        _showSuggestions = false;
      });
      return;
    }

    if (_searchController.text.isEmpty) {
      setState(() {
        _suggestions = [];
        _showSuggestions = false;
      });
      return;
    }

    setState(() => _isSearching = true);
    _searchPlaces(_searchController.text);
  }

  Future<void> _searchPlaces(String query) async {
    try {
      final suggestions = await widget.placeService.getPlaceSuggestions(query);
      if (mounted) {
        setState(() {
          _suggestions = suggestions;
          _isSearching = false;
          _showSuggestions = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSearching = false;
          _showSuggestions = false;
        });
      }
    }
  }

  Future<void> _selectPlace(PlaceSuggestion suggestion) async {
    final placeDetails =
        await widget.placeService.getPlaceDetails(suggestion.placeId);

    if (placeDetails != null) {
      setState(() {
        widget.location.selectedPlace = placeDetails;
        _searchController.text = placeDetails.formattedAddress;
        _showSuggestions = false;
        _suggestions.clear();
      });

      if (!mounted) return;
      FocusScope.of(context).unfocus();

      widget.onLocationUpdated();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Location ${widget.index + 1}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: widget.onRemove,
                icon: const Icon(Icons.delete_outline, color: Colors.red),
              ),
            ],
          ),
          Gap(10.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search Location',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gap(5.h),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 15.w),
                  hintText: 'Enter location...',
                  prefixIcon: _isSearching
                      ? Padding(
                          padding: EdgeInsets.all(12.w),
                          child: SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.grey),
                            ),
                          ),
                        )
                      : Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              widget.location.selectedPlace = null;
                            });
                            widget.onLocationUpdated();
                          },
                        )
                      : null,
                ),
              ),
              if (_showSuggestions && _suggestions.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        _suggestions.length > 5 ? 5 : _suggestions.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final suggestion = _suggestions[index];
                      return ListTile(
                        dense: true,
                        leading: Icon(Icons.location_on, size: 20.sp),
                        title: Text(
                          suggestion.mainText,
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        subtitle: Text(
                          suggestion.secondaryText,
                          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                        ),
                        onTap: () => _selectPlace(suggestion),
                      );
                    },
                  ),
                ),
            ],
          ),
          if (widget.location.selectedPlace != null) ...[
            Gap(10.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 20.sp),
                  Gap(8.w),
                  Expanded(
                    child: Text(
                      widget.location.selectedPlace!.name.isNotEmpty
                          ? widget.location.selectedPlace!.name
                          : widget.location.selectedPlace!.formattedAddress,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.green.shade800,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          Gap(15.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Number of Tickets',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Gap(5.h),
                    TextField(
                      controller: widget.location.ticketController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '0',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                      ),
                      onChanged: (value) => widget.onLocationUpdated(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
