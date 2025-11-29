import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// IMPORTANT: Replace this placeholder with the actual public URL of your Google Form
const String _feedbackUrl =
    'https://docs.google.com/forms/d/e/1FAIpQLSck6NE6CZmwYMHzxnefJAx0u19L9qa8H18OzFauPpuatRjs_w/viewform?usp=dialog';

// Replace these placeholders with your actual social media handle and email
const String _instagramHandle = 'adityaakiwate_18';
const String _supportEmail = 'tonny.272006@gmail.com';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  // Generic function to safely launch any URI
  void _launchUrl(String uriString) async {
    final Uri url = Uri.parse(uriString);
    try {
      if (await canLaunchUrl(url)) {
        // Use externalApplication for web links, default is fine for mailto
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        // Fallback for error handling
        debugPrint('Could not launch $uriString');
        // In a production app, show a snackbar/dialog here instead of just debugPrint
      }
    } catch (e) {
      debugPrint('Launch error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Feedback'),
        backgroundColor: const Color(0xFF1D2635), // Aptiv Dark
      ),
      body: Container(
        color: const Color(0xFF2A2E39), // Aptiv Background
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // --- 1. Feedback Call to Action ---
              const Icon(
                Icons.feedback_rounded,
                color: Color(0xFF20C5B0), // Aptiv Accent Teal
                size: 80,
              ),
              const SizedBox(height: 20),
              const Text(
                'Help Us Improve!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Your honest feedback is valuable. Please tap the button below to fill out a short survey on how we can make this study tool better.',
                style: TextStyle(fontSize: 16, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () => _launchUrl(_feedbackUrl),
                icon: const Icon(Icons.open_in_new),
                label: const Text(
                  'Open Feedback Form',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF20C5B0), // Aptiv Accent Teal
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                ),
              ),
              const SizedBox(height: 60),

              // --- 2. Follow/Contact Section ---
              const Text(
                'Stay Connected',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Instagram Link
                  _ContactButton(
                    icon: Icons
                        .alternate_email, // Using a generic icon for social media link
                    label: 'Follow @$_instagramHandle',
                    onPressed: () =>
                        _launchUrl('https://instagram.com/$_instagramHandle'),
                  ),
                  const SizedBox(width: 20),
                  // Email Link (mailto)
                  _ContactButton(
                    icon: Icons.mail_outline,
                    label: 'Email Us',
                    onPressed: () => _launchUrl(
                      'mailto:$_supportEmail?subject=App%20Feedback',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'The form will open in a new tab/window.',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom widget for consistent contact buttons
class _ContactButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _ContactButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white70),
      label: Text(
        label,
        style: const TextStyle(color: Colors.white70, fontSize: 14),
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Colors.white10),
        ),
      ),
    );
  }
}
