/**
 * @organization: UATM GASA Formation - https://uatm-gasa.com
 * @framework: Flutter - https://www.flutter.dev
 * @author: Obrymec - https://obrymec.vercel.app
 * @fileoverview: Texts translated into french.
 * @supported: ANDROID & IOS
 * @created: 2026-01-12
 * @updated: 2026-01-12
 * @file: french.dart
 * @version: 0.0.1
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
    "quitMsg": "Voulez-vous vraiment quitter l'application maintenant ?",
    "bluetoothUnexpectedDisconnectionTitle": "Connexion rompue",
    "establishBluetooth": "Se connecter au fauteuil roulant",
    "breakBluetooth": "Se déconnecter du fauteuil roulant",
    "bluetoothConnectionFailedTitle": "Connexion échouée",
    "noResultsFound": "Aucun résultat(s) trouvé(s)",
    "bluetooth": "Bluetooth du fauteuil roulant",
    "ongoingTreatment": "Traitement en cours",
    "scanFailedTitle": "Erreur de scannage",
    "gasaFormation": "UATM GASA-Formation",
    "scanProcessing": "Scannage en cours",
    "appInfo": "version 0.0.4 - build 04",
    "devicesList": "Liste des appareils",
    "unknownDevice": "Appareil inconnu",
    "disconnected": "Non connecté",
    "developedBy": "Développé par",
    "queryTitle": "Interrogation",
    "reconnect": "Se reconnecter",
    "appName": "GASA Wheelchair",
    "connected": "Connecté",
    "refresh": "Rafraichir",
    "search": "Rechercher",
    "validate": "Valider",
    "retry": "Reéssayer",
    "cancel": "Annuler",
    "status": "Status",
    "speed": "VITESSE",
    "quit": "Quitter",
    "back": "Retour",
    "jack": "VERIN",
    "yes": "OUI",
    "no": "NON",
    "bluetoothDisconnectErrMsg": (
      "Impossible de se déconnecter de ce appareil. La nature de l'erreur "
      "est inconnu."
    ),
    "bluetoothDisconnectReqMsg": """<div style = "text-align:center;">
      Voulez-vous vraiment vous déconnecter de l'appareil <b>{name}</b>
      avec l'adresse <b>{address}</b> ?"
    </div>""",
    "connectionMsg": """<div style = "text-align:center;">
      Souhaitez-vous vraiment vous connecter à l'appareil <b>{name}</b>
      avec l'adresse <b>{address}</b> ?
    </div>""",
    "connectionEstablished": (
      "✅ Connexion Bluetooth établie avec succès sur <b><i>{name}</i></b>: "
      "<b><i>{address}</i></b>!"
    ),
    "bluetoothOffMsg": (
      "Le bluetooth de votre portable n'est pas activé. Veuillez "
      "l'activer s'il vous plait puis reéssayez à nouveau."
    ),
    "scanFailedMsg": """<div style = "text-align:center;">
      Une erreur s'est produite lors du scannage des appareils 
      ayant leur Bluetooth actif et se trouvant à proximité. 
      <i><b>Code erreur: {error}</b></i>
    </div>""",
    "bluetoothConnectionMsg": (
      "Vérifiez l'état du bluetooth de votre portable ainsi que celui "
      "de votre dispositif et assurez-vous d'être à une distance de "
      "moins de 10 mètres de votre engin."
    ),
    "screenHelpMsg": (
      "ℹ️ Connectez-vous au Bluetooth du fauteuil roulant en "
      "appuyant sur le bouton <b><i>Se connecter au fauteuil "
      "roulant</b></i> en bas de l'application."
    )
  }
);
