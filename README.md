<h1 align="center"> Clean Archi Flutter App</h1>

<p align="center">Mise en place clean architecture dans un projet flutter</p>

![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)

## Getting Started

## Step by step

### Structure projet

> Répertoire LIB :

```shell
├── lib
│   ├── core
│   │   ├── error
│   │   │   ├── exceptions.dart
│   │   │   └── failures.dart
│   │   ├── platform
│   │   │   └── network_info.dart
│   │   └── usecases
│   │       └── usecase.dart
│   ├── features
│   │   └── number_trivia
│   │       ├── data
│   │       │   ├── datasources
│   │       │   │   ├── number_trivia_local_datasource.dart
│   │       │   │   └── number_trivia_remote_datasource.dart
│   │       │   ├── models
│   │       │   │   └── number_trivia_model.dart
│   │       │   └── repositories
│   │       │       └── number_trivia_repository_impl.dart
│   │       ├── domain
│   │       │   ├── entities
│   │       │   │   └── number_trivia.dart
│   │       │   ├── repositories
│   │       │   │   └── number_trivia_repository_interface.dart
│   │       │   └── usecases
│   │       │       ├── get_concrete_number_trivia.dart
│   │       │       └── get_random_number_trivia.dart
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

> Répertoire TEST

```shell
├── pubspec.lock
├── pubspec.yaml
├── test
│   ├── core
│   ├── features
│   │   └── number_trivia
│   │       ├── data
│   │       │   ├── models
│   │       │   │   └── number_trivia_model_test.dart
│   │       │   └── repositories
│   │       │       ├── number_trivia_repository_impl_test.dart
│   │       │       └── number_trivia_repository_impl_test.mocks.dart
│   │       ├── domain
│   │       │   └── usecases
│   │       │       ├── get_concrete_number_trivia_test.dart
│   │       │       ├── get_concrete_number_trivia_test.mocks.dart
│   │       │       ├── get_random_number_trivia_test.dart
│   │       │       └── get_random_number_trivia_test.mocks.dart
│   │       └── presentation
│   └── fixtures
│       ├── fixtures_reader.dart
│       ├── trivia.json
│       └── trivia_double.json

```

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

### 🗄️ Data Layer & Models

Création d'un test de model : number_trivia_model_test.dart
Création du model pour faire compiler le test
Le model implémente l'entité
Création d'un dossier fixtures avec un fichier json représentant des données en format json d'un NumberTriviaModel : trivia.json
Création de 2 méthodes dans le model pour convertir [json <-> NumberTriviaModel]

### 📑 Contracts of Data Sources

Création du repository implémentant l'interface `INumberTriviaRepository` dans notre couche data : data/repositories
Création d'une interface de NetworkInfo : core/platform/network_info.dart `INetworkInfo`
Création d'une interface de remoteDataSource : data/datasources/  `INumberTriviaRemoteDataSource`
Création d'une classe abstraite d'exceptions
Création d'une interface de localDataSource : `INumberTriviaLocalDataSource`
Création des membres de NumberTriviaRepository et son constructeur

## Repository Implementation

Création du test d'implémentation du Repository  totalement en TDD
Migration en Null-safety
Refactorisation du code de test et de l'implémentation finale du repository

## NetWork Info

Ajout dépendance :   internet_connection_checker: ^1.0.0+1
TDD : sur l'implémantation de NetworkInfo par l'interface INetworkInfo

## Local Data Source

Création d'un fichier de test pour implémentation LocalDataSource
Nous utilisons pour se faire un petit paquet pour android : SharedPreferences(Android) ou NSUserDefaults(IOS)
Nouvelle fixture car le stockage interne du téléphone utilise un système clé-valeur comme du JSON
Mise en place des tests et implémentation des méthodes de LocalDataSource
Utilisatation de constante pour le SharedPreferences
Utilisation de

```dart
@GenerateNiceMocks(
    [MockSpec<SharedPreferences>(onMissingStub: OnMissingStub.returnDefault)])
```

Qui s'utilise lors de test de méthode non stubées

## Remote Data Source

Sensiblement le même procédé
