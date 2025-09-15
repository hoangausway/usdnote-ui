import { promises as fs } from "fs";
import path from "path";

function ts() {
  const d = new Date();
  const p = (n) => String(n).padStart(2, "0");
  return `${d.getFullYear()}${p(d.getMonth() + 1)}${p(d.getDate())}-${p(
    d.getHours()
  )}${p(d.getMinutes())}${p(d.getSeconds())}`;
}

function resolveOutputFile(arg) {
  const stamp = ts();

  if (!arg) {
    // default: merged-dashboard-<timestamp>.txt in CWD
    return `merged-dashboard-${stamp}.txt`;
  }

  const statPromise = fs.stat(arg).catch(() => null);

  return statPromise.then((st) => {
    if (st?.isDirectory?.()) {
      // If a directory is provided, write the default file into it
      return path.join(arg, `merged-dashboard-${stamp}.txt`);
    }

    // Treat as a file path or base name
    const parsed = path.parse(arg);
    if (!parsed.ext) {
      // No extension given → use as a base name, add timestamp + .txt
      return `${arg}-${stamp}.txt`;
    }

    if (parsed.ext.toLowerCase() === ".txt") {
      // Insert timestamp before .txt
      return path.join(parsed.dir, `${parsed.name}-${stamp}${parsed.ext}`);
    }

    // If a different extension was provided, keep it and still add the stamp
    return path.join(parsed.dir, `${parsed.name}-${stamp}${parsed.ext}`);
  });
}

async function combineJSFiles(folderPath, outputFile) {
  try {
    // Ensure the folder path exists
    const okDir = await fs
      .stat(folderPath)
      .then((s) => s.isDirectory())
      .catch(() => false);
    if (!okDir) throw new Error(`Directory ${folderPath} does not exist`);

    let combinedContent = "";
    const filesProcessed = [];
    const scriptName = path.basename(process.argv[1]); // this script (merge.js)

    // Process only root and one level of subfolders
    async function processDirectory(dirPath) {
      const entries = await fs.readdir(dirPath, { withFileTypes: true });

      // Stable order
      entries.sort((a, b) => a.name.localeCompare(b.name));

      for (const entry of entries) {
        const fullPath = path.join(dirPath, entry.name);

        if (entry.isDirectory()) {
          if (dirPath === folderPath) await processDirectory(fullPath);
        } else if (
          entry.isFile() &&
          (entry.name.endsWith(".js") || entry.name.endsWith(".svelte")) &&
          entry.name !== scriptName
        ) {
          const content = await fs.readFile(fullPath, "utf8");
          combinedContent += `\n\n// File: ${path.relative(
            folderPath,
            fullPath
          )}\n${content}`;
          filesProcessed.push(path.relative(folderPath, fullPath));
        }
      }
    }

    await processDirectory(folderPath);

    await fs.writeFile(outputFile, combinedContent.trim());

    console.log(
      `Successfully combined ${filesProcessed.length} files into ${outputFile}`
    );
    console.log("Files included:");
    filesProcessed.forEach((file) => console.log(`- ${file}`));
  } catch (error) {
    console.error("Error combining files:", error.message);
  }
}

// ---- CLI ----
// Usage: node merge.js /path/to/folder [outputPathOrName]
//  - If [output] omitted: writes ./merged-dashboard-YYYYMMDD-HHMMSS.txt
//  - If [output] is a directory: writes merged-dashboard-<stamp>.txt inside it
//  - If [output] is a file name (with or without .txt): inserts <stamp> before extension (or adds .txt)
const args = process.argv.slice(2);
const folderPath = args[0] || "./src";

const resolved = await resolveOutputFile(args[1]);
combineJSFiles(folderPath, resolved);
