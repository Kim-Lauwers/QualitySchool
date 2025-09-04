# Cloud-AI Java Starter (Maven)

[![CI](https://github.com/Kim-Lauwers/QualitySchool/actions/workflows/ci.yml/badge.svg)](https://github.com/Kim-Lauwers/QualitySchool/actions/workflows/ci.yml)

Moderne Java 21 starter met Maven, tests en CI. Klaar voor AI-gestuurde PR’s.

## Vereisten
- Java 21
- GitHub repository met Secrets:
  - `AI_GITHUB_TOKEN` (scopes: `repo`, `workflow`)
  - Optioneel: `SONAR_TOKEN`, `SONAR_ORG`, `SONAR_PROJECT_KEY`

## Build & Test
```bash
mvn -B verify     # format check (Spotless), Checkstyle, SpotBugs, tests, Jacoco
