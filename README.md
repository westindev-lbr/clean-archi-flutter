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
