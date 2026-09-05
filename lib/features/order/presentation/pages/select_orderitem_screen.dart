import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:sihati/core/constants/app_images.dart';
import 'package:sihati/core/routes/navigation.dart';
import 'package:sihati/core/utils/style.dart';
import 'package:sihati/features/order/presentation/cubit/order_cubit.dart';
import 'package:sihati/features/products/presentation/cubit/product_cubit.dart';
import 'package:sihati/features/products/presentation/cubit/product_state.dart';

class SelectOrderItemScreen extends StatelessWidget {
  const SelectOrderItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ProductCubit>();
    OrderCubit orderCubit = context.read<OrderCubit>();

    final colors = {
      'Green': Colors.green,
      'Blue': Colors.blue,
      'Orange': Colors.orange,
      'Purple': Colors.purple,
      'Pink': Colors.pink,
    };

    return Scaffold(
      appBar: AppBar(title: Text('Select Order Item')),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductSuccess) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              itemCount: cubit.products.length,
              itemBuilder: (context, index) {
                var product = cubit.products[index];
                return GestureDetector(
                  onTap: () {
                    orderCubit.addProductToOrder(product); 
                    pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Gap(10),
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey[200]!.withValues(alpha: .5),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                AppImages.logo,
                                width: 80,
                                colorFilter: ColorFilter.mode(
                                  colors[product.color] ?? Colors.black,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                          Text(product.name ?? '', style: Style.loginFieldLabel),
                          Text(
                            '${product.price} L.E',
                            style: Style.loginSubTitle,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
