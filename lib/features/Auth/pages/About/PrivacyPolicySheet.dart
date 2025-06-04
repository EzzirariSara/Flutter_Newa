import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Auth/widgets/FooterSectionAbout.dart';

void PrivacyPolicySheet(BuildContext context) {
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Politique de confidentialité',
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
                ),

                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 12),
                              Center(
                                child: Text(
                                  "POLITIQUE DE CONFIDENTIALITÉ DE LA PLATEFORME « NEWA »",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),

                              Text(
                                'Sommaire :',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              ListTile(
                                title: Text('1. Données collectées'),
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              ListTile(
                                title: Text('2. Finalité du traitement'),
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              ListTile(
                                title: Text('3. Partage des données'),
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              ListTile(
                                title: Text('4. Conservation des données'),
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              ListTile(
                                title: Text('5. Vos droits'),
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              ListTile(
                                title: Text('6. Cookies'),
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              Divider(),

                              ExpansionTile(
                                title: Text('1. Données collectées'),
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Nous collectons des données personnelles telles que :\n'
                                      '- Nom, prénom\n'
                                      '- Adresse e-mail\n'
                                      '- Numéro de téléphone\n'
                                      '- Informations de paiement\n'
                                      '- Historique d’utilisation de la plateforme\n\n'
                                      'Ces données sont collectées lors de votre inscription, navigation ou utilisation des services NEWA.',
                                    ),
                                  ),
                                ],
                              ),

                              ExpansionTile(
                                title: Text('2. Finalité du traitement'),
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Les données sont utilisées pour :\n'
                                      '- Fournir les services proposés\n'
                                      '- Améliorer l’expérience utilisateur\n'
                                      '- Assurer la sécurité de la plateforme\n'
                                      '- Communiquer avec vous (notifications, email, etc.)\n'
                                      '- Respecter nos obligations légales',
                                    ),
                                  ),
                                ],
                              ),

                              ExpansionTile(
                                title: Text('3. Partage des données'),
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Vos données peuvent être partagées uniquement avec :\n'
                                      '- Nos partenaires techniques (hébergement, paiement)\n'
                                      '- Les autorités compétentes (si obligation légale)\n\n'
                                      'Nous nous assurons que ces tiers respectent des normes strictes de sécurité et confidentialité.',
                                    ),
                                  ),
                                ],
                              ),

                              ExpansionTile(
                                title: Text('4. Conservation des données'),
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Vos données sont conservées :\n'
                                      '- Pendant toute la durée d’utilisation de votre compte\n'
                                      '- Et au maximum 3 ans après la fermeture du compte sauf obligations légales\n\n'
                                      'Elles sont ensuite supprimées ou anonymisées.',
                                    ),
                                  ),
                                ],
                              ),

                              ExpansionTile(
                                title: Text('5. Vos droits'),
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Conformément à la réglementation, vous disposez de droits :\n'
                                      '- D’accès à vos données\n'
                                      '- De rectification\n'
                                      '- De suppression\n'
                                      '- D’opposition\n'
                                      '- De portabilité\n\n'
                                      'Vous pouvez exercer ces droits à tout moment en nous contactant à : contact@newa.ma',
                                    ),
                                  ),
                                ],
                              ),

                              ExpansionTile(
                                title: Text('6. Cookies'),
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Des cookies sont utilisés pour :\n'
                                      '- Analyser le trafic\n'
                                      '- Mémoriser vos préférences\n'
                                      '- Proposer des contenus personnalisés\n\n'
                                      'Vous pouvez à tout moment désactiver les cookies via les paramètres de votre navigateur.',
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 24),
                            ],
                          ),
                        ),
                        const FooterSection(),
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
