# Le Tournoi

> La plateforme des tournois de foot amateur — clubs, équipes, sponsors au même endroit.

## Démo en ligne

[letournoi.foot](#) (à mettre à jour après déploiement)

## Stack technique

- **Frontend** : HTML / CSS / JavaScript vanilla (zero framework)
- **Base de données** : [Supabase](https://supabase.com) (PostgreSQL hébergé)
- **Hébergement** : [GitHub Pages](https://pages.github.com)
- **Typographie** : Fraunces + Inter + JetBrains Mono

## Comptes de démonstration

Mot de passe : `demo`

**Clubs**
- `demo@letournoi.foot` — FC Belleville
- `pantin@letournoi.foot` — AS Pantin
- `montreuil@letournoi.foot` — US Montreuil

**Équipes**
- `aulnay@letournoi.foot` — CSL Aulnay U15 (11 joueurs préchargés)
- `suresnes@letournoi.foot` — JS Suresnes U13

**Sponsors**
- `auto@letournoi.foot` — Garage Belleville Auto
- `naima@letournoi.foot` — Boulangerie Naïma
- `intermarche@letournoi.foot` — Intermarché Pantin

## Fonctionnalités du MVP

- Trois types de comptes (club / équipe / sponsor)
- Création et gestion de tournois
- Inscription d'équipes avec workflow d'approbation
- Propositions de sponsoring avec paliers Or/Argent/Bronze
- Calendrier dynamique avec ajout/édition de matchs
- Génération automatique de bracket
- Catalogue d'animations
- Mode démo (localStorage) + mode inscription réelle (Supabase)

## Configuration

Avant de déployer, remplacer dans `index.html` les valeurs suivantes :

```javascript
const SUPABASE_URL = 'https://YOUR_PROJECT_ID.supabase.co';
const SUPABASE_ANON_KEY = 'YOUR_ANON_PUBLIC_KEY';
```

Par les vraies valeurs récupérées dans Supabase Dashboard → Settings → API.

## Déploiement

GitHub Pages déploie automatiquement à chaque push sur `main`.
Délai de mise à jour : ~1 minute après le push.

## Statut du projet

🚧 MVP en validation — démarchage des premiers clubs en cours.
