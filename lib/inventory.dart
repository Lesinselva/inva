library my_inventory_package;

import 'package:flutter/material.dart';
import 'package:net_store/mian.dart';
import 'package:subcate/subcate.dart';
import 'package:animatedfloat/animatedfloat.dart';
import 'cos_container.dart';
import 'custom_dialog.dart';

class Inva extends StatefulWidget {
  final String? firstButtonText;
  final String secButtonText;
  final Color color;
  final String title;

  const Inva({
    super.key,
    this.firstButtonText,
    required this.secButtonText,
    required this.color,
    required this.title,
  });

  @override
  _InvaState createState() => _InvaState();
}

class _InvaState extends State<Inva> {
  final List<Widget> containers = [];

  final ScrollController scrollController = ScrollController();

  void addCategoryContainer(String title) {
    if (title.isNotEmpty) {
      setState(() {
        containers.add(buildCategoryContainer(title));
      });
    }
  }

  void _addProductContainer(String title, String price) {
    if (title.isNotEmpty && price.isNotEmpty) {
      setState(() {
        containers.add(buildProductContainer(title, price, context));
      });
    }
  }

  Widget buildCategoryContainer(String title) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Subcate(
                  firstButtonText: 'Add Subcategory',
                  secButtonText: 'Add Product',
                  color: Colors.black,
                  title: title,
                ),
              ),
            );
          },
          child: CosContainer(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'lib/image/category.png',
                      package: 'inventory',
                      height: 35,
                    ),
                    const SizedBox(width: 6),
                    Text(title, style: const TextStyle(fontSize: 18)),
                  ],
                ),
                const Icon(Icons.more_vert)
              ],
            ),
          ),
        ),
        const SizedBox(height: 2),
      ],
    );
  }

  Widget buildProductContainer(
      String title, String price, BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NetStore.editProduct(color: widget.color),
              ),
            );
          },
          child: CosContainer(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Image.asset(
                  'lib/image/image.png',
                  package: 'inventory',
                  height: 40,
                ),
                const SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 18)),
                    Text('₹ $price', style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 2),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: containers.length,
                itemBuilder: (context, index) {
                  return containers[index];
                },
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomAnimatedFloatingActionButton(
                svgPath: 'packages/inventory/lib/images/addProduct.svg',
                text: 'Add product',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      final firstFieldController = TextEditingController();
                      final secondFieldController = TextEditingController();

                      return CustomDialog(
                        icon: Icons.note_alt_outlined,
                        secicon: Icons.currency_rupee,
                        title: 'Add Product',
                        subtitle: 'Product title',
                        firstButtonLabel: 'Create',
                        firstButtonColor:
                            const Color.fromARGB(255, 39, 236, 22),
                        firstButtonAction: (String title) {
                          _addProductContainer(
                              title, secondFieldController.text);
                          Navigator.of(context).pop();
                        },
                        secondButtonLabel: 'Cancel',
                        secondButtonColor: Colors.red,
                        firstFieldController: firstFieldController,
                        secondFieldController: secondFieldController,
                        maxLength: 100,
                        titleBackgroundGradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 45, 255, 26),
                            Color.fromARGB(255, 1, 136, 57),
                          ],
                        ),
                        firstButtonIcon: Icons.check,
                        secondButtonIcon: Icons.close,
                        secondButtonAction: () {
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
                scrollController: scrollController,
              ),
              const SizedBox(height: 16),
              CustomAnimatedFloatingActionButton(
                svgPath: 'packages/inventory/lib/images/addCate.svg',
                text: 'Add Category',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      final firstFieldController = TextEditingController();
                      return CustomDialog(
                        firstButtonIcon: Icons.check,
                        secondButtonIcon: Icons.close,
                        secondButtonAction: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icons.category,
                        title: 'Add Category',
                        subtitle: 'Category title',
                        firstButtonLabel: 'Create',
                        firstButtonColor:
                            const Color.fromARGB(255, 39, 236, 22),
                        firstButtonAction: (String title) {
                          addCategoryContainer(title);
                          Navigator.of(context).pop();
                        },
                        secondButtonLabel: 'Cancel',
                        secondButtonColor: Colors.red,
                        firstFieldController: firstFieldController,
                        maxLength: 32,
                        titleBackgroundGradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 251, 255, 26),
                            Color.fromARGB(255, 136, 127, 1),
                          ],
                        ),
                      );
                    },
                  );
                },
                scrollController: scrollController,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
