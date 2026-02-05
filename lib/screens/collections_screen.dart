import 'package:flutter/material.dart';
import '../models/collection.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({super.key});

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  int expandedIndex = -1;


  final int maxVisibleImages = 3;

//  Sample Data  
  final List<Collection> collections = [
    Collection(
      title: 'Collection 1',
      imageUrls: [
        'assets/premium_photo_1.jpg',
        'assets/premium_photo_2.jpg',
        'assets/premium_photo_3.jpg',
        'assets/premium_photo_4.jpg',
        'assets/premium_photo_5.jpg',
        'assets/premium_photo_6.jpg',
      ],
    ),
    Collection(
      title: 'Collection 2',
      imageUrls: [
        'assets/premium_photo_7.jpg',
        'assets/premium_photo_8.jpg',
        'assets/premium_photo_1.jpg',
        'assets/premium_photo_3.jpg',
        'assets/premium_photo_4.jpg',
        'assets/premium_photo_5.jpg',
      ],
    ),
    Collection(
      title: 'Collection 3',
      imageUrls: [
        'assets/premium_photo_2.jpg',
        'assets/premium_photo_4.jpg',
      ],
    ),
    Collection(
      title: 'Collection 4',
      imageUrls: [
        'assets/premium_photo_3.jpg',
        'assets/premium_photo_5.jpg',
        'assets/premium_photo_7.jpg',
        'assets/premium_photo_1.jpg',
        'assets/premium_photo_2.jpg',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Product Collections'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: collections.asMap().entries.map((entry) {
            int index = entry.key;
            Collection collection = entry.value;
            bool isExpanded = expandedIndex == index;

            return _buildCollectionCard(collection, index, isExpanded);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildCollectionCard(Collection collection, int index, bool isExpanded) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          InkWell(
            onTap: () {
              setState(() {
                expandedIndex = isExpanded ? -1 : index;
              });
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    collection.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    size: 28,
                    color: Colors.black87,
                  ),
                ],
              ),
            ),
          ),

        
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: _buildImageRow(collection.imageUrls),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageRow(List<String> imageUrls) {
    int remainingCount = imageUrls.length - maxVisibleImages;

    return SizedBox(
      height: 100,
      child: _ScrollableImageRow(
        imageUrls: imageUrls,
        maxVisibleImages: maxVisibleImages,
        remainingCount: remainingCount,
      ),
    );
  }
}

class _ScrollableImageRow extends StatefulWidget {
  final List<String> imageUrls;
  final int maxVisibleImages;
  final int remainingCount;

  const _ScrollableImageRow({
    required this.imageUrls,
    required this.maxVisibleImages,
    required this.remainingCount,
  });

  @override
  State<_ScrollableImageRow> createState() => _ScrollableImageRowState();
}

class _ScrollableImageRowState extends State<_ScrollableImageRow> {
  bool hasScrolled = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    if (_scrollController.offset > 0 && !hasScrolled) {
      setState(() => hasScrolled = true);
    } else if (_scrollController.offset == 0 && hasScrolled) {
      setState(() => hasScrolled = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (100.0 * widget.maxVisibleImages) + (8.0 * (widget.maxVisibleImages - 1)),
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...widget.imageUrls.asMap().entries.map((entry) {
              int imgIndex = entry.key;
              String imageUrl = entry.value;
              // Show +N overlay on the last initially visible image, hide when scrolled
              // Only show if there are more images than maxVisibleImages
              int totalImages = widget.imageUrls.length;
              int overlayIndex = (totalImages > widget.maxVisibleImages) 
                  ? widget.maxVisibleImages - 1 
                  : -1;
              int remaining = totalImages - widget.maxVisibleImages;
              bool showOverlay = imgIndex == overlayIndex && remaining > 0 && !hasScrolled;

              return Padding(
                padding: EdgeInsets.only(
                    right: imgIndex < widget.imageUrls.length - 1 ? 8 : 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                        // +N overlay - disappears when scrolling
                        if (showOverlay)
                          Container(
                            color: Colors.black.withOpacity(0.5),
                            child: Center(
                              child: Text(
                                '+$remaining',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}