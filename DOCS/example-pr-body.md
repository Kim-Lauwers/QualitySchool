## Samenvatting
Verbeterde foutafhandeling in `UserService`: inputvalidatie, duidelijke logging, tests.

## Toegevoegde tests
- `findById_null_returns_empty`
- `findById_blank_returns_empty`
- `findById_unknown_returns_empty`
- `findById_known_returns_user`

## Lokale run
```bash
./mvnw -B verify
