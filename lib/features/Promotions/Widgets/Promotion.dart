class Promotion {
  final String productName;
  final String imagePath;
  final double originalPrice;
  final double discountedPrice;
  final int discountPercentage;
  final String description;
  final String brand;
  final String category; 

  Promotion({
    required this.productName,
    required this.imagePath,
    required this.originalPrice,
    required this.discountedPrice,
    required this.discountPercentage,
    required this.description,
    required this.brand,
    required this.category, 
  });
}

List<Promotion> demoPromotions = [
  Promotion(
    productName: "PAYOT Crème",
    imagePath: "assets/Products/Product4.png",
    originalPrice: 35.0,
    discountedPrice: 24.5,
    discountPercentage: 30,
    description: "Crème hydratante et nourrissante pour le visage",
    brand: "PAYOT",
    category: "Anti-âge",
  ),
  Promotion(
    productName: "ANIAN Lotion",
    imagePath: "assets/Products/Product5.png",
    originalPrice: 15.0,
    discountedPrice: 12.0,
    discountPercentage: 20,
    description: "Lotion corporelle pour peau sensible",
    brand: "ANIAN",
    category: "Compléments",
  ),Promotion(
    productName: "PAYOT Crème",
    imagePath: "assets/Products/Product6.png",
    originalPrice: 35.0,
    discountedPrice: 24.5,
    discountPercentage: 30,
    description: "Crème hydratante et nourrissante pour le visage",
    brand: "PAYOT",
    category: "Anti-âge",
  ),
  Promotion(
    productName: "ANIAN Lotion",
    imagePath: "assets/Products/Product7.png",
    originalPrice: 15.0,
    discountedPrice: 12.0,
    discountPercentage: 20,
    description: "Lotion corporelle pour peau sensible",
    brand: "ANIAN",
    category: "Compléments",
  ),
  Promotion(
    productName: "CERAVE Hydratant",
    imagePath: "assets/Products/Product2.png",
    originalPrice: 25.0,
    discountedPrice: 18.75,
    discountPercentage: 25,
    description: "Crème hydratante pour peau sèche à très sèche",
    brand: "CERAVE",
    category: "Hydratants",
  ),
  Promotion(
    productName: "DOLOGEL Gel Apaisant",
    imagePath: "assets/Products/Product1.png",
    originalPrice: 30.0,
    discountedPrice: 21.0,
    discountPercentage: 30,
    description: "Gel apaisant pour soulager les douleurs",
    brand: "DOLOGEL",
    category: "Soins visage",
  ),
  Promotion(
    productName: "PHYSIODOSE Solution",
    imagePath: "assets/Products/Product3.png",
    originalPrice: 20.0,
    discountedPrice: 16.0,
    discountPercentage: 20,
    description: "Solution physiologique pour nettoyage nasal et oculaire",
    brand: "PHYSIODOSE",
    category: "Nettoyants",
  ),
  
];