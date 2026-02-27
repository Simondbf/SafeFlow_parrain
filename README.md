# SafeFlow Parrain 📱

Application Flutter de gestion du programme de parrainage SafeFlow.

---

## Stack technique

| Technologie | Rôle |
|---|---|
| **Flutter 3** | Framework UI cross-platform |
| **Riverpod 2** | State management (FutureProvider + Provider) |
| **go_router 14** | Navigation déclarative (StatefulShellRoute) |
| **Firebase Auth** | Authentification *(branche feat/auth)* |
| **Cloud Firestore** | Base de données *(branche feat/auth)* |

---

## Lancer le projet

### Prérequis

- Flutter SDK ≥ 3.0.0 ([flutter.dev](https://flutter.dev))
- Dart ≥ 3.0.0
- Chrome installé (pour le web)

### Installation

```bash
git clone https://github.com/Simondbf/SafeFlow_parrain
cd SafeFlow_parrain
flutter pub get
```

### Mobile (Android / iOS)

```bash
flutter run
```

### Navigateur web

```bash
flutter config --enable-web
flutter run -d chrome
```

### Build web (production)

```bash
flutter build web
# Fichiers dans build/web/ — à déposer sur n'importe quel hébergeur
```

---

## Structure du projet

```
lib/
├── core/
│   ├── app_colors.dart          Palette de couleurs centralisée
│   └── app_text_styles.dart     Typographie
├── models/
│   └── filleul_model.dart       Modèle Filleul (fromJson / toJson / copyWith)
├── data/
│   └── repositories/
│       ├── filleul_repository.dart              Interface abstraite
│       ├── mock_filleul_repository_impl.dart    Données locales (dev)
│       └── firebase_filleul_repository.dart     Firestore (prod)
├── providers/
│   └── filleul_provider.dart    Providers Riverpod + FilleulActions
├── navigation/
│   └── app_router.dart          Routeur go_router + navigation adaptative
├── screens/
│   └── dashboard/
│       ├── widgets/
│       │   ├── dashboard_header.dart   Header gradient bleu
│       │   ├── filleul_card.dart       Carte filleul avec statut coloré
│       │   └── skeleton_card.dart      Loader animé pendant le fetch
│       ├── home_screen.dart            Accueil — liste filleuls
│       ├── filleuls_screen.dart        Filleuls — recherche
│       └── parametres_screen.dart      Paramètres — profil
└── main.dart
```

---

## Architecture

Le projet suit le **Repository Pattern** :

```
UI (Screens)
    ↓  ref.watch()
Providers (Riverpod)
    ↓  FilleulRepository
Repository (Mock ou Firebase)
    ↓
Données (local ou Firestore)
```

Pour passer de Mock → Firebase : changer **une seule ligne** dans `filleul_provider.dart` :

```dart
// Développement (actuel)
final filleulRepositoryProvider = Provider<FilleulRepository>(
  (ref) => MockFilleulRepository(),
);

// Production (décommenter au merge feat/auth)
// final filleulRepositoryProvider = Provider<FilleulRepository>(
//   (ref) => FirebaseFilleulRepository(FirebaseFirestore.instance),
// );
```

---

## Navigation

La navigation est **adaptative** :

- **Mobile** → `NavigationBar` en bas (Material 3)
- **Tablette / Desktop** → `NavigationRail` sur la gauche

Basée sur `StatefulShellRoute.indexedStack` de go_router : l'état et le scroll de chaque onglet sont **préservés** lors des changements d'onglet.

---

## Branches Git

| Branche | Contenu |
|---|---|
| `main` | Code stable — navigation + Riverpod + skeleton |
| `feat/auth` | Firebase Auth (Grok) — à merger en 2e |

### Roadmap de merge

```
Étape 1  feat/nav-robustesse → main  (navigation + robustesse)
Étape 2  feat/auth → main            (Firebase Auth)
```

---

## Statuts filleuls

| Statut | Couleur |
|---|---|
| Actif | 🟢 Vert |
| Inactif | 🔴 Rouge |
| En attente | 🟠 Orange |

---

## Firestore Rules

À coller dans la **Firebase Console** au moment du déploiement :

```js
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /filleuls/{id} {
      allow read, write:
        if request.auth.uid == resource.data.parrainId;
    }
  }
}
```

---

## Auteur

**Simon** — [github.com/Simondbf](https://github.com/Simondbf)
