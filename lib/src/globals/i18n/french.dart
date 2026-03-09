/**
 * @organization: UATM GASA Formation - https://uatm-gasa.com
 * @framework: Flutter - https://www.flutter.dev
 * @author: Obrymec - https://obrymec.vercel.app
 * @fileoverview: Texts translated into french.
 * @supported: ANDROID & IOS
 * @created: 2026-01-12
 * @updated: 2026-03-09
 * @file: french.dart
 * @version: 0.0.2
 */

/// Custom dependencies.
library;
import "../models/language.dart";

/// French language.
final Language french = Language(
  keywords: <String>["french", "france", "fr"],
  name: "Français",
  flagCode: "FR",
  data: <String, String>{
    "uploadSuccessMessage": "Votre image a été envoyée sans problème.",
    "quitMessage": "Souhaitez-vous vraiment quitter l’application ?",
    "settingsSaveSuccess": "Paramètres sauvegardés avec succès !",
    "noChangeDetected": "Aucune modification n'a été effectuée.",
    "tutorialTitle": "Scan d’une plaque d’immatriculation",
    "copyright": "Copyright© 2026 – 2027 GASA Formation",
    "retrieveErrorTitle": "Erreur de récupération",
    "appVersion": "version v0.3.0 • build 17",
    "loadErrorTitle": "Erreur de chargement",
    "selectImage": "Sélectionner une image",
    "resolution": "412pixels x 2000pixels",
    "uploadSuccessTitle": "Envoye réussi",
    "uploadErrorTitle": "Envoye échoué",
    "startCamera": "Démarrer la caméra",
    "progressing": "Envoye en cours…",
    "loadImage": "Charger une image",
    "sandboxMode": "Mode sandbox",
    "description": "Description",
    "timeValue": "23h:09min:44s",
    "anotherImage": "Une autre",
    "dateValue": "25/04/2024",
    "weightValue": "1.95 MB",
    "settings": "Paramètres",
    "progressPercent": "0%",
    "transfer": "Transfert",
    "sendImage": "Envoyer",
    "apiLink": "Lien API",
    "save": "Sauvegarder",
    "retry": "Réessayer",
    "cancel": "Annuler",
    "weight": "Taille",
    "appName": "RAPI",
    "home": "Accueil",
    "quit": "Quitter",
    "time": "Temps",
    "date": "Date",
    "ok": "OK",
    "noPlatenumber": (
      "Aucune voiture ou véhicule n'a été trouvé(e) sur cette photo."
    ),
    "loadErrorMessage": (
      "Assurez-vous que l'image n'est pas corrompu ou endommagée."
    ),
    "retrieveErrorMessage": (
      "Impossible de récupérer et de traiter correctement "
      "les réponses émises du serveur."
    ),
    "uploadErrorMessage": (
      "Vérifiez votre réseau et assurez-vous d'avoir une "
      "connexion internet stable puis réessayer à nouveau."
    ),
    "settingsMessage": (
      "Fournissez le lien API à contacter pour "
      "le transfert les images récupérées."
    ),
    "noPlateFound": (
      "Désolé! Aucune plaque d'immatriculation "
      "n'a été trouvée sur cette image."
    ),
    "tutorialMessage": (
      "Faites en sorte que l'on puisse voire sur votre photo, le véhicule "
      "accompagné de sa plaque d'immatriculation et assurez-vous d’avoir "
      "une image la plus nette que possible."
    )
  }
);
