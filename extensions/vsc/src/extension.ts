import * as vscode from "vscode";
import { ComponentCodeLensProvider } from "./component-code-lens-provider";

export function activate(context: vscode.ExtensionContext) {
  const codeLensProvider = new ComponentCodeLensProvider();

  const codeLensDisposable = vscode.languages.registerCodeLensProvider(
    { language: "dart", scheme: "file" },
    codeLensProvider
  );

  const viewComponentCommand = vscode.commands.registerCommand(
    "widgetbook.viewComponent",
    async (_documentUri: vscode.Uri, className: string) => {
      try {
        const storyFile = await findStoryFile(className);
        if (storyFile) {
          await openStoryFile(storyFile.uri, storyFile.match);
        } else {
          vscode.window.showErrorMessage(
            `Could not find story file with Meta<${className}>`
          );
        }
      } catch (error) {
        vscode.window.showErrorMessage(`Could not open story file: ${error}`);
      }
    }
  );

  const fileWatcher =
    vscode.workspace.createFileSystemWatcher("**/*.stories.dart");
  fileWatcher.onDidChange(() => codeLensProvider.refresh());
  fileWatcher.onDidCreate(() => codeLensProvider.refresh());
  fileWatcher.onDidDelete(() => codeLensProvider.refresh());

  context.subscriptions.push(
    codeLensDisposable,
    viewComponentCommand,
    fileWatcher
  );
}

async function findStoryFile(
  className: string
): Promise<{ uri: vscode.Uri; match: RegExpExecArray | null } | undefined> {
  const files = await vscode.workspace.findFiles("**/*.stories.dart");
  const metaRegex = new RegExp(`Meta<${className}>`);

  for (const file of files) {
    const document = await vscode.workspace.openTextDocument(file);
    const text = document.getText();

    if (metaRegex.test(text)) {
      const metaPositionRegex = new RegExp(
        `const\\s+meta\\s*=\\s*Meta<${className}>`,
        "g"
      );
      return { uri: file, match: metaPositionRegex.exec(text) };
    }
  }

  return undefined;
}

async function openStoryFile(
  uri: vscode.Uri,
  match: RegExpExecArray | null
): Promise<void> {
  const document = await vscode.workspace.openTextDocument(uri);
  const editor = await vscode.window.showTextDocument(document);

  if (match) {
    const position = document.positionAt(match.index);
    const range = new vscode.Range(position, position);
    editor.selection = new vscode.Selection(range.start, range.end);
    editor.revealRange(range, vscode.TextEditorRevealType.InCenter);
  }
}

export function deactivate() {}
