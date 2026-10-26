import 'package:flutter/material.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client .dart'; // نفس الـ import المستخدم عندك في home_service
import '../../home/services/models/products_model.dart';
import 'product_details_screen.dart';

class ProductDetailsByIdScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsByIdScreen({super.key, required this.productId});

  @override
  State<ProductDetailsByIdScreen> createState() =>
      _ProductDetailsByIdScreenState();
}

class _ProductDetailsByIdScreenState extends State<ProductDetailsByIdScreen> {
  late Future<Productsmodel> _future;

  @override
  void initState() {
    super.initState();
    _future = _fetch();
  }

  Future<Productsmodel> _fetch() async {
    final response = await ApiClient().dio.get(
      '${ApiEndpoints.productsEndpoint}/${widget.productId}',
    );
    return Productsmodel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Productsmodel>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Failed to load product'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => setState(() => _future = _fetch()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        return ProductDetailsScreen(productsmodel: snapshot.data!);
      },
    );
  }
}