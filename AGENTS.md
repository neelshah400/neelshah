# Repository Rules

- This is a [Vite+](https://viteplus.dev/) monorepo. See [README.md](./README.md).
- Use `vp run` for running commands, as described in the Vite+ section below. Note that this monorepo uses other tools as well, so prefer the `:full` variants when applicable.
- Use [Jujutsu](https://www.jj-vcs.dev/latest/) for version control (`jj`).
  - Commit messages must follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification.
  - **CRITICAL:** When pushing commits to a remote...
    - _Don't_ use `jj git push` directly; _do_ use `vp run push` to verify changes before pushing.
    - _Don't_ push commits to a remote on your own; _do_ ask the user for permission to push commits to a remote

<!--VITE PLUS START-->

# Using Vite+, the Unified Toolchain for the Web

This project is using Vite+, a unified toolchain built on top of Vite, Rolldown, Vitest, tsdown, Oxlint, Oxfmt, and Vite Task. Vite+ wraps runtime management, package management, and frontend tooling in a single global CLI called `vp`. Vite+ is distinct from Vite, and it invokes Vite through `vp dev` and `vp build`. Run `vp help` to print a list of commands and `vp <command> --help` for information about a specific command.

Docs are local at `node_modules/vite-plus/docs` or online at https://viteplus.dev/guide/.

## Review Checklist

- [ ] Run `vp install` after pulling remote changes and before getting started.
- [ ] Run `vp check` and `vp test` to format, lint, type check and test changes.
- [ ] Check if there are `vite.config.ts` tasks or `package.json` scripts necessary for validation, run via `vp run <script>`.
- [ ] If setup, runtime, or package-manager behavior looks wrong, run `vp env doctor` and include its output when asking for help.

<!--VITE PLUS END-->
