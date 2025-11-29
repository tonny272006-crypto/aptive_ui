import 'package:aptive_one/Screens/feedback.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:aptive_one/Screens/notesActivity.dart';
import 'package:aptive_one/Screens/LibraryActivity.dart';
import 'package:aptive_one/Screens/CreateFLS.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aptiv Study App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Roboto',
        colorScheme: const ColorScheme.dark(
          // Added const for efficiency
          primary: Color(0xFF6ECCC0),
          secondary: Color(0xFF6ECCC0),
          surface: Color(0xFF2A2E39),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

// 1. Convert HomeScreen to StatefulWidget
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 2. State variable to track the currently selected index.
  int _selectedIndex = 0;
  String _studySegmentSelected = 'Streak';

  // Data for the deck cards
  final List<Map<String, dynamic>> _deckData = const [
    {
      'title': 'Chemistry Notes',
      'cardCount': 12,
      'lastStudied': '2h ago',
      'progress': 0.85,
      'progressColor': Color(0xFF6ECCC0),
      'progressText': '85%',
    },
    {
      'title': 'Physics Formulas',
      'cardCount': 8,
      'lastStudied': '1d ago',
      'progress': 0.92,
      'progressColor': Colors.green,
      'progressText': '92%',
    },
    {
      'title': 'RCB',
      'cardCount': 20,
      'lastStudied': '3d ago',
      'progress': 0.45,
      'progressColor': Colors.red,
      'progressText': '45%',
    },
  ];

  // 3. Callback function to update the selected index
  void _handleDeckSelected(int index) {
    setState(() {
      _selectedIndex = index;
      // print('Selected Deck Index: $_selectedIndex'); // Debug
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body uses a Column to fix the bottom nav and allow the rest to scroll
      body: Column(
        children: [
          // 1. Scrolling Content (Takes up remaining space and scrolls)
          Expanded(
            child: SingleChildScrollView(
              child: SafeArea(
                // Use SafeArea around the scrolling content
                child: Column(
                  children: [
                    // App Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Aptiv',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFF6ECCC0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Progress Circle
                    CircularPercentIndicator(
                      radius: 70.0,
                      lineWidth: 10.0,
                      percent: 0.7,
                      center: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '70%',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6ECCC0),
                            ),
                          ),
                          Text(
                            'Daily Goal',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                      progressColor: const Color(0xFF6ECCC0),
                      backgroundColor: const Color(0xFF2A2E39),
                    ),

                    const SizedBox(height: 20),

                    // Study Streak
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // === 1. Tappable 'Study' Text ===
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _studySegmentSelected = 'Study';
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  // Change background color based on selection
                                  color: _studySegmentSelected == 'Study'
                                      ? const Color(0xFF6ECCC0)
                                      : const Color.fromARGB(255, 0, 0, 0),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                ),
                                child: Text(
                                  'Study',
                                  style: TextStyle(
                                    fontSize: 18,
                                    // Change text color for contrast/selection
                                    color: _studySegmentSelected == 'Study'
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 4),

                            // === 2. Tappable 'Streak' Container ===
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _studySegmentSelected = 'Streak';
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  // Change background color based on selection
                                  color: _studySegmentSelected == 'Streak'
                                      ? const Color(0xFF6ECCC0)
                                      : const Color.fromARGB(255, 0, 0, 0),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                ),
                                child: Text(
                                  'Streak',
                                  style: TextStyle(
                                    fontSize: 18,
                                    // Change text color for contrast/selection
                                    color: _studySegmentSelected == 'Streak'
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // ... rest of the column (SizedBox, Text '12 Days')
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Next Review Card
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2E39),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Next Review',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF6ECCC0),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Biology Deck',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '5 cards due now',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AptivReviewPage(data: "Biology"),
                                  ),
                                );
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6ECCC0),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: const Icon(
                                  Icons.play_arrow,
                                  color: Color(0xFF2A2E39),
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Recent Decks
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Recent Decks',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // 5. Use map to build the DeckSelectionCard widgets
                          ..._deckData.asMap().entries.map((entry) {
                            int index = entry.key;
                            Map<String, dynamic> deck = entry.value;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: DeckSelectionCard(
                                title: deck['title'],
                                cardCount: deck['cardCount'],
                                lastStudied: deck['lastStudied'],
                                progress: deck['progress'],
                                progressColor: deck['progressColor'],
                                progressText: deck['progressText'],
                                index: index,
                                isSelected: _selectedIndex == index,
                                onSelected: _handleDeckSelected,
                              ),
                            );
                          }),

                          const SizedBox(
                            height: 20,
                          ), // Padding below the last card
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 2. Fixed Bottom Navigation (Stays pinned at the bottom)
          Container(
            height: 60,
            decoration: const BoxDecoration(color: Color(0xFF2A2E39)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NavItem(
                  icon: Icons.home,
                  label: 'Home',
                  isActive: true,
                  onTap: () {
                    // If already on Home, do nothing or scroll to the top
                  },
                ),

                // Library
                NavItem(
                  icon: Icons.menu_book,
                  label: 'Library',
                  isActive: false,
                  onTap: () {
                    // Use push to navigate to the new screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AptivReviewPage1(data: "Biology"),
                      ), // Replace with your actual activity
                    );
                  },
                ),

                // Create
                NavItem(
                  icon: Icons.add,
                  label: 'Create',
                  isActive: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageSaverScreen(),
                      ), // Replace with your actual activity
                    );
                  },
                ),

                // Stats
                NavItem(
                  icon: Icons.message,
                  label: 'Feedback',
                  isActive: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FeedbackPage(),
                      ), // Replace with your actual activity
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// WIDGET COMPONENTS
// =========================================================================

// DeckSelectionCard: Replaces DeckCard to handle single-selection logic.
class DeckSelectionCard extends StatelessWidget {
  final String title;
  final int cardCount;
  final String lastStudied;
  final double progress;
  final Color progressColor;
  final String progressText;

  // New properties for selection logic
  final int index;
  final bool isSelected;
  final Function(int) onSelected;

  const DeckSelectionCard({
    super.key,
    required this.title,
    required this.cardCount,
    required this.lastStudied,
    required this.progress,
    required this.progressColor,
    required this.progressText,
    required this.index,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the border color based on selection status
    final borderColor = isSelected ? progressColor : const Color(0xFF2A2E39);

    return GestureDetector(
      // Wrap with GestureDetector to make it tappable
      onTap: () {
        onSelected(index); // Call the parent function with this card's index
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2E39),
          borderRadius: BorderRadius.circular(12),
          // Add a border to show selection status
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AptivReviewPage(data: title),
                      ),
                    );
                  },
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                // Show a checkmark icon when selected, otherwise show progress text
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFF3A3E49),
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
            const SizedBox(height: 8),
            Text(
              '$cardCount cards • Last studied $lastStudied',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// NavItem widget for the bottom navigation bar
class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const NavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? const Color(0xFF6ECCC0) : Colors.grey;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12, color: color)),
        ],
      ),
    );
  }
}
