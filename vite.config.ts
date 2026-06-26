import { defineConfig } from "vite-plus";

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
        input: [{ auto: true }, "!node_modules/**", "!.vite-plus/**"],
      },
      "check:nix": {
        command: "nix flake check",
        cache: false,
      },
      "check:full": {
        command: "vp check",
        dependsOn: ["check:nix"],
        input: [{ auto: true }, "!node_modules/**", "!.vite-plus/**"],
      },
      build: {
        command: "vp run -r build",
        input: [{ auto: true }, "!apps/**/dist/**", "!packages/**/dist/**", "!tools/**/dist/**"],
      },
      test: {
        command: "echo 'No tests defined'",
        // command: "vp run -r test",
        input: [{ auto: true }, "!apps/**/dist/**", "!packages/**/dist/**", "!tools/**/dist/**"],
      },
      ready: {
        command: "echo 'Checking if everything is ready...'",
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
