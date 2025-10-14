import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_list_app/core/app_colors.dart';
import 'package:product_list_app/cubit/product/product_cubit.dart';
import 'package:product_list_app/cubit/product/product_state.dart';

class FilterProductList extends StatelessWidget {
  const FilterProductList({super.key, required this.productCubit});

  final ProductCubit productCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, s) {
          final hasData = s.products.isNotEmpty;
          final min = hasData
              ? s.products.map((e) => e.price).reduce((a, b) => a < b ? a : b)
              : 0.0;
          final max = hasData
              ? s.products.map((e) => e.price).reduce((a, b) => a > b ? a : b)
              : 0.0;
          final currentMin = (s.minPrice ?? min).clamp(min, max);
          final currentMax = (s.maxPrice ?? max).clamp(min, max);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  DropdownButton<String?>(
                    hint: const Text('Category'),
                    value: s.categoryFilter,
                    items: <DropdownMenuItem<String?>>[
                      const DropdownMenuItem<String?>(
                        value: null,
                        child: Text('All'),
                      ),
                      ...s.categories.map(
                        (c) =>
                            DropdownMenuItem<String?>(value: c, child: Text(c)),
                      ),
                    ],
                    onChanged: (val) => productCubit.setCategory(val),
                  ),
                  const SizedBox(width: 12),

                  DropdownButton<String?>(
                    hint: const Text('Sort'),
                    value: s.sortBy,
                    items: const [
                      DropdownMenuItem<String?>(
                        value: 'price-asc',
                        child: Text('Price ↑'),
                      ),
                      DropdownMenuItem<String?>(
                        value: 'price-desc',
                        child: Text('Price ↓'),
                      ),
                      DropdownMenuItem<String?>(
                        value: 'rating',
                        child: Text('Rating'),
                      ),
                    ],
                    onChanged: (val) => productCubit.setSort(val),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              Row(
                children: [
                  Text(
                    'Price: ${currentMin.toStringAsFixed(0)} - ${currentMax.toStringAsFixed(0)}',
                  ),
                  Expanded(
                    child: RangeSlider(
                      activeColor: AppColors.deepCyan,
                      values: RangeValues(currentMin, currentMax),
                      min: min,
                      max: max,
                      labels: RangeLabels(
                        currentMin.toStringAsFixed(0),
                        currentMax.toStringAsFixed(0),
                      ),
                      onChanged: hasData
                          ? (vals) =>
                                productCubit.setPriceRange(vals.start, vals.end)
                          : null,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
