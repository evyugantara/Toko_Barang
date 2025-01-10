import 'package:flutter/material.dart';
import '../models/item.dart';
import '../widgets/item_card.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Item> _items = [
    Item(
      id: '1',
      title: 'Laptop',
      description: 'High performance laptop',
      price: 999.99,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Item(
      id: '2',
      title: 'Headphones',
      description: 'Noise-cancelling headphones',
      price: 199.99,
      imageUrl: 'https://via.placeholder.com/150',
    ),
    Item(
      id: '3',
      title: 'Smartphone',
      description: 'Latest model smartphone',
      price: 799.99,
      imageUrl: 'https://via.placeholder.com/150',
    ),
  ];

  final List<Item> _cart = [];

  void _addToCart(Item item) {
    setState(() {
      _cart.add(item);
    });
  }

  void _goToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(cart: _cart),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toko Pemesanan Barang'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: _goToCart,
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: _items.length,
        itemBuilder: (ctx, index) {
          return ItemCard(item: _items[index], addToCart: _addToCart);
        },
      ),
    );
  }
}
