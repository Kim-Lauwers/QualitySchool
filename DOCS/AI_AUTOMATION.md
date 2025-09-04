# AI Automatisatie – Maven setup

## Secrets (GitHub → Settings → Secrets → Actions)
- `AI_GITHUB_TOKEN` (scopes: `repo`, `workflow`)
- Optioneel SonarCloud: `SONAR_TOKEN`, `SONAR_ORG`, `SONAR_PROJECT_KEY`

## Policy
- Branch: `ai/auto-pr/<onderwerp>`
- Niet mergen door AI; min. 1 menselijke review; CI moet groen.
- Conventional Commits + PR-template invullen.

## Kwaliteit
- Spotless (Google Java Style)
- Checkstyle (faalt bij overtredingen)
- SpotBugs
- JUnit 5 + Mockito + AssertJ
- JaCoCo rapport

## Voorbeeldprompt (copy/paste voor je AI-agent)
"Lees de repo `<GITHUB_REPO_URL>`. Identificeer technische schuld in module
`src/main/java/com/myorg/service` gericht op foutafhandeling en null-safety.
Maak een nieuwe branch `ai/auto-pr/error-handling-<datum>`, implementeer veilige checks,
voeg JUnit 5 tests toe conform formatting en stijl, run lokaal `./mvnw -B verify`.
Maak een PR met titel `fix(service): verbeter foutafhandeling in UserService` en PR-body met:
(1) korte samenvatting, (2) aangebrachte tests, (3) local run instructies.
Gebruik `AI_GITHUB_TOKEN` uit secrets. Niet mergen."
