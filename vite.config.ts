import { defineConfig } from "vite-plus";

export const DEFAULT_INPUT = [
  { auto: true },
  "!node_modules/**",
  "!.vite-plus/**",
  "!apps/**/dist/**",
  "!packages/**/dist/**",
  "!tools/**/dist/**",
];

export default defineConfig({
  fmt: {},
  lint: {
    jsPlugins: [{ name: "vite-plus", specifier: "vite-plus/oxlint-plugin" }],
    rules: { "vite-plus/prefer-vite-plus-imports": "error" },
    options: { typeAware: true, typeCheck: true },
  },
  run: {
    cache: true,
    tasks: {
      "fmt:nix": {
        command: "nix fmt",
        cache: false,
      },
      "fmt:full": {
        command: "vp fmt",
        dependsOn: ["fmt:nix"],
        input: DEFAULT_INPUT,
      },
      "check:nix": {
        command: "nix flake check",
        cache: false,
      },
      "check:full": {
        command: "vp check",
        dependsOn: ["check:nix"],
        input: DEFAULT_INPUT,
      },
      generate: {
        command: "vp run -r generate && vp fmt",
        cache: false,
      },
      dev: {
        command: "vp run -r dev",
        input: DEFAULT_INPUT,
      },
      build: {
        command: "vp run -r build",
        input: DEFAULT_INPUT,
      },
      test: {
        command: "echo 'No tests defined'",
        // command: "vp run -r test",
        input: DEFAULT_INPUT,
      },
      ready: {
        command: "echo 'Repository is ready'",
        dependsOn: ["check:full", "build", "test"],
      },
      push: {
        command: "jj git push",
        dependsOn: ["ready"],
        cache: false,
      },
    },
  },
});
