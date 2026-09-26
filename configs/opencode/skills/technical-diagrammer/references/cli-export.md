# draw.io CLI Export Reference

The draw.io desktop app includes a command-line interface for exporting diagrams to PNG, SVG, or PDF. All export operations require the desktop app to be installed.

## Locating the CLI

### Linux (native)

```bash
which drawio
```

Typically installed via snap, apt, or flatpak and available on PATH.

### macOS

```bash
/Applications/draw.io.app/Contents/MacOS/draw.io
```

## Export Command

```bash
drawio -x -f <format> -e -b 10 -o "<output>" "<input.drawio>"
```

### Key Flags

| Flag | Description |
|------|-------------|
| `-x` / `--export` | Export mode (required) |
| `-f` / `--format` | Output format: `png`, `svg`, `pdf`, `jpg` |
| `-e` / `--embed-diagram` | Embed diagram XML in output (PNG, SVG, PDF only) |
| `-o` / `--output` | Output file path |
| `-b` / `--border` | Border width around diagram (default: 0, use 10) |
| `-t` / `--transparent` | Transparent background (PNG only) |
| `-s` / `--scale` | Scale the diagram size (default: 1) |
| `--width` / `--height` | Fit into specified dimensions (preserves aspect ratio) |
| `-a` / `--all-pages` | Export all pages (PDF only) |
| `-p` / `--page-index` | Select a specific page (1-based) |
| `--disable-gpu` | Skip GPU initialization (for VMs, remote desktop, CI) |

### Supported Formats

| Format | Embed XML | Notes |
|--------|-----------|-------|
| `png` | Yes (`-e`) | Viewable everywhere, editable in draw.io |
| `svg` | Yes (`-e`) | Scalable, editable in draw.io |
| `pdf` | Yes (`-e`) | Printable, editable in draw.io |
| `jpg` | No | Lossy, no embedded XML support |

## Export Examples

### Linux

```bash
drawio -x -f png -e -b 10 -o "diagram.drawio.png" "diagram.drawio"
```

### macOS

```bash
/Applications/draw.io.app/Contents/MacOS/draw.io -x -f png -e -b 10 -o "diagram.drawio.png" "diagram.drawio"
```

### High-Resolution Export

```bash
drawio -x -f png -e -b 10 -s 3 -o "diagram.drawio.png" "diagram.drawio"
```

### SVG Export

```bash
drawio -x -f svg -e -b 10 -o "diagram.drawio.svg" "diagram.drawio"
```

### PDF Export (All Pages)

```bash
drawio -x -f pdf -e -b 10 -a -o "diagram.drawio.pdf" "diagram.drawio"
```

## Opening the Result

| Environment | Command |
|-------------|---------|
| macOS | `open <file>` |
| Linux | `xdg-open <file>` |

## File Naming

- Use double extensions for exports: `name.drawio.png`, `name.drawio.svg`, `name.drawio.pdf`
- This signals the file contains embedded diagram XML
- After successful export, delete the intermediate `.drawio` file (the exported file contains the full diagram)

## Detection Script

Use this to detect the CLI before attempting export:

```bash
detect_drawio() {
  if command -v drawio >/dev/null 2>&1; then
    echo "$(command -v drawio)"
  elif [ -x "/Applications/draw.io.app/Contents/MacOS/draw.io" ]; then
    echo "/Applications/draw.io.app/Contents/MacOS/draw.io"
  else
    echo ""
  fi
}

DRAWIO=$(detect_drawio)
if [ -z "$DRAWIO" ]; then
  echo "draw.io CLI not found locally."
else
  echo "Found draw.io CLI: $DRAWIO"
fi
```

## Containerized draw.io

If the draw.io CLI is not installed locally, use a containerized instance via Docker or Podman.

### Prerequisites

- Docker or Podman installed and running
- Network access to pull images (unless using a pre-loaded local image)

### Handwritten Font Setup

The skill uses the **Kalam** handwritten font. For containerized exports, download and mount the font:

```bash
# Download font files from GitHub releases
mkdir -p /tmp/kalam-fonts
wget -q https://github.com/googlefonts/kalam/raw/main/fonts/ttf/Kalam-Regular.ttf -O /tmp/kalam-fonts/Kalam-Regular.ttf
wget -q https://github.com/googlefonts/kalam/raw/main/fonts/ttf/Kalam-Bold.ttf -O /tmp/kalam-fonts/Kalam-Bold.ttf
wget -q https://github.com/googlefonts/kalam/raw/main/fonts/ttf/Kalam-Light.ttf -O /tmp/kalam-fonts/Kalam-Light.ttf
```

For local CLI usage, install the fonts on your system (see SKILL.md > Handwritten Font). The CLI is assumed to be already installed with the font available.

### Container Image

Use the `rlespinasse/drawio-export` image:

```bash
docker pull rlespinasse/drawio-export:latest
```

### Export via Container

Mount the working directory and the font files, then run the export. The container's entrypoint handles headless mode automatically, so no `drawio -x` prefix is needed:

```bash
docker run --rm \
  -v "$(pwd):/work" \
  -v "/tmp/kalam-fonts:/usr/share/fonts/truetype/kalam" \
  -w /work \
  rlespinasse/drawio-export:latest \
  -f png -e -b 10
```

This exports all `.drawio` files in the current directory to an `export/` subdirectory. Output filenames follow the pattern `<filename>-<pagename>.<format>`.

Or with Podman:

```bash
podman run --rm \
  -v "$(pwd):/work" \
  -v "/tmp/kalam-fonts:/usr/share/fonts/truetype/kalam" \
  -w /work \
  rlespinasse/drawio-export:latest \
  -f png -e -b 10
```

**Important:** Files created by the container are owned by `root`. Use `cp` (not `mv`) to rename/move output files:

```bash
cp "export/my-diagram-Page-1.png" "my-diagram.drawio.png"
rm -rf export/
```

### Container Detection Script

```bash
detect_drawio_container() {
  if command -v docker >/dev/null 2>&1 && docker info >/dev/null 2>&1; then
    if docker image inspect rlespinasse/drawio-export:latest >/dev/null 2>&1; then
      echo "docker"
      return
    fi
  fi
  if command -v podman >/dev/null 2>&1 && podman info >/dev/null 2>&1; then
    if podman image inspect rlespinasse/drawio-export:latest >/dev/null 2>&1; then
      echo "podman"
      return
    fi
  fi
  echo ""
}

CONTAINER_RUNTIME=$(detect_drawio_container)
if [ -n "$CONTAINER_RUNTIME" ]; then
  echo "Using containerized draw.io via $CONTAINER_RUNTIME"
fi
```

### Full Detection and Export Script

```bash
detect_and_export() {
  local INPUT="$1"
  local OUTPUT="$2"
  local FORMAT="${3:-png}"

  # Try local CLI first (assumes font is already installed)
  if command -v drawio >/dev/null 2>&1; then
    drawio -x -f "$FORMAT" -e -b 10 -o "$OUTPUT" "$INPUT"
    return $?
  elif [ -x "/Applications/draw.io.app/Contents/MacOS/draw.io" ]; then
    /Applications/draw.io.app/Contents/MacOS/draw.io -x -f "$FORMAT" -e -b 10 -o "$OUTPUT" "$INPUT"
    return $?
  fi

  # Try containerized draw.io
  local RUNTIME=""
  if command -v docker >/dev/null 2>&1 && docker info >/dev/null 2>&1; then
    if docker image inspect rlespinasse/drawio-export:latest >/dev/null 2>&1; then
      RUNTIME="docker"
    fi
  elif command -v podman >/dev/null 2>&1 && podman info >/dev/null 2>&1; then
    if podman image inspect rlespinasse/drawio-export:latest >/dev/null 2>&1; then
      RUNTIME="podman"
    fi
  fi

  if [ -n "$RUNTIME" ]; then
    local DIR
    DIR="$(dirname "$INPUT")"
    
    # Setup font directory if it doesn't exist
    local FONT_DIR="/tmp/kalam-fonts"
    if [ ! -d "$FONT_DIR" ]; then
      mkdir -p "$FONT_DIR"
      wget -q https://github.com/googlefonts/kalam/raw/main/fonts/ttf/Kalam-Regular.ttf -O "$FONT_DIR/Kalam-Regular.ttf"
      wget -q https://github.com/googlefonts/kalam/raw/main/fonts/ttf/Kalam-Bold.ttf -O "$FONT_DIR/Kalam-Bold.ttf"
      wget -q https://github.com/googlefonts/kalam/raw/main/fonts/ttf/Kalam-Light.ttf -O "$FONT_DIR/Kalam-Light.ttf"
    fi
    
    $RUNTIME run --rm \
      -v "$DIR:/work" \
      -v "$FONT_DIR:/usr/share/fonts/truetype/kalam" \
      -w /work \
      rlespinasse/drawio-export:latest \
      -f "$FORMAT" -e -b 10
    # Output is in export/ subdirectory; copy to desired location
    # Container output is root-owned, so use cp not mv
    local EXPORTED
    EXPORTED=$(find "$DIR/export" -name "*.${FORMAT}" -type f | head -1)
    if [ -n "$EXPORTED" ]; then
      cp "$EXPORTED" "$OUTPUT"
      rm -rf "$DIR/export"
      return 0
    fi
    return 1
  fi

  echo "Error: No draw.io CLI or container found"
  return 1
}
```

### Pull Failures

If `docker pull` fails with "pull access denied" or "repository does not exist", the image name is likely incorrect. Ensure you are using `rlespinasse/drawio-export:latest` (not `drawio-exporter` or `jgraph/drawio-desktop`).

## Troubleshooting

| Problem | Cause | Solution |
|---------|-------|----------|
| `command not found: drawio` | Desktop app not installed or not on PATH | Install draw.io Desktop, or use containerized draw.io |
| `pull access denied` / `repository does not exist` | Wrong image name | Use `rlespinasse/drawio-export:latest` (not `drawio-exporter` or `jgraph/drawio-desktop`) |
| `Cannot connect to Docker daemon` | Docker/Podman not running | Start the container runtime service |
| Export produces empty file | Invalid XML in source `.drawio` | Validate XML well-formedness; ensure no comments or malformed attributes |
| `GPU process isn't usable` | Electron cannot start GPU (VMs, remote desktop, CI) | Add `--disable-gpu` to the export command |
| `expected 1 argument but got N` | draw.io Desktop version incompatibility | Update to v26.2.15+ or use explicit `-o` flag for output |
| Blank diagram after export | Missing root cells `id="0"` and `id="1"` | Ensure the basic mxGraphModel structure is complete |
| `unexpected argument '-x'` | Container entrypoint differs from CLI | Do not pass `drawio -x` to container; pass flags directly: `-f png -e -b 10` |
| `cannot move: Permission denied` | Container output owned by root | Use `cp` instead of `mv` to rename output files |

## When CLI is Not Available

If neither a local draw.io CLI nor a containerized instance is available:

1. Keep the `.drawio` file as the deliverable
2. Inform the user they can:
   - Install draw.io Desktop to enable image export
   - Use a containerized draw.io instance (see Containerized draw.io)
   - Open the `.drawio` file directly in draw.io (desktop or web at `app.diagrams.net`)
