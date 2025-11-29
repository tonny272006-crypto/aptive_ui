import 'package:flutter/material.dart';

class MyExploreWig extends StatelessWidget {
  final String imageUrl;
  final String imageName;
  final Function(int, int)
  onDataSent; // Callback now expects both data and index

  const MyExploreWig({
    super.key,
    required this.imageUrl,
    required this.imageName,
    required this.onDataSent,
  });

  @override
  Widget build(BuildContext context) {
    // Note: To make this a reusable widget in the PageView,
    // the index passed to onDataSent would need to be managed by the parent.
    const int index =
        0; // Placeholder index since the widget itself doesn't know its PageView index

    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover, // Use BoxFit.cover to fill the space
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.error, color: Colors.white, size: 50),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 50),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 3, color: Colors.white),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.book,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    Padding(
                      // Removed 'const' to allow non-constant variable 'imageName'
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        imageName, // Fixed: Runtime variable used in runtime Text widget
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      onDataSent(
                        1,
                        index,
                      ); // Example: send '1' as data and 'index'
                    },
                    icon: const Icon(
                      Icons.thumb_up,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 10),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.comment,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 10),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.share,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
