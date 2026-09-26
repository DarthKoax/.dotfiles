---
name: technical-diagrammer
description: Use when the user asks to create, generate, draw, or design any technical diagram including system flow diagrams, UML diagrams, database schemas, flowcharts, swim lanes, kanban boards, Venn diagrams, mindmaps, function call order diagrams, dependency maps, architecture diagrams, ER diagrams, sequence diagrams, class diagrams, network diagrams, state diagrams, or any other visual/structural representation. Also use when the user mentions draw.io, drawio, .drawio files, or diagram export to PNG/SVG/PDF.
---

# Technical Diagrammer

Generate technical diagrams as native `.drawio` files for inclusion in project documentation. Diagrams are authored as draw.io XML and optionally exported to image formats via the draw.io desktop CLI.

## Defaults

- **Style**: Hand-drawn (sketch mode enabled)
- **Colors**: High-contrast colorization enabled. Also available: Solarized Light, Solarized Dark, pastel, monochrome, no color
- **Format**: `.drawio` file saved to the project directory
- **Export**: Image export only when explicitly requested

## Workflow

1. **Clarify requirements** - Prompt the user for any unknowns (see Prompting)
2. **ASCII prototype** - Create an ASCII art version of the diagram for user review (see ASCII Prototyping)
3. **Author the diagram** - Generate draw.io XML (see `references/xml-format.md`)
4. **Save to project** - Write the `.drawio` file to the project directory
5. **Export if requested** - Use the draw.io CLI to export to PNG/SVG/PDF (see `references/cli-export.md`)
6. **Review output** - If the model supports image viewing, review the exported image for accuracy (see Image Review)
7. **Open the result** - Open the file or exported image for the user

## ASCII Prototyping

Before generating the full draw.io XML, create an ASCII art prototype of the diagram. This allows the user to review the structure, layout, and content before the final diagram is generated.

### When to prototype

- Always prototype for complex diagrams (architecture, flowcharts, swim lanes, mindmaps, call flow diagrams)
- Skip for simple diagrams (single flowchart with < 5 nodes, basic class diagrams)
- Ask the user if unsure whether to prototype

### ASCII format examples

**Flowchart:**
```
    +---------+
    |  Start  |
    +----+----+
         |
         v
    +---------+
    | Process |
    +----+----+
         |
    +---------+
    | Decision|--Yes--+
    +----+----+       |
         | No         v
         v       +---------+
    +---------+  | Process |
    | Process |  +----+----+
    +----+----+       |
         |            |
         +-----+------+
               |
               v
          +---------+
          |   End   |
          +---------+
```

**Architecture:**
```
    +-------------+       +-------------+
    |   Client    |------>|    API      |
    +-------------+       +------+------+
                                  |
                          +-------+-------+
                          |               |
                          v               v
                   +------+------+  +-----+-----+
                   |  Service A  |  | Service B |
                   +------+------+  +-----+-----+
                          |               |
                          +-------+-------+
                                  |
                                  v
                          +------+------+
                          |  Database   |
                          +-------------+
```

**Swim Lane:**
```
    User          | System         | Database
    --------------+----------------+----------
    [Submit Form] |                |
         |        |                |
         v        |                |
                  | [Validate]     |
                  |      |         |
                  |      v         |
                  | [Query DB]---->|
                  |                |
                  |<---[Results]---|
                  |      |         |
                  v      v         |
    [View Result] |                |
```

**Call Flow (Function Call Order):**
```
    +---------------------------------------------------------------------+
    | function initiateLogin(provider):                                   |
    |   state = generateRandomState()                                     |
    |   authUrl = buildAuthorizationUrl(provider, state)                  |
    |   redirectUser(authUrl)                                             |
    +---------------------------------------------------------------------+
                                      |
                                     (1)
                                      v
    +---------------------------------------------------------------------+
    | function handleCallback(code, state):                               |
    |   if !validateState(state): return error                            |
    |   tokens = exchangeCodeForTokens(code)                              |
    |   userInfo = fetchUserInfo(tokens.accessToken)                      |
    |   user = findOrCreateUser(userInfo)                                 |
    |   session = createSession(user, tokens)                             |
    |   return session                                                    |
    +---------------------------------------------------------------------+
                                      |
                                     (2)
                                      v
    +---------------------------------------------------------------------+
    | function exchangeCodeForTokens(code):                               |
    |   response = httpPost(tokenEndpoint, {code, clientId, secret})      |
    |   return {accessToken, refreshToken, idToken}                       |
    +---------------------------------------------------------------------+
```

### Prototype review

After presenting the ASCII prototype, ask the user:
- Does the structure look correct?
- Are any elements missing or misplaced?
- Should the layout be adjusted?

Wait for confirmation before proceeding to generate the full draw.io XML.

## Image Review

If the model supports image viewing and an image export was generated (PNG, SVG, PDF), review the exported image for accuracy.

### When to review

- Only when the model has image/vision capabilities
- Only after a successful image export
- Review the exported image file (not the `.drawio`)

### What to check

- All elements from the ASCII prototype are present
- Labels and text are correct and readable
- Connections/edges are properly rendered
- Colors and styling match the requested scheme
- Layout is clear and not overlapping
- No visual artifacts or rendering issues

### If issues are found

1. Describe the issue to the user
2. Regenerate the diagram with corrections
3. Re-export and re-review if necessary

## Prompting

Before generating, use the `question` tool to clarify any unknowns. Ask only what is not already obvious from the request.

### Required clarifications (ask if not specified)

- **Diagram type** - What kind of diagram? (flowchart, UML, ER, sequence, mindmap, etc.)
- **Content** - What should the diagram show? (entities, flows, components, etc.)
- **Output location** - Where in the project should the file be saved?

### Optional clarifications (use defaults if not specified)

- **Color scheme** - Default: high-contrast. Options: high-contrast, solarized-light, solarized-dark, pastel, monochrome, custom palette, no color
- **Background** - Default: white (light). Options: light, dark (`#1E1E1E`), solarized-light (`#fdf6e3`), solarized-dark (`#002b36`)
- **Style** - Default: hand-drawn. Options: hand-drawn, clean/professional, comic
- **Export format** - Default: `.drawio` only. Options: `.drawio`, PNG, SVG, PDF
- **Page orientation** - Default: landscape. Options: landscape, portrait
- **Diagram title** - Default: derived from content. User can specify a custom title

### Example prompt sequence

```
question: "What type of diagram do you need?"
  options: [Flowchart, UML Class Diagram, ER Diagram, Sequence Diagram, Mindmap, Architecture Diagram, Swim Lane, Kanban Board, Venn Diagram, Dependency Map, Function Call Order / Call Flow Diagram]

question: "What color scheme would you like?"
  options: [High-contrast (default), Solarized Light, Solarized Dark, Pastel, Monochrome, No color]

question: "Should the background be light or dark?"
  options: [Light (default), Dark]

question: "Should the style be hand-drawn or clean?"
  options: [Hand-drawn (default), Clean/Professional]

question: "Do you need an image export?"
  options: [No, just .drawio, PNG, SVG, PDF]
```

## Hand-Drawn Style (Default)

Apply sketch mode globally on the `mxGraphModel` and to each cell:

```xml
<mxGraphModel adaptiveColors="auto" sketch="1">
```

On individual cells, add `sketch=1` to the style string. Combine with high-contrast fill colors from the color palette (see `references/color-palettes.md`).

## Handwritten Font

The skill uses **Kalam**, a handwritten font that complements the hand-drawn sketch style.

### Font Installation

**For draw.io CLI (local installation):**

Download and install the font on your system:

```bash
# Download from GitHub releases
wget -q https://github.com/googlefonts/kalam/raw/main/fonts/ttf/Kalam-Regular.ttf -O /tmp/Kalam-Regular.ttf
wget -q https://github.com/googlefonts/kalam/raw/main/fonts/ttf/Kalam-Bold.ttf -O /tmp/Kalam-Bold.ttf
wget -q https://github.com/googlefonts/kalam/raw/main/fonts/ttf/Kalam-Light.ttf -O /tmp/Kalam-Light.ttf

# Install on Linux
mkdir -p ~/.local/share/fonts
cp /tmp/Kalam-*.ttf ~/.local/share/fonts/
fc-cache -fv

# Install on macOS
cp /tmp/Kalam-*.ttf ~/Library/Fonts/

# Install on Windows (PowerShell)
# Copy to C:\Windows\Fonts\
```

**For Docker container:**

Mount the font files into the container:

```bash
# Download fonts first (if not already done)
mkdir -p /tmp/kalam-fonts
wget -q https://github.com/googlefonts/kalam/raw/main/fonts/ttf/Kalam-Regular.ttf -O /tmp/kalam-fonts/Kalam-Regular.ttf
wget -q https://github.com/googlefonts/kalam/raw/main/fonts/ttf/Kalam-Bold.ttf -O /tmp/kalam-fonts/Kalam-Bold.ttf
wget -q https://github.com/googlefonts/kalam/raw/main/fonts/ttf/Kalam-Light.ttf -O /tmp/kalam-fonts/Kalam-Light.ttf

# Mount fonts when running container
docker run --rm \
  -v "$(pwd):/work" \
  -v "/tmp/kalam-fonts:/usr/share/fonts/truetype/kalam" \
  -w /work \
  rlespinasse/drawio-export:latest \
  -f png -e -b 10
```

### Using the Font in Diagrams

Apply the font to cells using `fontFamily=Kalam` in the style string:

```xml
<mxCell id="1" value="Handwritten Text" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fontColor=#333333;fillColor=#1BA1E2;strokeColor=#006EAF;" vertex="1" parent="1">
  <mxGeometry x="100" y="100" width="120" height="60" as="geometry"/>
</mxCell>
```

For titles and headings, use `fontFamily=Kalam` with `fontStyle=1` (bold):

```xml
<mxCell id="title" value="Diagram Title" style="text;html=1;sketch=1;fontFamily=Kalam;fontStyle=1;fontSize=24;fontColor=#333333;" vertex="1" parent="1">
  <mxGeometry x="100" y="20" width="200" height="40" as="geometry"/>
</mxCell>
```

## High-Contrast Colors (Default)

Use saturated fill colors with dark strokes for maximum readability. See `references/color-palettes.md` for the full palette. The default high-contrast set:

| Role | Fill | Stroke |
|------|------|--------|
| Primary | `#1BA1E2` | `#006EAF` |
| Success | `#60A548` | `#4A8C34` |
| Warning | `#FFB800` | `#D69E00` |
| Danger | `#E6472A` | `#B83822` |
| Info | `#7B61FF` | `#5F49CC` |
| Neutral | `#F5F5F5` | `#333333` |

## Solarized Themes

Based on Ethan Schoonover's [Solarized](https://ethanschoonover.com/solarized/) palette. Accent colors are adjusted from canonical values to meet WCAG AA contrast for in-box labels. All colors validated with `complement-check.py`. See `references/color-palettes.md` > Solarized Light/Dark for full tables.

### Solarized Light

Canvas: `background="#fdf6e3"` `adaptiveColors="none"` `fontColor=#586e75`

| Role | Fill | Stroke | Font |
|------|------|--------|------|
| Primary | `#217CBB` | `#155079` | `#FFFFFF` |
| Success | `#92A41C` | `#5E6A12` | `#333333` |
| Warning | `#BD951C` | `#7A6012` | `#333333` |
| Danger | `#dc322f` | `#8F201E` | `#FFFFFF` |
| Info | `#3FAAA2` | `#286E69` | `#333333` |
| Accent | `#6A6FC1` | `#44487D` | `#FFFFFF` |
| Accent | `#C45518` | `#7F370F` | `#FFFFFF` |
| Accent | `#d33682` | `#892354` | `#FFFFFF` |
| Neutral | `#eee8d5` | `#93a1a1` | `#586e75` |

### Solarized Dark

Canvas: `background="#002b36"` `adaptiveColors="none"` `fontColor=#93a1a1`

Same accent fills as Solarized Light. Neutral uses dark base colors:

| Role | Fill | Stroke | Font |
|------|------|--------|------|
| Neutral | `#073642` | `#586e75` | `#93a1a1` |

### Solarized Canvas Setup

```xml
<mxGraphModel adaptiveColors="none" sketch="1" background="#fdf6e3">
```

or for dark:

```xml
<mxGraphModel adaptiveColors="none" sketch="1" background="#002b36">
```

## Dark Theme

When the user requests a dark background, set the canvas background and disable adaptive color inversion:

```xml
<mxGraphModel adaptiveColors="none" sketch="1" background="#1E1E1E">
```

- Use dark fill colors with bright strokes for blocks (see `references/diagram-types.md` > Function Call Order Diagram > Dark Theme block color palette)
- Use light text colors (`fontColor=#D0D0D0` or `#FFFFFF`)
- Title text must be white (`fontColor=#FFFFFF`)
- Edge colors should be bright/saturated to stand out against the dark background
- See `references/diagram-types.md` for the complete dark theme pseudocode block template

**Edge label backgrounds:** On dark canvases, edge labels use draw.io's default white label background. Use **dark text** (`fontColor=#333333`) on this white background for readability. Do NOT use `labelBackgroundColor=none` with light text — that produces unreadable light-on-dark labels.

```xml
<mxCell id="edge1" value="label text" style="endArrow=classic;html=1;sketch=1;strokeColor=#1BA1E2;strokeWidth=2;fontColor=#333333;fontSize=11;" edge="1" parent="1" source="a" target="b">
  <mxGeometry relative="1" as="geometry"/>
</mxCell>
```

## Diagram Types

For templates and patterns for each supported diagram type, read `references/diagram-types.md`. Load only the section relevant to the current task.

## XML Format

For the complete draw.io XML format reference, read `references/xml-format.md`.

## CLI Export

For draw.io CLI detection, export commands, containerized draw.io support, and troubleshooting, read `references/cli-export.md`.

If a local draw.io CLI is not found, the skill will attempt to use a containerized instance (Docker/Podman).

**Container quick reference:**
- Image: `rlespinasse/drawio-export:latest`
- Command: `docker run --rm -v "$(pwd):/work" -v "/tmp/kalam-fonts:/usr/share/fonts/truetype/kalam" -w /work rlespinasse/drawio-export:latest -f png -e -b 10`
- Output goes to `export/` subdirectory
- Use `cp` (not `mv`) to rename output files (container creates root-owned files)
- Font setup: `mkdir -p /tmp/kalam-fonts && wget -q https://github.com/googlefonts/kalam/raw/main/fonts/ttf/Kalam-Regular.ttf -O /tmp/kalam-fonts/Kalam-Regular.ttf && wget -q https://github.com/googlefonts/kalam/raw/main/fonts/ttf/Kalam-Bold.ttf -O /tmp/kalam-fonts/Kalam-Bold.ttf && wget -q https://github.com/googlefonts/kalam/raw/main/fonts/ttf/Kalam-Light.ttf -O /tmp/kalam-fonts/Kalam-Light.ttf`

## File Naming

- Use descriptive, lowercase hyphen-separated names: `login-flow.drawio`, `database-schema.drawio`
- For exports, use double extensions: `login-flow.drawio.png`, `database-schema.drawio.svg`
- Save to the project directory (ask the user for the preferred location if unclear)

## Critical Rules

1. **NEVER include XML comments** in the output - they waste tokens and can cause parse errors
2. **Always include root cells** `id="0"` (root container) and `id="1"` (default layer)
3. **Use unique IDs** for every `mxCell`
4. **Vertices need `vertex="1"`**, edges need `edge="1"` - mutually exclusive
5. **Every edge must have** `<mxGeometry relative="1" as="geometry" />` as a child element
6. **Escape special characters** in attribute values: `&amp;`, `&lt;`, `&gt;`, `&quot;`
7. **Use uncompressed XML** - never Base64-encode the diagram content
8. **Match perimeters to shapes** - non-rectangular shapes need matching `perimeter=` values
9. **Validate color contrast** - text color is fixed by canvas background (dark `#333333` on white canvas); run `python3 references/contrast-check.py --palette '{...}'` to validate box backgrounds; if any fails, use the suggested background; target WCAG AAA (7:1 ratio)
10. **Validate theme complements** - when using Solarized or custom themed palettes, run `python3 references/complement-check.py '{...}'` to verify accent colors have sufficient contrast with their label text (WCAG AA 4.5:1), are visible against the canvas background (deltaE >= 15), and are mutually distinguishable (deltaE >= 20)
11. **Dark theme edge labels** - on dark canvases, edge labels use the default white background; use dark text (`fontColor=#333333`) on them for readability; do NOT combine `labelBackgroundColor=none` with light text

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Diagram opens blank | Ensure root cells `id="0"` and `id="1"` are present |
| Edges not rendering | Every edge needs a child `<mxGeometry relative="1" as="geometry" />` |
| File won't open | Validate XML well-formedness; check for unescaped characters |
| CLI not found locally | Try containerized draw.io (see `references/cli-export.md`); keep `.drawio` as fallback |
| `pull access denied` | Wrong image name; use `rlespinasse/drawio-export:latest` |
| Export produces empty file | Check XML validity; ensure no comments or malformed attributes |
