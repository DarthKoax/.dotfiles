# draw.io XML Format Reference

## File Structure

A `.drawio` file is mxGraphModel XML wrapped in an `mxfile` element:

```xml
<mxfile host="app.diagrams.net" modified="2026-01-01T00:00:00.000Z"
        agent="opencode" version="24.0.0" type="device">
  <diagram id="page-1" name="Page-1">
    <mxGraphModel dx="1422" dy="762" grid="1" gridSize="10"
                  guides="1" tooltips="1" connect="1" arrows="1"
                  fold="1" page="1" pageScale="1"
                  pageWidth="1169" pageHeight="827"
                  math="0" shadow="0" sketch="1" adaptiveColors="auto">
      <root>
        <mxCell id="0"/>
        <mxCell id="1" parent="0"/>
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
```

## mxGraphModel Attributes

| Attribute | Default | Description |
|-----------|---------|-------------|
| `dx` | 0 | Horizontal scroll offset |
| `dy` | 0 | Vertical scroll offset |
| `grid` | 1 | Show grid (0/1) |
| `gridSize` | 10 | Grid spacing in px |
| `guides` | 1 | Enable alignment guides |
| `tooltips` | 1 | Show tooltips |
| `connect` | 1 | Enable connection points |
| `arrows` | 1 | Show arrows on edges |
| `fold` | 1 | Enable container folding |
| `page` | 1 | Show page boundaries |
| `pageScale` | 1 | Page zoom scale |
| `pageWidth` | 1169 | Page width in px (A4 landscape) |
| `pageHeight` | 827 | Page height in px (A4 landscape) |
| `math` | 0 | Enable LaTeX math rendering |
| `shadow` | 0 | Default shadow on shapes |
| `background` | `none` | Background color (use `none` for transparent) |
| `sketch` | 0 | Global hand-drawn/sketch style (0/1) |
| `adaptiveColors` | `none` | Dark mode adaptation: `auto`, `simple`, `none` |

## Root Cells (Mandatory)

Every diagram must have these two cells:

```xml
<mxCell id="0"/>
<mxCell id="1" parent="0"/>
```

- `id="0"` is the root container
- `id="1"` is the default layer; all diagram elements use `parent="1"` unless in a sub-container

## Cell Types

### Vertex (Shape)

```xml
<mxCell id="2" value="Label" style="rounded=1;whiteSpace=wrap;html=1;" vertex="1" parent="1">
  <mxGeometry x="100" y="100" width="120" height="60" as="geometry"/>
</mxCell>
```

### Edge (Connector)

```xml
<mxCell id="10" value="" style="endArrow=classic;html=1;" edge="1" parent="1" source="2" target="3">
  <mxGeometry relative="1" as="geometry"/>
</mxCell>
```

Every edge MUST have `<mxGeometry relative="1" as="geometry"/>` as a child element.

## Style String Format

Styles are semicolon-separated `key=value` pairs:

```
rounded=1;whiteSpace=wrap;html=1;fontFamily=Kalam;fillColor=#dae8fc;strokeColor=#6c8ebf;fontColor=#333333;
```

- Keys and values are case-sensitive
- No spaces around `=` or `;`
- Boolean values use `0` and `1`
- Colors use `#RRGGBB` hex format, `none`, or `default`
- `fontFamily=Kalam` for handwritten font (see SKILL.md > Handwritten Font for installation)

## Common Shape Styles

### Rectangles

```
rounded=0;whiteSpace=wrap;html=1;fontFamily=Kalam;fillColor=#dae8fc;strokeColor=#6c8ebf;fontColor=#333333;
```

### Rounded Rectangles

```
rounded=1;whiteSpace=wrap;html=1;fontFamily=Kalam;fillColor=#dae8fc;strokeColor=#6c8ebf;fontColor=#333333;
```

### Ellipses / Circles

```
ellipse;whiteSpace=wrap;html=1;fontFamily=Kalam;fillColor=#d5e8d4;strokeColor=#82b366;fontColor=#333333;
```

### Diamonds / Rhombus

```
rhombus;whiteSpace=wrap;html=1;fontFamily=Kalam;fillColor=#fff2cc;strokeColor=#d6b656;fontColor=#333333;
```

### Cylinders (Database)

```
shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=15;fontFamily=Kalam;fillColor=#f8cecc;strokeColor=#b85450;fontColor=#333333;
```

### Cloud

```
ellipse;shape=cloud;whiteSpace=wrap;html=1;fontFamily=Kalam;fillColor=#e1d5e7;strokeColor=#9673a6;fontColor=#333333;
```

### Hexagon

```
shape=hexagon;perimeter=hexagonPerimeter2;whiteSpace=wrap;html=1;fixedSize=1;fontFamily=Kalam;fillColor=#ffe6cc;strokeColor=#d6b656;fontColor=#333333;
```

### Triangle

```
triangle;whiteSpace=wrap;html=1;fontFamily=Kalam;fillColor=#f8cecc;strokeColor=#b85450;fontColor=#333333;
```

### Document

```
shape=mxgraph.flowchart.document;whiteSpace=wrap;html=1;fontFamily=Kalam;fillColor=#dae8fc;strokeColor=#6c8ebf;fontColor=#333333;
```

### Parallel Lines (Start/End)

```
shape=mxgraph.flowchart.start_2;whiteSpace=wrap;html=1;fontFamily=Kalam;fillColor=#d5e8d4;strokeColor=#82b366;fontColor=#333333;
```

## Edge Styles

### Straight Arrow

```
endArrow=classic;html=1;fontFamily=Kalam;strokeColor=#333333;fontColor=#333333;
```

### Orthogonal (Right-Angle)

```
edgeStyle=orthogonalEdgeStyle;endArrow=classic;html=1;fontFamily=Kalam;strokeColor=#333333;fontColor=#333333;
```

### Curved

```
curved=1;endArrow=classic;html=1;fontFamily=Kalam;strokeColor=#333333;fontColor=#333333;
```

### Dashed

```
dashed=1;endArrow=classic;html=1;fontFamily=Kalam;strokeColor=#333333;fontColor=#333333;
```

### Bidirectional

```
endArrow=classic;startArrow=classic;html=1;fontFamily=Kalam;strokeColor=#333333;fontColor=#333333;
```

### No Arrow

```
endArrow=none;html=1;fontFamily=Kalam;strokeColor=#333333;fontColor=#333333;
```

## Sketch / Hand-Drawn Style

Enable sketch mode globally on `mxGraphModel` with `sketch="1"`.

Per-cell sketch properties (add to style string):

| Property | Values | Description |
|----------|--------|-------------|
| `sketch` | 0/1 | Enable hand-drawn appearance |
| `comic` | 0/1 | Comic/casual style (same as sketch) |
| `fillStyle` | `solid`, `hachure`, `cross-hatch`, `dots` | Sketch fill pattern |
| `hachureGap` | number | Gap between fill lines |
| `hachureAngle` | number | Angle of fill lines (degrees) |
| `jiggle` | number | Hand-drawn jiggle amount |
| `curveFitting` | 0-1 | Curve smoothness |
| `disableMultiStroke` | 0/1 | Single-pass border |
| `disableMultiStrokeFill` | 0/1 | Single-pass fill |

Example sketch style:

```
rounded=1;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillStyle=hachure;hachureGap=6;jiggle=2;fillColor=#1BA1E2;strokeColor=#006EAF;fontColor=#333333;
```

## Containers and Swimlanes

### Swimlane Container

```xml
<mxCell id="group1" value="Swimlane Title" style="swimlane;startSize=30;fillColor=#f5f5f5;strokeColor=#666666;fontFamily=Kalam;fontStyle=1;fontColor=#333333;html=1;sketch=1;" vertex="1" parent="1">
  <mxGeometry x="50" y="50" width="400" height="300" as="geometry"/>
</mxCell>
```

Child cells use `parent="group1"` with coordinates relative to the container.

### Group Container (Invisible Border)

```xml
<mxCell id="group2" value="" style="group;html=1;" vertex="1" parent="1">
  <mxGeometry x="50" y="50" width="400" height="300" as="geometry"/>
</mxCell>
```

## Perimeter Matching

Non-rectangular shapes need matching perimeter values:

| Shape | Perimeter |
|-------|-----------|
| `ellipse` | `perimeter=ellipsePerimeter` |
| `rhombus` | `perimeter=rhombusPerimeter` |
| `triangle` | `perimeter=trianglePerimeter` |
| `hexagon` | `perimeter=hexagonPerimeter2` |
| `cylinder3` | `perimeter=cylinderPerimeter` |

## HTML Labels

Enable with `html=1` in the style. Supports basic HTML in `value`:

```xml
<mxCell id="5" value="&lt;b&gt;Bold&lt;/b&gt;&lt;br&gt;&lt;i&gt;Italic&lt;/i&gt;" style="rounded=1;whiteSpace=wrap;html=1;" vertex="1" parent="1">
  <mxGeometry x="100" y="100" width="120" height="60" as="geometry"/>
</mxCell>
```

Remember to XML-escape HTML: `&lt;`, `&gt;`, `&amp;`, `&quot;`.

## Layers

Additional layers beyond `id="1"`:

```xml
<mxCell id="2" value="Layer Name" parent="0"/>
```

Cells in that layer use `parent="2"`.

## Edge Parenting Rules

Edges belong to the innermost container that holds BOTH endpoints:
- Same container (at any nesting depth) -> that container's id
- One end outside every container -> `parent="1"`

## Coordinate System

- (0,0) is top-left
- x increases rightward
- y increases downward
- Coordinates are relative to the parent container

## Page Sizes

| Orientation | pageWidth | pageHeight |
|-------------|-----------|------------|
| A4 Landscape | 1169 | 827 |
| A4 Portrait | 827 | 1169 |
| Letter Landscape | 1100 | 850 |
| Letter Portrait | 850 | 1100 |

## Complete Example: Flowchart

```xml
<mxfile host="app.diagrams.net" modified="2026-01-01T00:00:00.000Z" agent="opencode" version="24.0.0" type="device">
  <diagram id="flowchart" name="Flowchart">
    <mxGraphModel dx="1422" dy="762" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1169" pageHeight="827" math="0" shadow="0" sketch="1" adaptiveColors="auto">
      <root>
        <mxCell id="0"/>
        <mxCell id="1" parent="0"/>
        <mxCell id="start" value="Start" style="ellipse;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#A5CC97;strokeColor=#4A8C34;fontColor=#333333;fontStyle=1;" vertex="1" parent="1">
          <mxGeometry x="340" y="40" width="120" height="60" as="geometry"/>
        </mxCell>
        <mxCell id="decision" value="Condition?" style="rhombus;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#FFB800;strokeColor=#D69E00;fontColor=#333333;fontStyle=1;" vertex="1" parent="1">
          <mxGeometry x="320" y="150" width="160" height="80" as="geometry"/>
        </mxCell>
        <mxCell id="procA" value="Process A" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#80CBEE;strokeColor=#006EAF;fontColor=#333333;fontStyle=1;" vertex="1" parent="1">
          <mxGeometry x="160" y="290" width="120" height="60" as="geometry"/>
        </mxCell>
        <mxCell id="procB" value="Process B" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#C3BCE5;strokeColor=#9673A6;fontColor=#333333;fontStyle=1;" vertex="1" parent="1">
          <mxGeometry x="520" y="290" width="120" height="60" as="geometry"/>
        </mxCell>
        <mxCell id="end" value="End" style="ellipse;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#DFB9B2;strokeColor=#B85450;fontColor=#333333;fontStyle=1;" vertex="1" parent="1">
          <mxGeometry x="340" y="420" width="120" height="60" as="geometry"/>
        </mxCell>
        <mxCell id="e1" style="endArrow=classic;html=1;sketch=1;fontFamily=Kalam;strokeColor=#333333;strokeWidth=2;fontColor=#333333;" edge="1" parent="1" source="start" target="decision">
          <mxGeometry relative="1" as="geometry"/>
        </mxCell>
        <mxCell id="e2" value="Yes" style="endArrow=classic;html=1;sketch=1;fontFamily=Kalam;strokeColor=#333333;strokeWidth=2;fontColor=#333333;" edge="1" parent="1" source="decision" target="procA">
          <mxGeometry relative="1" as="geometry"/>
        </mxCell>
        <mxCell id="e3" value="No" style="endArrow=classic;html=1;sketch=1;fontFamily=Kalam;strokeColor=#333333;strokeWidth=2;fontColor=#333333;" edge="1" parent="1" source="decision" target="procB">
          <mxGeometry relative="1" as="geometry"/>
        </mxCell>
        <mxCell id="e4" style="endArrow=classic;html=1;sketch=1;fontFamily=Kalam;strokeColor=#333333;strokeWidth=2;fontColor=#333333;" edge="1" parent="1" source="procA" target="end">
          <mxGeometry relative="1" as="geometry"/>
        </mxCell>
        <mxCell id="e5" style="endArrow=classic;html=1;sketch=1;fontFamily=Kalam;strokeColor=#333333;strokeWidth=2;fontColor=#333333;" edge="1" parent="1" source="procB" target="end">
          <mxGeometry relative="1" as="geometry"/>
        </mxCell>
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
```
