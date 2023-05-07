<h1 align="center"> Clean Archi Flutter App</h1>

<p align="center">Mise en place clean architecture dans un projet flutter</p>

![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)

## Getting Started

## Step by step

### Structure projet

```shell
├── lib
│   ├── core
│   │   └── error
│   │       └── failures.dart
│   ├── features
│   │   └── number_trivia
│   │       ├── data
│   │       │   ├── datasources
│   │       │   ├── models
│   │       │   └── repositories
│   │       ├── domain
│   │       │   ├── entities
│   │       │   │   └── number_trivia.dart
│   │       │   ├── repositories
│   │       │   │   └── number_trivia_repository_interface.dart
│   │       │   └── usecases
│   │       │       └── get_concrete_number_trivia.dart
│   │       └── presentation
│   │           ├── bloc
│   │           ├── pages
│   │           └── widgets
│   └── main.dart
```

- *lib/features -> dosser contenant toutes les modules de l'application*
- *lib/features/number_trivia -> module d'application représentant une fonctionnalité principale*
- *lib/features/number_trivia/(data, domain, presentation) -> 3 couches de la clean architecture*
- *presentation/widgets -> widgets que nous ne voulons pas directement dans la page pour éviter l'encombrement de l'UI*
- *domain/entities ->*
- *domain/repositories -> Interface (classe abstraite) des repositories*
- *domain/usecases -> Classe concrète des cas d'utilisation de l'application*
- *data/repositories -> Implémentation concrète des repositories*

- Domain :
  - Use cases
  - Entities
  - Interface Repositories

- Data :
  - Repositories
  - Models
  - DataSources
  - API

- Presentation :
  - Widgets
  - Presentation Logic

### Installation des dépendances

- Service Locator : get_it: ^7.4.1
- Bloc for state management : flutter_bloc: ^8.1.2
- Value equality : equatable: ^2.0.5
- Functionnal programming thingies : dartz: ^0.10.1
- Remote API : connectivity: ^3.0.6 , http: ^0.13.6
- Local cache : shared_preferences: ^2.1.0
- Test : mockito

### Entities & Use Cases

Création de la première entité : NumberTrivia
Création de notre gestion d'erreur en cas d'exception levée
    - core/error/failures.dart -> classe Failure abstraite un peu comme ActionResponse de façon générique
Création de notre interface Repository : INumberTriviaRepository dans le domain layer

### 🧪 Tests

Création de la structure de dossier dans Test/
Création de notre 1er fichier test du 1er use case : get_concrete_number_trivia_test.dart
Création de notre use case pour passer l'érreur de type de notre test

### ❂ Domain Layer Refactoring

Création d'une interface de usecase avec la méthode call : core/usecases/usecase.dart
Création d'une classe Params pour utiliser des paramètres génériques en overridant la classe
Refactorisation du test avec la classe Params

Création d'un 2e fichier de test pour le use case : get_random_number_trivia_test.dart
Création du use case  : GetRandomNumberTrivia avec classe NoParams
