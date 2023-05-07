# clean_archi_flutter_app

Mise en place clean architecture dans un projet flutter

## Getting Started

## Step by step

### Structure projet

- Création des dossiers :
- lib/features -> dosser contenant toutes les modules de l'application
- lib/features/number_trivia -> module d'application représentant une fonctionnalité principale
- lib/features/number_trivia/(data, domain, presentation) -> 3 couches de la clean architecture
- lib/core ->
- presentation/bloc ->
- presentation/pages
- presentation/widgets -> widgets que nous ne voulons pas directement dans la page pour éviter l'encombrement de l'UI
- domain/entities ->
- domain/repositories -> Interface (classe abstraite) des repositories
- domain/usecases -> Classe concrète des cas d'utilisation de l'application
- data/datasources ->
- data/models -> Model Data
- data/repositories -> Implémentation concrète des repositories

Domain :
    - Use cases
    - Entities
    - Interface Repositories

Data :
    - Repositories
    - Models
    - DataSources
    - API

Presentation :
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

### Tests

Création de la structure de dossier dans Test/
Création de notre 1er fichier test du 1er use case : get_concrete_number_trivia_test.dart
Création de notre use case pour passer l'érreur de type de notre test
