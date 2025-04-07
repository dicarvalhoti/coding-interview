const esbuild = require("esbuild");

const ctx = {
  entryPoints: ["app/assets/javascripts/application.js"],
  bundle: true,
  outdir: "app/assets/javascripts/core",
  sourcemap: true,
  format: "esm",
  target: ["es2020"],
  plugins: [
    {
      name: "import-glob",
      setup(build) {
        build.onResolve({ filter: /\*/ }, async (args) => {
          if (args.resolveDir === "") return;
          return {
            namespace: "import-glob",
            path: args.path,
            pluginData: { resolveDir: args.resolveDir },
          };
        });

        build.onLoad({ filter: /.*/, namespace: "import-glob" }, async (args) => {
          const files = require("glob").sync(args.path, {
            cwd: args.pluginData.resolveDir,
          });
          const importers = files.map((file) => `import * as ${file.replace(/\W/g, "_")} from "./${file}";`).join("\n");
          const exporters = `export default {${files.map((file) => `"${file}": ${file.replace(/\W/g, "_")}.default`).join(",")}}`;
          return { contents: importers + "\n" + exporters, resolveDir: args.pluginData.resolveDir };
        });
      },
    },
  ],
};

if (process.argv.includes("--watch")) {
  esbuild.context(ctx).then(context => {
    context.watch();
  });
} else {
  esbuild.build(ctx).catch(() => process.exit(1));
}