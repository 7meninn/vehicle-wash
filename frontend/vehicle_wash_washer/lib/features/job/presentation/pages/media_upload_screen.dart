import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_wash_design_system/vehicle_wash_design_system.dart';

class MediaUploadScreen extends StatefulWidget {
  const MediaUploadScreen({super.key});

  @override
  State<MediaUploadScreen> createState() => _MediaUploadScreenState();
}

class _MediaUploadScreenState extends State<MediaUploadScreen> {
  bool _hasBeforePhoto = false;
  bool _hasAfterPhoto = false;

  void _mockCaptureBefore() {
    setState(() => _hasBeforePhoto = true);
  }

  void _mockCaptureAfter() {
    setState(() => _hasAfterPhoto = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Proof of Wash')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(VerdantSpacing.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Upload Photos',
                style: VerdantTypography.headlineMedium,
              ),
              const SizedBox(height: VerdantSpacing.base),
              Text(
                'Please capture the before and after state of the vehicle to complete the job.',
                style: VerdantTypography.bodyLarge,
              ),
              const SizedBox(height: VerdantSpacing.gap * 2),
              
              _buildPhotoCard('Before Wash', _hasBeforePhoto, _mockCaptureBefore),
              const SizedBox(height: VerdantSpacing.gap * 2),
              _buildPhotoCard('After Wash', _hasAfterPhoto, _mockCaptureAfter),
              
              const Spacer(),
              
              VerdantButton(
                label: 'Submit & View Summary',
                onPressed: (_hasBeforePhoto && _hasAfterPhoto)
                    ? () {
                        context.push('/job/summary');
                      }
                    : () {},
                variant: (_hasBeforePhoto && _hasAfterPhoto) ? VerdantButtonVariant.primary : VerdantButtonVariant.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoCard(String title, bool isCaptured, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: VerdantTypography.labelMedium),
        const SizedBox(height: VerdantSpacing.base),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 160,
            decoration: BoxDecoration(
              color: VerdantColors.surfaceElevated,
              borderRadius: VerdantRadius.smallRadius,
              border: Border.all(
                color: isCaptured ? VerdantColors.warmSand : VerdantColors.border,
                width: isCaptured ? 2 : 1,
              ),
            ),
            child: isCaptured
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle, color: VerdantColors.warmSand, size: 40),
                        const SizedBox(height: 8),
                        Text('Captured', style: VerdantTypography.bodyLarge),
                      ],
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.camera_alt, color: VerdantColors.textSecondary, size: 40),
                        const SizedBox(height: 8),
                        Text('Tap to Capture', style: VerdantTypography.bodyMedium),
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
