import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home/pages/BrandsPage.dart';
import 'package:flutter_application_1/features/home/widgets/BannerAd.dart';
import 'package:flutter_application_1/features/home/widgets/HomeHeader.dart';
import 'package:flutter_application_1/features/home/pages/ProductsPage.dart';
import 'package:flutter_application_1/model/Products.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> newItems = [
      const Product(
        imagePath: 'assets/Products/Product4.png',
        productName: 'ALPHANOM ZEROP',
        price: '17,00',
        type: 'Shampoo',
      ),
      const Product(
        imagePath: 'assets/Products/Product5.png',
        productName: 'Pomegranate Shampoo',
        price: '20,00',
        type: 'Shampoo',
      ),
      const Product(
        imagePath: 'assets/Products/Product6.png',
        productName: 'EUBOS Shampoo',
        price: '100,00',
        type: 'Shampoo',
      ),
      const Product(
        imagePath: 'assets/Products/Product7.png',
        productName: 'EUBOS Shampoo',
        price: '100,00',
        type: 'Shampoo',
      ),
      const Product(
        imagePath: 'assets/Products/Product1.png',
        productName: 'ALPHANOM ZEROP',
        price: '17,00',
        type: 'Shampoo',
      ),
      const Product(
        imagePath: 'assets/Products/Product2.png',
        productName: 'Pomegranate Shampoo',
        price: '20,00',
        type: 'Shampoo',
      ),
      const Product(
        imagePath: 'assets/Products/Product3.png',
        productName: 'EUBOS Shampoo',
        price: '100,00',
        type: 'Shampoo',
      ),
    ];

    final List<Product> specialOffers = [
      const Product(
        imagePath: 'assets/Products/Product4.png',
        productName: 'ALPHANOM ZEROP',
        price: '17,00',
        type: 'Shampoo',
      ),
      const Product(
        imagePath: 'assets/Products/Product5.png',
        productName: 'Pomegranate Shampoo',
        price: '20,00',
        type: 'Shampoo',
      ),
      const Product(
        imagePath: 'assets/Products/Product6.png',
        productName: 'EUBOS Shampoo',
        price: '100,00',
        type: 'Shampoo',
      ),
      const Product(
        imagePath: 'assets/Products/Product7.png',
        productName: 'EUBOS Shampoo',
        price: '100,00',
        type: 'Shampoo',
      ),
      const Product(
        imagePath: 'assets/Products/Product2.png',
        productName: 'Pomegranate Special',
        price: '18,00',
        type: 'Shampoo',
      ),
      const Product(
        imagePath: 'assets/Products/Product3.png',
        productName: 'EUBOS Premium',
        price: '90,00',
        type: 'Shampoo',
      ),
      const Product(
        imagePath: 'assets/Products/Product1.png',
        productName: 'ALPHANOM Plus',
        price: '15,00',
        type: 'Shampoo',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              const HomeHeader(),
              const SizedBox(height: 20),
              const BannerAd(
                imagePaths: [
                  'assets/bannieres/bannierEucerin.png',
                  'assets/bannieres/bannierUriage.png',
                  'assets/bannieres/bannierCetaphil.png',
                  'assets/bannieres/bannierDeal.png',
                  'assets/bannieres/bannierBioderma.png',
                ],
              ),
              Productspage(title: 'Nouveaux articles', products: newItems),
              const SizedBox(height: 20),
              const BannerAd(
                imagePaths: [
                  'assets/bannieres/bannierEucerin.png',
                  'assets/bannieres/bannierUriage.png',
                  'assets/bannieres/bannierCetaphil.png',
                  'assets/bannieres/bannierDeal.png',
                  'assets/bannieres/bannierBioderma.png',
                ],
              ),
              Productspage(title: 'Promotions spéciales',products: specialOffers,),
              const SizedBox(height: 20),
              const BrandsPage(),
            ],
          ),
        ),
      ),
    );
  }
}
