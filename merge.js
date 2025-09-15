import { promises as fs } from "fs";
import path from "path";

async function combineJSFiles(folderPath, outputFile = "combined-js.txt") {
  try {
    // Ensure the folder path exists
    if (
      !(await fs
        .stat(folderPath)
        .then((stat) => stat.isDirectory())
        .catch(() => false))
    ) {
      throw new Error(`Directory ${folderPath} does not exist`);
    }

    let combinedContent = "";
    const filesProcessed = [];
    const scriptName = path.basename(process.argv[1]); // Get the name of this script (merge.js)

    // Function to process a single directory
    async function processDirectory(dirPath) {
      const entries = await fs.readdir(dirPath, { withFileTypes: true });

      for (const entry of entries) {
        const fullPath = path.join(dirPath, entry.name);

        if (entry.isDirectory()) {
          // Process one level of subfolders
          if (dirPath === folderPath) {
            await processDirectory(fullPath);
          }
        } else if (
          entry.isFile() &&
          (entry.name.endsWith(".js") || entry.name.endsWith(".svelte")) &&
          entry.name !== scriptName
        ) {
          // Include .js and .svelte, exclude this script
          // Process .js and .svelte files except merge.js
          const content = await fs.readFile(fullPath, "utf8");
          combinedContent += `\n\n// File: ${path.relative(
            folderPath,
            fullPath
          )}\n${content}`;
          filesProcessed.push(path.relative(folderPath, fullPath));
        }
      }
    }

    // Process the root folder
    await processDirectory(folderPath);

    // Write the combined content to output file
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

// Example usage
// You can run it from command line: node merge.js /path/to/folder [outputfile]
const args = process.argv.slice(2);
const folderPath = args[0] || "./src"; // Default to './src' if no path provided
const outputFile = args[1] || "merged-dashboard.txt";

combineJSFiles(folderPath, outputFile);
