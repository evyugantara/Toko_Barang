import 'package:flutter/material.dart';
import '../models/item.dart';

class CartScreen extends StatelessWidget {
  final List<Item> cart;

  CartScreen({required this.cart});

  @override
  Widget build(BuildContext context) {
    double total = cart.fold(0.0, (sum, item) => sum + item.price);

    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang Belanja'),
      ),
      body: cart.isEmpty
          ? Center(child: Text('Keranjang Anda kosong'))
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  leading: Image.network(cart[index].imageUrl, width: 50),
                  title: Text(cart[index].title),
                  subtitle: Text('\$${cart[index].price.toStringAsFixed(2)}'),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            // Implement order submission logic here
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text('Pesanan Diterima'),
                content: Text('Total Harga: \$${total.toStringAsFixed(2)}'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      Navigator.pop(ctx);
                    },
                    child: Text('Tutup'),
                  ),
                ],
              ),
            );
          },
          child: Text('Proses Pesanan (Total: \$${total.toStringAsFixed(2)})'),
        ),
      ),
    );
  }
}
