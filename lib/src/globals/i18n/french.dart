/**
 * @organization: UATM GASA Formation - https://uatm-gasa.com
 * @framework: Flutter - https://www.flutter.dev
 * @author: Obrymec - https://obrymec.vercel.app
 * @fileoverview: Texts translated into french.
 * @supported: ANDROID & IOS
 * @created: 2026-01-12
 * @updated: 2026-03-23
 * @file: french.dart
 * @version: 0.0.3
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
    "noLinkFound": "Le lien API n'est pas fournit dans les paramètres.",
    "uploadSuccessMessage": "Votre image a été envoyée sans problème.",
    "quitMessage": "Souhaitez-vous vraiment quitter l’application ?",
    "settingsSaveSuccess": "Paramètres sauvegardés avec succès!",
    "tutorialTitle": "Scan d’une plaque d’immatriculation",
    "copyright": "Copyright© 2026 – 2027 GASA Formation",
    "appVersion": "version v0.4.0 • build 18",
    "loadErrorTitle": "Erreur de chargement",
    "selectImage": "Sélectionner une image",
    "uploadSuccessTitle": "Envoye réussi",
    "uploadErrorTitle": "Envoie échoué",
    "startCamera": "Démarrer la caméra",
    "progressing": "Envoie en cours",
    "loadImage": "Charger une image",
    "anotherImage": "Une autre",
    "settings": "Paramètres",
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
    "loadErrorMessage": (
      "Assurez-vous que l'image n'est pas corrompu ou endommagée."
    ),
    "settingsMessage": (
      "Fournissez le lien API à contacter pour "
      "le transfert les images récupérées."
    ),
    "tutorialMessage": (
      "Faites en sorte que l'on puisse voire sur votre photo, "
      "le véhicule accompagné de sa plaque d'immatriculation "
      "et assurez-vous d’avoir une image la plus nette que "
      "possible."
    ),
    "uploadErrorMessage": "<div>"
      "<span>Vérifiez votre réseau et assurez-vous d'avoir une "
      "connexion internet stable puis réessayer à nouveau."
      "</span><br/><br/><details><summary>Plus de détails"
      "</summary><br/><span>{details}</span></details>"
    "</div>"
  }
);
