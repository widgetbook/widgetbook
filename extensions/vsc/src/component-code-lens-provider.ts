import * as vscode from "vscode";
import * as path from "path";
import * as fs from "fs";

export const WIDGET_CLASS_PATTERN =
  /class\s+(\w+)\s+extends\s+(?:Stateless|Stateful|Consumer)Widget/g;

export class ComponentCodeLensProvider implements vscode.CodeLensProvider {
  private readonly _onDidChangeCodeLenses = new vscode.EventEmitter<void>();
  public readonly onDidChangeCodeLenses = this._onDidChangeCodeLenses.event;

  public provideCodeLenses(
    document: vscode.TextDocument,
    _token: vscode.CancellationToken
  ): vscode.CodeLens[] {
    if (document.languageId !== "dart") {
      return [];
    }

    const codeLenses: vscode.CodeLens[] = [];
    const text = document.getText();

    let match;
    while ((match = WIDGET_CLASS_PATTERN.exec(text)) !== null) {
      const className = match[1];
      const range = this.getRangeForMatch(document, match);

      if (this.hasMetaDefinition(className)) {
        codeLenses.push(
          new vscode.CodeLens(range, {
            title: "$(eye) View Component",
            tooltip: `Open ${className} Widgetbook Component`,
            command: "widgetbook.viewComponent",
            arguments: [document.uri, className],
          })
        );
      }
    }

    return codeLenses;
  }

  private getRangeForMatch(
    document: vscode.TextDocument,
    match: RegExpExecArray
  ): vscode.Range {
    const line = document.lineAt(document.positionAt(match.index).line);
    const column = line.text.indexOf(match[0]);
    const position = new vscode.Position(line.lineNumber, column);
    return new vscode.Range(position, position);
  }

  private hasMetaDefinition(className: string): boolean {
    const workspaceFolders = vscode.workspace.workspaceFolders;
    if (!workspaceFolders) {
      return false;
    }

    const metaRegex = new RegExp(`Meta<${className}>`);

    for (const folder of workspaceFolders) {
      const storyFiles = this.findStoriesDartFiles(folder.uri.fsPath);

      for (const storyFile of storyFiles) {
        try {
          const content = fs.readFileSync(storyFile, "utf8");
          if (metaRegex.test(content)) {
            return true;
          }
        } catch {
          // Ignore read errors
        }
      }
    }

    return false;
  }

  private findStoriesDartFiles(dir: string): string[] {
    const results: string[] = [];

    try {
      for (const entry of fs.readdirSync(dir)) {
        const fullPath = path.join(dir, entry);
        const stat = fs.statSync(fullPath);

        if (stat.isDirectory()) {
          results.push(...this.findStoriesDartFiles(fullPath));
        } else if (entry.endsWith(".stories.dart")) {
          results.push(fullPath);
        }
      }
    } catch {
      // Ignore directory access errors
    }

    return results;
  }

  public refresh(): void {
    this._onDidChangeCodeLenses.fire();
  }
}
