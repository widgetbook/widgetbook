import * as assert from "assert";
import * as path from "path";
import * as vscode from "vscode";
import { WIDGET_CLASS_PATTERN } from "../component-code-lens-provider";

suite("ComponentCodeLensProvider Test Suite", () => {
  suite("WIDGET_CLASS_PATTERN", () => {
    test("matches StatelessWidget", () => {
      const regex = new RegExp(WIDGET_CLASS_PATTERN);
      const match = regex.exec("class MyWidget extends StatelessWidget {}");
      assert.ok(match);
      assert.strictEqual(match[1], "MyWidget");
    });

    test("matches StatefulWidget", () => {
      const regex = new RegExp(WIDGET_CLASS_PATTERN);
      const match = regex.exec("class MyWidget extends StatefulWidget {}");
      assert.ok(match);
      assert.strictEqual(match[1], "MyWidget");
    });

    test("matches ConsumerWidget", () => {
      const regex = new RegExp(WIDGET_CLASS_PATTERN);
      const match = regex.exec("class MyWidget extends ConsumerWidget {}");
      assert.ok(match);
      assert.strictEqual(match[1], "MyWidget");
    });

    test("does not match non-widget classes", () => {
      const regex = new RegExp(WIDGET_CLASS_PATTERN);
      const match = regex.exec("class MyService extends BaseService {}");
      assert.strictEqual(match, null);
    });
  });

  suite("CodeLens Provider", () => {
    test("returns empty for non-Dart files", async () => {
      const doc = await vscode.workspace.openTextDocument({
        language: "typescript",
        content: "class MyWidget extends StatelessWidget {}",
      });

      const codeLenses = await vscode.commands.executeCommand<
        vscode.CodeLens[]
      >("vscode.executeCodeLensProvider", doc.uri);

      assert.ok(!codeLenses || codeLenses.length === 0);
    });

    test("provides code lens for widget with Meta definition", async () => {
      const workspaceFolders = vscode.workspace.workspaceFolders;
      const exampleWorkspace = workspaceFolders![0];
      const myWidgetPath = path.join(
        exampleWorkspace.uri.fsPath,
        "lib",
        "my_widget.dart"
      );

      const doc = await vscode.workspace.openTextDocument(myWidgetPath);
      await new Promise((resolve) => {
        // Give time for the code lens provider to be registered
        setTimeout(resolve, 150);
      });

      const codeLenses = await vscode.commands.executeCommand<
        vscode.CodeLens[]
      >("vscode.executeCodeLensProvider", doc.uri);

      assert.ok(codeLenses.length > 0);
      assert.ok(
        codeLenses.some(
          (lens) => lens.command?.command === "widgetbook.viewComponent"
        )
      );
    });
  });
});
