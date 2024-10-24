// ignore_for_file: use_build_context_synchronously

import 'package:api_calls/bloc/products/products_bloc.dart';
import 'package:api_calls/data/services/hive_service.dart';
import 'package:api_calls/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HiveService hiveService = HiveService();
  late ProductsBloc _productsBloc;
  @override
  void initState() {
    _productsBloc = ProductsBloc();
    _productsBloc.add(ProductsFetchedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await hiveService.clearToken().then((value) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ));
              });
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => _productsBloc,
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state.products.isNotEmpty) {
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return Card(
                    child: ListTile(
                      title: Text(product.title),
                      subtitle: Text(product.category),
                      leading: Container(
                        height: 80,
                        width: 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(70),
                            child: Image.network(product.images[0])),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("Getting Data"),
              );
            }
          },
        ),
      ),
    );
  }
}
