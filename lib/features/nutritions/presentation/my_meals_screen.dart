import 'package:flutter/material.dart';
import 'package:fitness_app/features/home/presentation/home_screen.dart';
import 'package:intl/intl.dart';

class MyMealsScreen extends StatefulWidget {
  const MyMealsScreen({super.key});

  @override
  State<MyMealsScreen> createState() => _MyMealsScreenState();
}

class _MyMealsScreenState extends State<MyMealsScreen> {
  final List<String> categories = ['Breakfast', 'Lunch', 'Dinner'];
  String selectedCategory = 'Breakfast';

  late List<DateTime> dateList;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    dateList = List.generate(
      15,
      (index) => DateTime.now().subtract(Duration(days: 7 - index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          },
        ),
        centerTitle: true,
        title: const Text(
          'My Meals',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            /// Real Calendar Date Selector
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dateList.length,
                itemBuilder: (context, index) {
                  final date = dateList[index];
                  final isSelected = date.year == selectedDate.year &&
                      date.month == selectedDate.month &&
                      date.day == selectedDate.day;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.orange : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('E').format(date), // e.g. Mon
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color:
                                    isSelected ? Colors.white : Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              DateFormat('d MMM').format(date), // e.g. 5 Aug
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            /// Category Chips
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: categories.map((cat) {
                final isSelected = cat == selectedCategory;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = cat;
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20),
                      border:
                          isSelected ? Border.all(color: Colors.black12) : null,
                    ),
                    child: Text(
                      cat,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            /// Meals List
            Expanded(
              child: ListView(
                children: const [
                  MealCard(
                    title: "Salad with eggs",
                    kcal: 294,
                    protein: 12,
                    fats: 22,
                    carbs: 42,
                    icon: Icons.egg,
                    borderColor: Colors.orange,
                  ),
                  MealCard(
                    title: "Avocado Dish",
                    kcal: 294,
                    protein: 12,
                    fats: 32,
                    carbs: 12,
                    icon: Icons.food_bank,
                    borderColor: Colors.green,
                  ),
                  MealCard(
                    title: "Pancakes",
                    kcal: 294,
                    protein: 12,
                    fats: 22,
                    carbs: 42,
                    icon: Icons.breakfast_dining,
                    borderColor: Colors.brown,
                  ),
                  MealCard(
                    title: "Slice of Pineapple",
                    kcal: 294,
                    protein: 12,
                    fats: 2,
                    carbs: 35,
                    icon: Icons.local_pizza,
                    borderColor: Colors.pink,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MealCard extends StatelessWidget {
  final String title;
  final int kcal;
  final int protein;
  final int fats;
  final int carbs;
  final IconData icon;
  final Color borderColor;

  const MealCard({
    super.key,
    required this.title,
    required this.kcal,
    required this.protein,
    required this.fats,
    required this.carbs,
    required this.icon,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        // ignore: deprecated_member_use
        border: Border.all(color: borderColor.withOpacity(0.5), width: 1.2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Row
          Row(
            children: [
              Icon(icon, size: 30),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const Icon(Icons.more_horiz),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "$kcal kcal - 100g",
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 12),

          /// Nutrient Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNutrient("Protein", protein, Colors.green),
              _buildNutrient("Fats", fats, Colors.red),
              _buildNutrient("Carbs", carbs, Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutrient(String label, int value, Color color) {
    return Row(
      children: [
        Icon(Icons.circle, size: 10, color: color),
        const SizedBox(width: 4),
        Text("$value", style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
