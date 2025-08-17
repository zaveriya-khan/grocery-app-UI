import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const GroceryApp());
}

class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final double discount;
  final double rating;
  final String deliveryTime;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.discount,
    required this.rating,
    required this.deliveryTime,
  });
}

final List<Product> dummyProducts = [
  Product(
    id: '1',
    name: 'Fresh Farm Produce',
    imageUrl: 'assets/images/farm-fresh-produce-img.jpg',
    price: 379,
    discount: 20,
    rating: 4.5,
    deliveryTime: '30 mins',
  ),
  Product(
    id: '2',
    name: 'Deluxe Fruit Basket',
    imageUrl: 'assets/images/deluxe-fruit-basket-img.jpg',
    price: 599,
    discount: 15,
    rating: 4.8,
    deliveryTime: '45 mins',
  ),
];

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final product = dummyProducts.firstWhere((p) => p.id == id);
        return ProductDetailsScreen(product: product);
      },
    ),
  ],
);

class GroceryApp extends StatelessWidget {
  const GroceryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      routerConfig: _router,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grocery Store')),
      body: ListView.builder(
        itemCount: dummyProducts.length + 2,
        itemBuilder: (context, index) {
          if (index < dummyProducts.length) {
            final product = dummyProducts[index];
            return GestureDetector(
              onTap: () => context.go('/product/${product.id}'),
              child: Card(
                margin: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Image.asset(
                      product.imageUrl,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('₹${product.price.toStringAsFixed(0)}'),
                          Text(
                            '⭐ ${product.rating}  |  ⏱ ${product.deliveryTime}',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (index == dummyProducts.length) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '🍏 Health Tip',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Eating fresh fruits and vegetables daily can improve digestion,\nboost immunity, and help maintain healthy skin and energy levels.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '🍌 Fruit Joke of the Day',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                    SizedBox(height: 14),
                    Text(
                      'Why did the tomato turn red?\nBecause it saw the salad dressing! 😄',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                product.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Text(
                'Price: ₹${product.price.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text('Discount: ${product.discount}%'),
              Text('Rating: ⭐ ${product.rating}'),
              Text('Delivery Time: ${product.deliveryTime}'),
              const SizedBox(height: 12),
              Text(
                product.id == '1'
                    ? 'A handpicked selection of seasonal vegetables, grown using organic farming methods. \nSourced directly from trusted local farmers to ensure maximum freshness and nutrition for you and your family.'
                    : 'A premium basket of exotic fruits, Ideal for gifting or indulging yourself with nature’s finest fruits. \nSweet, juicy, and beautifully arranged for a delightful experience.',
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(243, 0, 6, 67),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
