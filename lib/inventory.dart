library my_inventory_package;

import 'package:flutter/material.dart';
import 'cos_container.dart';
import 'custom_dialog.dart';
import 'package:net_store/net_store.dart';


class Inva extends StatefulWidget {
  final IconData firstButtonIcon;
  final String firstButtonText;
  final IconData secButtonIcon;
  final String secButtonText;

  const Inva({
    super.key,
    required this.firstButtonIcon,
    required this.firstButtonText,
    required this.secButtonIcon,
    required this.secButtonText,
  });

  @override
  _InvaState createState() => _InvaState();
}

class _InvaState extends State<Inva> {
  final List<Widget> containers = [];
  int _totalItems = 0;

  void addCategoryContainer(String title) {
    if (title.isNotEmpty) {
      setState(() {
        containers.add(buildCategoryContainer(title));
        _totalItems++;
      });
    }
  }

  void _addProductContainer(String title, String price) {
    if (title.isNotEmpty && price.isNotEmpty) {
      setState(() {
        containers.add(buildProductContainer(title, price));
        _totalItems++;
      });
    }
  }

  Widget buildCategoryContainer(String title) {
    return Column(
      children: [
        CosContainer(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.category),
                  const SizedBox(width: 6),
                  Text(title, style: const TextStyle(fontSize: 18)),
                ],
              ),
              const Icon(Icons.more_vert)
            ],
          ),
        ),
        const SizedBox(height: 2),
      ],
    );
  }

  Widget buildProductContainer(String title, String price) {
    return Column(
      children: [GestureDetector(
        onTap: () {
          // Navigate to the new page here
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NetStore.editProduct(), 
            ),
          );
        },
       child:  CosContainer(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.add_box, size: 30),
              const SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 18)),
                  Text('₹$price', style: const TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.arrow_back),
            const SizedBox(width: 3),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Inventory', style: TextStyle(fontSize: 13)),
                Text('Total items: $_totalItems',
                    style: const TextStyle(fontSize: 8, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: containers.length,
              itemBuilder: (context, index) {
                return containers[index];
              },
            ),
          ),
          Container(
            color: const Color.fromARGB(0, 255, 193, 7),
            height: 55,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
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
                    child: Container(
                      height: 55,
                      color: const Color.fromARGB(0, 255, 255, 255),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(widget.firstButtonIcon),
                          Text(
                            widget.firstButtonText,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
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
                    child: Container(
                      height: 55,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 45, 255, 26),
                            Color.fromARGB(255, 1, 136, 57),
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            widget.secButtonIcon,
                            color: Colors.white,
                          ),
                          Text(
                            widget.secButtonText,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
