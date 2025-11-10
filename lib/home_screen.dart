import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> carouselImages = [
    'https://lumiere-a.akamaihd.net/v1/images/in_cinemas_763277cf.jpeg', // Moana 2
    'https://lumiere-a.akamaihd.net/v1/images/zootopia2-poster-id_f1119294.jpeg', // Zootopia 2
    'https://lumiere-a.akamaihd.net/v1/images/dated_d00ba883.jpeg', // Inside Out 2
    'https://lumiere-a.akamaihd.net/v1/images/wonderwall_dom_payoff_poster_indonesia_70x100_c_b29db809.jpeg', // Mufasa
  ];

  final List<Map<String, dynamic>> cards = [
    {
      'title': 'Moana 2',
      'price': 'Rent: \$3.99',
      'image':
          'https://lumiere-a.akamaihd.net/v1/images/in_cinemas_763277cf.jpeg',
      'color': Colors.red[700]!,
    },
    {
      'title': 'Zootopia 2',
      'price': 'Rent: \$4.99',
      'image':
          'https://lumiere-a.akamaihd.net/v1/images/zootopia2-poster-id_f1119294.jpeg',
      'color': Colors.red[700]!,
    },
    {
      'title': 'Inside Out 2',
      'price': 'Rent: \$5.99',
      'image': 'https://lumiere-a.akamaihd.net/v1/images/dated_d00ba883.jpeg',
      'color': Colors.red[700]!,
    },
    {
      'title': 'Mufasa',
      'price': 'Rent: \$3.99',
      'image':
          'https://lumiere-a.akamaihd.net/v1/images/wonderwall_dom_payoff_poster_indonesia_70x100_c_b29db809.jpeg',
      'color': Colors.red[700]!,
    },
  ];

  final CardSwiperController cardController = CardSwiperController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCarouselSection(),
            const SizedBox(height: 16),
            _buildSectionTitle('Trending Now'),
            _buildCardSwiperSection(),
            const SizedBox(height: 16),
            _buildSectionTitle('Popular Movies'),
            _buildHorizontalScrollSection(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Carousel dengan gambar tidak kepotong
  Widget _buildCarouselSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: cs.CarouselSlider(
        options: cs.CarouselOptions(
          height: 160, // Lebih kecil
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.5, // Lebih kecil
          autoPlayCurve: Curves.fastOutSlowIn,
        ),
        items: carouselImages.map((imageUrl) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                color: Colors.grey[800],
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain, // Ubah ke contain agar tidak kepotong
                  width: double.infinity,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Card Swiper dengan gambar tidak kepotong
  Widget _buildCardSwiperSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      height: 280, // Lebih kecil
      child: CardSwiper(
        controller: cardController,
        cardsCount: cards.length,
        cardBuilder: (context, index) {
          final card = cards[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Gambar dengan container background
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.grey[800],
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: Image.network(
                        card['image'],
                        fit: BoxFit
                            .contain, // Ubah ke contain agar tidak kepotong
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
                // Info section
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card['title'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        card['price'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[400],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red[700],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          'Watch Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        onSwipe: (int previousIndex, int? currentIndex,
            CardSwiperDirection direction) {
          return true;
        },
        onUndo: (int? previousIndex, int currentIndex,
            CardSwiperDirection direction) {
          return true;
        },
      ),
    );
  }

  // Horizontal scroll section dengan gambar tidak kepotong
  Widget _buildHorizontalScrollSection() {
    return SizedBox(
      height: 140, // Lebih kecil
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          return Container(
            width: 90, // Lebih kecil
            margin: const EdgeInsets.only(right: 8),
            child: Column(
              children: [
                // Gambar dengan container background
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        card['image'],
                        fit: BoxFit
                            .contain, // Ubah ke contain agar tidak kepotong
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  card['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
