---
description: Use when using the Figma MCP
alwaysApply: false
---
# Figma Dev Mode MCP rules
When you're using the Figma MCP you must follow these rules:
- The Figma Dev Mode MCP Server provides an assets endpoint which can serve image and SVG assets
- If the Figma Dev Mode MCP Server returns a localhost source for an image or an SVG, use that image or SVG source directly
- Do NOT import/add new icon packages, all the assets should be in the Figma payload
- Do NOT use or create placeholders if a localhost source is provided
- Parse all Figma colors to code variables: start lowercase, remove slashes, append parentheses content.
    Examples:
    Bg/Active/Primary → backgroundActivePrimary
    Fg/Accent/Primary (hover) → foregroundAccentPrimaryHover
