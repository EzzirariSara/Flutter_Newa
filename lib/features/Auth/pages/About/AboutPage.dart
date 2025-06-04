import 'package:flutter/material.dart';

void showAboutModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent, 
    builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.8,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'À propos de nous',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Center(
                          child: Image(
                            image: AssetImage('assets/LogoNewa/Logo NEWA N.png'),
                            height: 100,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Bienvenue sur NEWA, la Marketplace marocaine de confiance qui vous connecte aux meilleures marques et aux meilleurs produits, pour une expérience d’achat unique et équitable.',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'NEWA est votre destination incontournable pour tous les produits cosmétiques : maquillage, soins de la peau, soins capillaires, parfums, hygiène, produits naturels, et bien plus encore. Retrouvez toutes les grandes marques nationales et internationales à portée de clic.',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Mais NEWA ne s’arrête pas là : la plateforme propose également des milliers d’articles dans toutes les catégories, notamment la mode, l’électronique, la maison et décoration, les jouets, les produits bébé, le sport, l’alimentation, et les accessoires.',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Grâce à ses offres exclusives, ses promotions régulières, ses opérations saisonnières comme le Black Friday, les soldes et les fêtes, NEWA vous permet de faire vos achats intelligemment et en toute sécurité.',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Commandez facilement depuis chez vous et profitez de la livraison partout au Maroc, du paiement à la livraison ou en ligne en dirham convertible, et d’un service client à votre écoute.',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Avec NEWA, explorez une marketplace moderne, innovante, inclusive et 100% marocaine, pensée pour répondre à tous vos besoins.',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
