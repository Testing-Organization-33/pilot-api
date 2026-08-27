# pilot-api

Throwaway imitation repo for the DASH release-promotion pilot. Stands in for
`dash-backend-global`: two required CI checks, a migrations directory, and a prod deploy that
reproduces the real repo's **migrate-before-build** ordering hazard.

Not a real service. Nothing here is meant to run.

## Branches

| Branch | Role |
|---|---|
| `development` | Integration. CI runs here. Default branch. |
| `main` | Production. Push triggers Deploy to Prod. Only ever advanced by `pilot-infra`'s Promote workflow, fast-forward only. |
| `deploy-state` | Machine-written. Holds `state.json` = observable "production" state. Never edit by hand. |

## Arming failures

`pilot-config.json` is the toggle. Edit it on `development`, let it promote, and the next run fails
where you asked:

| Field | Values | Effect |
|---|---|---|
| `fail_ci` | `null`, `"unit-tests"`, `"build"` | That CI check goes red — Promote must halt before touching `main`. |
| `fail_deploy` | `null`, `"migrate"`, `"post-migrate-build"`, `"health"` | Deploy fails at that step. |

`post-migrate-build` is the important one: migrations apply, the build then fails, the service never
reloads. `deploy-state/state.json` will show `schema_version` advanced while `deployed_sha` reads
`not-advanced` — old code, new schema, no rollback. That is the hazard live in the real BE repo today.

## Deploy-by-ref

`Deploy to Prod` accepts a `ref` input (commit or tag). The real repos do **not** — theirs is gated
`if: github.ref == 'refs/heads/main'` with a hardcoded `git checkout -f -B "main" "origin/main"`.
Adding this input is the pilot's proposal for the manual-rollback fast lane: redeploy older code
without rewriting `main`.
