import 'package:flutter/material.dart';
import 'quantity_input_screen.dart';
import 'package:fitness_app/core/constants/app_images.dart';

class SubCategoryScreen extends StatelessWidget {
  final String category;
  final List<String>?
      images; // For categories with multiple images (like fruits)

  const SubCategoryScreen({
    super.key,
    required this.category,
    this.images,
  });

  // Enhanced to include images and additional details
  List<Map<String, dynamic>> getSubItems(String category) {
    switch (category) {
      case "Fruits":
        return [
          {
            "name": "Banana",
            "image": AppImages.almond, // Add to AppImages
            "calories": "89 kcal",
            "benefits": "Rich in potassium and fiber"
          },
          {
            "name": "Apple",
            "image": AppImages.Apple, // Add to AppImages
            "calories": "52 kcal",
            "benefits": "High in fiber and vitamin C"
          },
          {
            "name": "Mango",
            "image": AppImages.Apple, // Add to AppImages
            "calories": "60 kcal",
            "benefits": "Rich in vitamins A and C"
          },
          // Add more fruits from your AppImages
          {
            "name": "Strawberry",
            "image": AppImages.strawberry,
            "calories": "32 kcal",
            "benefits": "High in antioxidants"
          },
          {
            "name": "Watermelon",
            "image": AppImages.watermelon,
            "calories": "30 kcal",
            "benefits": "Hydrating and rich in lycopene"
          },
        ];
      case "Vegetables":
        return [
          {
            "name": "Carrot",
            "image": AppImages.Apple, // Add to AppImages
            "calories": "41 kcal",
            "benefits": "Excellent source of vitamin A"
          },
          {
            "name": "Broccoli",
            "image": AppImages.Apple, // Add to AppImages
            "calories": "34 kcal",
            "benefits": "High in vitamins C and K"
          },
          {
            "name": "Spinach",
            "image": AppImages.Apple, // Add to AppImages
            "calories": "23 kcal",
            "benefits": "Rich in iron and calcium"
          },
        ];
      case "Meat":
        return [
          {
            "name": "Chicken",
            "image": AppImages.Apple, // Add to AppImages
            "calories": "165 kcal",
            "benefits": "High-quality protein source"
          },
          {
            "name": "Beef",
            "image": AppImages.Apple, // Add to AppImages
            "calories": "250 kcal",
            "benefits": "Rich in iron and B vitamins"
          },
          {
            "name": "Mutton",
            "image": AppImages.Apple, // Add to AppImages
            "calories": "294 kcal",
            "benefits": "Good source of protein and zinc"
          },
        ];
      case "Vegetarian":
        return [
          {
            "name": "Tofu",
            "image": AppImages.Apple, // Add to AppImages
            "calories": "76 kcal",
            "benefits": "Plant-based protein source"
          },
          {
            "name": "Paneer",
            "image": AppImages.Apple, // Add to AppImages
            "calories": "265 kcal",
            "benefits": "Rich in calcium and protein"
          },
          {
            "name": "Lentils",
            "image": AppImages.Apple, // Add to AppImages
            "calories": "116 kcal",
            "benefits": "High in fiber and protein"
          },
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final subItems = getSubItems(category);

    return Scaffold(
      appBar: AppBar(
        title: Text("$category Items"),
        backgroundColor: Colors.orange.shade700,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: subItems.length,
        itemBuilder: (context, index) {
          final item = subItems[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(item['image']),
                backgroundColor: Colors.transparent,
              ),
              title: Text(
                item['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    item['calories'],
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    item['benefits'],
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuantityInputScreen(
                      item: item['name'],
                      image: item['image'],
                      calories: item['calories'],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
