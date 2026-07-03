# Figma comparison loop

Detail behind steps 3 to 5 of the feedback loop in `SKILL.md`. This uses Figma's Dev Mode MCP server. The relevant read tools are `get_metadata`, `get_variable_defs`, `get_design_context`, and `get_screenshot`.

## Node mapping (no Code Connect on Flutter)

Figma Code Connect does not support Flutter, so there is no automatic mapping from a Flutter widget to a Figma node, and `get_code_connect_map` will not resolve your widgets. Establish the node another way:

- **User-provided link.** Ask the user for the Figma link to the frame or component. A URL like `figma.com/design/<fileKey>/<name>?node-id=2840-17` gives you the `fileKey` and the `nodeId` (`2840-17`, which the API also accepts as `2840:17`).
- **Current selection.** On the Figma desktop app, the MCP server can read the current selection, so the user can select the node and you operate on the selection.
- **Search by name.** If you have a file link but not the node, call `get_metadata` (without a `nodeId` it returns the document's pages; with a page id it returns that page's node map). Match the widget to a node by layer name, then confirm the choice with the user before comparing.

If none of these yields a node, skip the comparison and record in the PR that the design check was skipped. Do not invent a node id.

## Step 4: property comparison (the gate)

Call `get_variable_defs` for the node. It returns the variables and styles the design uses (colors, spacing, radius, typography) as name and value pairs. For each one, confirm the Flutter widget resolves the corresponding design token rather than a matching literal:

- Figma fill bound to `colorScheme.error` (`#DC2626`) requires `Theme.of(context).colorScheme.error` or your `AppColors.error` token, not `Color(0xFFFF0000)`, even if the hex is close.
- Figma spacing bound to a spacing variable requires your `AppSpacing` token, not a raw `EdgeInsets.all(16)`.

Use `get_design_context` when you also need structure: the auto-layout direction, alignment, hierarchy, and nesting. It returns a React and Tailwind representation by default, so read it for structure and token references, not as code to port. If the response is large or truncated, narrow to the specific child node and re-fetch.

Parity passes when every token reported by `get_variable_defs` maps to the same token in the widget. This is the gate because it is deterministic and environment-independent, unlike pixels.

## Step 5: visual comparison (sanity check)

Call `get_screenshot` for the node to get its rendered image, and compare it against the Widgetbook snapshot from `widgetbook/build/.widgetbook`. Check for structural differences: wrong layout direction, missing or extra elements, misaligned groups, obviously wrong sizing or type scale.

Do not treat this as a pixel diff. The two images come from different rendering stacks, so anti-aliasing, font hinting, and sub-pixel layout will always differ. If the property gate in step 4 passes but the screenshot shows a structural difference, that difference is the bug to fix. If the property gate passes and the screenshot differs only in rendering texture, parity holds.

## Exit condition

Converge only when all three hold at once:

1. `flutter test` is green with no failing assertions and no overflow or layout errors.
2. Every token from `get_variable_defs` resolves to the same token in the widget.
3. The `get_screenshot` image shows no structural difference from the Widgetbook snapshot.

## Practical notes

- **Rate limits.** The read tools are rate limited per the Figma plan. Fetch a node's context once and reuse it across the loop rather than re-fetching every iteration.
- **Desktop vs remote server.** Selection-based prompting works only on the desktop server. The remote server needs a link to a frame or layer. Either way, prefer an explicit `nodeId` so runs are reproducible.
- **Write tools.** Do not call any Figma tool that writes to the canvas unless the user explicitly asks. The comparison loop is read-only.
