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
        cache: true,
      },
      "check:nix": {
        command: "nix flake check",
        cache: false,
      },
      "check:full": {
        command: "vp check",
        dependsOn: ["check:nix"],
        cache: true,
      },
      ready: {
        command: [
          // "vp run -r test",
          // "vp run -r build"
        ],
        dependsOn: ["check:full"],
        cache: true,
      },
      push: {
        command: "jj git push",
        dependsOn: ["ready"],
        cache: false,
      },
    },
  },
});
