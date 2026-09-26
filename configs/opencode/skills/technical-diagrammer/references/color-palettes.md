# Color Palettes

Color schemes for technical diagrams. The default is **high-contrast** for maximum readability.

## Contrast Validation

Before using any color combination, validate contrast using `contrast-check.py`:

```bash
python3 contrast-check.py --palette '{"blue":"#1BA1E2","amber":"#FFB800"}'
```

If a color fails WCAG AAA (7:1 ratio), the script suggests an adjusted background color. Always use the suggested color when the original fails.

```bash
python3 contrast-check.py "#1BA1E2"  # Returns best text color + suggested bg if needed
```

## Complement Validation

When using a themed palette (Solarized, custom, etc.), validate that accent/category colors are mutually distinguishable and have sufficient contrast with their label text using `complement-check.py`:

```bash
python3 complement-check.py '{"background":"#fdf6e3","text_color":"#586e75","accents":{"blue":"#217CBB","green":"#92A41C","red":"#dc322f"}}'
```

Checks performed:
1. **Label contrast** -- each accent fill vs its best text color (WCAG AA, 4.5:1 minimum)
2. **Background visibility** -- each accent fill vs canvas background (deltaE >= 15)
3. **Color distinctness** -- each accent pair (deltaE >= 20, perceptually distinguishable)

## High-Contrast Palette (Default)

Saturated fills with dark strokes. Best for presentations, documentation, and accessibility. All colors validated for WCAG AAA compliance (7:1 minimum contrast ratio).

**Important:** Text color is determined by canvas background, not box background. On a white canvas, use dark text (`#333333`) for all boxes. Box backgrounds are adjusted to ensure sufficient contrast with the text color.

| Role | Name | Fill | Stroke | Font Color |
|------|------|------|--------|------------|
| Primary | Blue | `#80CBEE` | `#006EAF` | `#333333` |
| Success | Green | `#A5CC97` | `#4A8C34` | `#333333` |
| Warning | Amber | `#FFB800` | `#D69E00` | `#333333` |
| Danger | Red | `#DFB9B2` | `#B85450` | `#333333` |
| Info | Purple | `#C3BCE5` | `#9673A6` | `#333333` |
| Neutral | Gray | `#F5F5F5` | `#333333` | `#333333` |
| Accent | Orange | `#FFB153` | `#CC7000` | `#333333` |
| Accent | Teal | `#5AD1E3` | `#0093A8` | `#333333` |

### Usage Pattern

```
fillColor=#1BA1E2;strokeColor=#006EAF;fontColor=#FFFFFF;
```

## Pastel Palette

Soft, muted colors. Good for print documents and subtle visual hierarchy.

| Role | Name | Fill | Stroke | Font Color |
|------|------|------|--------|------------|
| Primary | Light Blue | `#DAE8FC` | `#6C8EBF` | `#333333` |
| Success | Light Green | `#D5E8D4` | `#82B366` | `#333333` |
| Warning | Light Yellow | `#FFF2CC` | `#D6B656` | `#333333` |
| Danger | Light Red | `#F8CECC` | `#B85450` | `#333333` |
| Info | Light Purple | `#E1D5E7` | `#9673A6` | `#333333` |
| Neutral | Light Gray | `#F5F5F5` | `#666666` | `#333333` |
| Accent | Light Orange | `#FFE6CC` | `#D79B00` | `#333333` |
| Accent | Light Pink | `#E6D0DE` | `#996185` | `#333333` |

### Usage Pattern

```
fillColor=#DAE8FC;strokeColor=#6C8EBF;fontColor=#333333;
```

## Monochrome Palette

Single-hue variations. Professional, clean, and print-friendly.

| Level | Fill | Stroke | Font Color |
|-------|------|--------|------------|
| Darkest | `#333333` | `#000000` | `#FFFFFF` |
| Dark | `#666666` | `#333333` | `#FFFFFF` |
| Medium | `#999999` | `#666666` | `#FFFFFF` |
| Light | `#CCCCCC` | `#999999` | `#333333` |
| Lightest | `#F5F5F5` | `#CCCCCC` | `#333333` |

### Usage Pattern

```
fillColor=#666666;strokeColor=#333333;fontColor=#FFFFFF;
```

## No Color (Outline Only)

Minimal style with no fills. Best for technical precision and black-and-white printing.

| Element | Fill | Stroke | Font Color |
|---------|------|--------|------------|
| All shapes | `none` | `#333333` | `#333333` |
| Emphasized | `none` | `#333333` (strokeWidth=2) | `#333333` |

### Usage Pattern

```
fillColor=none;strokeColor=#333333;fontColor=#333333;
```

## Solarized Light Palette

Based on Ethan Schoonover's [Solarized](https://ethanschoonover.com/solarized/) color scheme, light variant. Accent colors are adjusted from canonical Solarized values to meet WCAG AA contrast for in-box labels. All colors validated with `complement-check.py`.

**Canvas:** `background="#fdf6e3"` `adaptiveColors="none"`

| Role | Name | Fill | Stroke | Font Color |
|------|------|------|--------|------------|
| Primary | Blue | `#217CBB` | `#155079` | `#FFFFFF` |
| Success | Green | `#92A41C` | `#5E6A12` | `#333333` |
| Warning | Yellow | `#BD951C` | `#7A6012` | `#333333` |
| Danger | Red | `#dc322f` | `#8F201E` | `#FFFFFF` |
| Info | Cyan | `#3FAAA2` | `#286E69` | `#333333` |
| Accent | Violet | `#6A6FC1` | `#44487D` | `#FFFFFF` |
| Accent | Orange | `#C45518` | `#7F370F` | `#FFFFFF` |
| Accent | Magenta | `#d33682` | `#892354` | `#FFFFFF` |
| Neutral | Base2 | `#eee8d5` | `#93a1a1` | `#586e75` |

### Solarized Light Base Colors

| Token | Hex | Usage |
|-------|-----|-------|
| Base3 | `#fdf6e3` | Canvas background |
| Base2 | `#eee8d5` | Neutral fill, container bg |
| Base1 | `#93a1a1` | Neutral stroke, subtle borders |
| Base01 | `#586e75` | Canvas text color |
| Base00 | `#657b83` | Secondary text |

### Usage Pattern

```
fillColor=#217CBB;strokeColor=#155079;fontColor=#FFFFFF;
```

## Solarized Dark Palette

Solarized dark variant. Same accent fills as Solarized Light (they are shared), but with a dark canvas and light text. All colors validated with `complement-check.py`.

**Canvas:** `background="#002b36"` `adaptiveColors="none"`

| Role | Name | Fill | Stroke | Font Color |
|------|------|------|--------|------------|
| Primary | Blue | `#217CBB` | `#155079` | `#FFFFFF` |
| Success | Green | `#92A41C` | `#5E6A12` | `#333333` |
| Warning | Yellow | `#BD951C` | `#7A6012` | `#333333` |
| Danger | Red | `#dc322f` | `#8F201E` | `#FFFFFF` |
| Info | Cyan | `#3FAAA2` | `#286E69` | `#333333` |
| Accent | Violet | `#6A6FC1` | `#44487D` | `#FFFFFF` |
| Accent | Orange | `#C45518` | `#7F370F` | `#FFFFFF` |
| Accent | Magenta | `#d33682` | `#892354` | `#FFFFFF` |
| Neutral | Base02 | `#073642` | `#586e75` | `#93a1a1` |

### Solarized Dark Base Colors

| Token | Hex | Usage |
|-------|-----|-------|
| Base03 | `#002b36` | Canvas background |
| Base02 | `#073642` | Neutral fill, container bg |
| Base01 | `#586e75` | Neutral stroke, subtle borders |
| Base1 | `#93a1a1` | Canvas text color |
| Base0 | `#839496` | Secondary text |

### Dark Theme Edge Labels

On dark canvases, edge labels use draw.io's default white background. Use **dark text** (`fontColor=#333333`) with bright stroke colors:

```xml
<mxCell id="edge1" value="label" style="endArrow=classic;html=1;sketch=1;strokeColor=#217CBB;strokeWidth=2;fontColor=#333333;fontSize=11;" edge="1" parent="1">
  <mxGeometry relative="1" as="geometry"/>
</mxCell>
```

### Usage Pattern

```
fillColor=#217CBB;strokeColor=#155079;fontColor=#FFFFFF;
```

## Solarized Categorical Sets

For distinguishing groups, categories, or parallel elements within a Solarized-themed diagram.

### Solarized Set A (6 colors)

```
#217CBB  (Blue)
#92A41C  (Green)
#BD951C  (Yellow)
#dc322f  (Red)
#6A6FC1  (Violet)
#3FAAA2  (Cyan)
```

### Solarized Set B (8 colors, full accent palette)

```
#217CBB  (Blue)
#92A41C  (Green)
#BD951C  (Yellow)
#dc322f  (Red)
#6A6FC1  (Violet)
#3FAAA2  (Cyan)
#C45518  (Orange)
#d33682  (Magenta)
```

## Solarized Edge / Connector Colors

| Purpose | Stroke Color | Notes |
|---------|--------------|-------|
| Default (light) | `#586e75` | Standard connections on light canvas |
| Default (dark) | `#93a1a1` | Standard connections on dark canvas |
| Emphasized | `#217CBB` (strokeWidth=2-3) | Important paths |
| Data flow | `#3FAAA2` | Information movement (cyan) |
| Control flow | `#C45518` | Control signals (orange) |
| Error path | `#dc322f` (dashed) | Error handling (red) |
| Optional | `#93a1a1` (dashed) | Optional connections |
| Disabled | `#073642` | Inactive connections (dark) / `#eee8d5` (light) |

## Semantic Color Mapping

Use colors to convey meaning consistently across diagrams:

| Meaning | Color | Fill | Stroke |
|---------|-------|------|--------|
| Start / Active / Go | Green | `#60A548` | `#4A8C34` |
| Stop / Error / End | Red | `#E6472A` | `#B83822` |
| Warning / Decision | Amber | `#FFB800` | `#D69E00` |
| Information / Process | Blue | `#1BA1E2` | `#006EAF` |
| External / Third-party | Purple | `#7B61FF` | `#5F49CC` |
| Database / Storage | Pink/Red | `#F8CECC` | `#B85450` |
| Queue / Message | Orange | `#FF8C00` | `#CC7000` |
| Cache / Temporary | Teal | `#00B8D4` | `#0093A8` |
| Disabled / Inactive | Gray | `#F5F5F5` | `#666666` |

## Categorical Color Sets

For distinguishing groups, categories, or parallel elements.

### Set A (6 colors, high contrast)

```
#1BA1E2  (Blue)
#60A548  (Green)
#FFB800  (Amber)
#E6472A  (Red)
#7B61FF  (Purple)
#00B8D4  (Teal)
```

### Set B (8 colors, high contrast)

```
#1BA1E2  (Blue)
#60A548  (Green)
#FFB800  (Amber)
#E6472A  (Red)
#7B61FF  (Purple)
#00B8D4  (Teal)
#FF8C00  (Orange)
#996185  (Pink)
```

### Set C (Pastel, 6 colors)

```
#DAE8FC  (Light Blue)
#D5E8D4  (Light Green)
#FFF2CC  (Light Yellow)
#F8CECC  (Light Red)
#E1D5E7  (Light Purple)
#D5E8D4  (Light Teal)
```

## Edge / Connector Colors

| Purpose | Stroke Color | Notes |
|---------|--------------|-------|
| Default | `#333333` | Standard connections |
| Emphasized | `#333333` (strokeWidth=2-3) | Important paths |
| Data flow | `#1BA1E2` | Information movement |
| Control flow | `#E6472A` | Control signals |
| Error path | `#E6472A` (dashed) | Error handling |
| Optional | `#666666` (dashed) | Optional connections |
| Disabled | `#CCCCCC` | Inactive connections |

## Sketch Mode Fill Styles

When sketch mode is enabled (`sketch=1`), choose a fill pattern:

| Fill Style | Property Value | Description |
|------------|----------------|-------------|
| Solid | `fillStyle=solid` | Solid color fill (default) |
| Hachure | `fillStyle=hachure` | Diagonal line pattern |
| Cross-hatch | `fillStyle=cross-hatch` | Crossed diagonal lines |
| Dots | `fillStyle=dots` | Dot pattern |

### Example with Hachure Fill

```
rounded=1;whiteSpace=wrap;html=1;sketch=1;fillStyle=hachure;hachureGap=6;fillColor=#1BA1E2;strokeColor=#006EAF;fontColor=#FFFFFF;
```

## Dark Mode Considerations

draw.io supports automatic dark mode with `adaptiveColors="auto"` on the `mxGraphModel`.

- Colors with `default` value adapt automatically (black in light, white in dark)
- Explicit hex colors are auto-inverted for dark mode
- Use `light-dark(lightColor, darkColor)` for explicit control:

```
fontColor=light-dark(#333333,#FFFFFF);
```

## Accessibility Guidelines

- Ensure sufficient contrast between fill and font colors
- Use color + shape/pattern to convey meaning (not color alone)
- High-contrast palette meets WCAG AA for large text
- For colorblind accessibility, avoid red/green as the only differentiator
- Use the categorical sets with varied hues for maximum distinction
