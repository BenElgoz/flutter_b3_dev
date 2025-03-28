# 📱 App B3 MDS – Projet Flutter

Application Flutter développée dans le cadre du module d'application mobile.  
Elle propose une navigation simple entre plusieurs pages, un formulaire de contact, la consultation d’articles via une API, un thème clair/sombre, et une structure MVC propre.

---

## ✨ Fonctionnalités

- 🧭 **Navigation Drawer** entre plusieurs pages :
  - Accueil
  - Seconde page
  - À propos
  - Contact
  - Articles

- 🎨 **Thème clair / sombre** (switch dans le menu)

- 📄 **Formulaire de contact** avec :
  - Validation des champs
  - Envoi via client mail (`mailto:` avec `url_launcher`)

- 🌐 **Consommation d’une API publique** :
  - Liste d’articles depuis `https://jsonplaceholder.typicode.com/posts`
  - Affichage paginé (10 articles par page)
  - Détails d’un article

---

## 🧱 Structure du projet

```
lib/
├── main.dart                  # Point d'entrée de l'application
├── controllers/
│   └── theme_controller.dart # Gestion du thème clair/sombre
├── models/
│   └── article.dart           # Modèle Article
├── views/
│   ├── home_page.dart
│   ├── second_page.dart
│   ├── about_page.dart
│   ├── contact_page.dart
│   ├── articles_page.dart
│   └── article_detail_page.dart
└── widgets/
    └── app_scaffold.dart      # Scaffold commun avec Drawer
```

---

## 🧪 Dépendances

Assure-toi d’avoir ces packages dans ton `pubspec.yaml` :

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1
  shared_preferences: ^2.2.2
  url_launcher: ^6.2.5
  http: ^0.13.6
```

Installe-les avec :

```bash
flutter pub get
```

---

## ▶️ Lancer le projet

```bash
flutter run
```
