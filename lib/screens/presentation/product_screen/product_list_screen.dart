import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list_app/cubit/product/product_cubit.dart';
import 'package:product_list_app/screens/presentation/product_screen/product_widgets/appbar_product_list.dart';
import 'package:product_list_app/screens/presentation/product_screen/product_widgets/filter_product_list.dart';
import 'package:product_list_app/screens/presentation/product_screen/product_widgets/product_view.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productCubit = context.read<ProductCubit>();
    return Scaffold(
      appBar: appBarProductList(context),
      body: Column(
        children: [
          FilterProductList(productCubit: productCubit),
          const Divider(height: 0),
          SizedBox(height: 10),
          ProductView(),
        ],
      ),
    );
  }
}
