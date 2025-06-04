import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Auth/widgets/FooterSectionAbout.dart';

void TermsAndConditionsSheet(BuildContext context) {
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
                              'Conditions générales d\'utilisation',
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
                        Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      SizedBox(height: 12),
      Center(
        child: Text(
          "CONDITIONS GENERALES D’UTILISATION / CONDITIONS GENERALES DE VENTE DE LA PLATEFORME « NEWA »",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(height: 12),
      Text(
        'CONDITIONS GENERALES DE MISE A DISPOSITION :',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
      SizedBox(height: 12),
      Text(
        'Préambule  :',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
      SizedBox(height: 12),
      Text(
        'La société NEWA SA, société anonyme à conseil d’administration, au capital de 70.000.000,00 dirhams, dont le siège social est à Casablanca, Centre Commercial Marjane CT 1029 Ain Chock, inscrite au registre du commerce de Casablanca sous le n° 500453, ayant l’ICE n° 002706798000037, (ci-après « NEWA » ou « nous » ou « notre »)...',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
      SizedBox(height: 12),
      Text(
        'Sommaire :',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
      ListTile(
        title: Text('1. Respect des lois'),
        dense: true,
        contentPadding: EdgeInsets.zero,
      ),
      ListTile(
        title: Text('2. Sécurité et confidentialité'),
        dense: true,
        contentPadding: EdgeInsets.zero,
      ),
      ListTile(
        title: Text('3. Modifications des conditions'),
        dense: true,
        contentPadding: EdgeInsets.zero,
      ),
      ListTile(
        title: Text('4. Propriété intellectuelle'),
        dense: true,
        contentPadding: EdgeInsets.zero,
      ),
      ListTile(
        title: Text('5. Responsabilités'),
        dense: true,
        contentPadding: EdgeInsets.zero,
      ),
      ListTile(
        title: Text('6. Modalités de paiement'),
        dense: true,
        contentPadding: EdgeInsets.zero,
      ),
      ListTile(
        title: Text('7. Résiliation de compte'),
        dense: true,
        contentPadding: EdgeInsets.zero,
      ),

      Divider(),

      ExpansionTile(
        title: Text('1. Respect des lois'),
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Vous acceptez d\'utiliser la plateforme NEWA dans le strict respect des lois et réglementations en vigueur. Il est strictement interdit d\'utiliser les services à des fins illégales, frauduleuses ou non autorisées.\n\n'
              'Vous vous engagez notamment à :\n'
              '- Ne pas diffuser de contenus illicites ou contraires à l’ordre public.\n'
              '- Ne pas porter atteinte aux droits de tiers (droits d’auteur, vie privée, etc.).\n'
              '- Ne pas tenter d’accéder de manière non autorisée à d’autres systèmes ou comptes.\n'
              '- Respecter les lois relatives à la protection des données personnelles.\n\n'
              'Tout manquement pourra entraîner la suspension ou la suppression définitive de votre compte, sans préavis.',
            ),
          ),
        ],
      ),

      ExpansionTile(
        title: Text('2. Sécurité et confidentialité'),
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'La sécurité de vos données est une priorité pour NEWA. Nous mettons en œuvre des technologies de chiffrement et des systèmes de surveillance afin de garantir la confidentialité, l’intégrité et la disponibilité de vos données.\n\n'
              'À ce titre, vous vous engagez à :\n'
              '- Garder vos identifiants de connexion confidentiels.\n'
              '- Ne pas partager votre compte avec un tiers.\n'
              '- Signaler immédiatement toute activité suspecte ou accès non autorisé.\n\n'
              'NEWA s’engage à :\n'
              '- Ne jamais vendre vos données personnelles.\n'
              '- Respecter la réglementation en vigueur sur la protection des données (ex : RGPD).\n'
              '- Vous permettre de modifier ou supprimer vos données sur simple demande.',
            ),
          ),
        ],
      ),

      ExpansionTile(
        title: Text('3. Modifications des conditions'),
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'NEWA se réserve le droit de modifier à tout moment les présentes Conditions Générales d’Utilisation (CGU) ou Conditions Générales de Vente (CGV), notamment pour se conformer aux évolutions légales, réglementaires ou techniques.\n\n'
              'En cas de modification :\n'
              '- Vous serez notifié via l’application ou par email.\n'
              '- Vous disposerez d’un délai raisonnable pour prendre connaissance des nouvelles conditions.\n'
              '- Votre utilisation continue de la plateforme vaudra acceptation des conditions modifiées.\n\n'
              'Si vous n’acceptez pas les nouvelles conditions, vous pouvez résilier votre compte sans pénalité.',
            ),
          ),
        ],
      ),

      ExpansionTile(
        title: Text('4. Propriété intellectuelle'),
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Tous les éléments présents sur la plateforme NEWA (textes, logos, images, interfaces, codes sources, etc.) sont protégés par les lois relatives à la propriété intellectuelle.\n\n'
              'Toute reproduction, distribution, ou utilisation non autorisée de ces éléments est strictement interdite sans l’accord écrit préalable de NEWA.\n'
              'L’utilisateur reconnaît que l’usage de la plateforme ne lui confère aucun droit de propriété sur ses contenus.',
            ),
          ),
        ],
      ),

      ExpansionTile(
        title: Text('5. Responsabilités'),
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'NEWA s’efforce de fournir un service fiable et sécurisé. Toutefois, la responsabilité de NEWA ne saurait être engagée en cas :\n\n'
              '- D’interruption temporaire du service (maintenance, panne réseau, etc.).\n'
              '- D’utilisation inappropriée ou frauduleuse de la plateforme.\n'
              '- De force majeure (catastrophes naturelles, actes gouvernementaux, etc.).\n\n'
              'L’utilisateur est responsable de l’exactitude des informations fournies et de l’usage qu’il fait de la plateforme.',
            ),
          ),
        ],
      ),

      ExpansionTile(
        title: Text('6. Modalités de paiement'),
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Les paiements effectués sur la plateforme sont sécurisés via des partenaires de paiement certifiés. Les moyens de paiement acceptés incluent : carte bancaire, portefeuille mobile et virements.\n\n'
              'Toute commande est considérée comme ferme et définitive une fois le paiement validé.\n'
              'En cas d’échec de paiement, la commande peut être suspendue ou annulée.\n\n'
              'L’utilisateur recevra un reçu ou une facture électronique pour chaque transaction.',
            ),
          ),
        ],
      ),

      ExpansionTile(
        title: Text('7. Résiliation de compte'),
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Vous pouvez résilier votre compte NEWA à tout moment via les paramètres de votre profil.\n\n'
              'NEWA se réserve également le droit de suspendre ou supprimer un compte en cas de :\n'
              '- Violation des CGU/CGV,\n'
              '- Activité frauduleuse,\n'
              '- Inactivité prolongée.\n\n'
              'La suppression d’un compte entraîne la perte définitive de toutes les données liées, sauf obligations légales de conservation.',
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
