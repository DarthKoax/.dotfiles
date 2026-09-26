# Diagram Type Templates

Templates and patterns for each supported diagram type. Load only the section relevant to the current task.

## Flowchart

Standard flowchart with start/end terminals, processes, decisions, and connectors.

### Shapes

| Element | Style |
|---------|-------|
| Start/End (Terminal) | `ellipse;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#A5CC97;strokeColor=#4A8C34;fontColor=#333333;fontStyle=1;` |
| End (Terminal) | `ellipse;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#DFB9B2;strokeColor=#B85450;fontColor=#333333;fontStyle=1;` |
| Process | `rounded=1;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#80CBEE;strokeColor=#006EAF;fontColor=#333333;fontStyle=1;` |
| Decision | `rhombus;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#FFB800;strokeColor=#D69E00;fontColor=#333333;fontStyle=1;` |
| Input/Output | `shape=parallelogram;perimeter=parallelogramPerimeter;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#C3BCE5;strokeColor=#9673A6;fontColor=#333333;fontStyle=1;` |
| Document | `shape=mxgraph.flowchart.document;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#FFE6CC;strokeColor=#D69E00;fontColor=#333333;fontStyle=1;` |
| Database | `shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=15;sketch=1;fontFamily=Kalam;fillColor=#F8CECC;strokeColor=#B85450;fontColor=#333333;fontStyle=1;` |

### Layout

- Top-to-bottom or left-to-right flow
- Start terminal at top
- Decisions branch into multiple paths
- All paths converge to End terminal
- Use orthogonal edge routing for clean connections

### Example Structure

```xml
<mxCell id="start" value="Start" style="ellipse;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#A5CC97;strokeColor=#4A8C34;fontColor=#333333;fontStyle=1;" vertex="1" parent="1">
  <mxGeometry x="340" y="40" width="120" height="60" as="geometry"/>
</mxCell>
<mxCell id="proc1" value="Process Step" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#80CBEE;strokeColor=#006EAF;fontColor=#333333;fontStyle=1;" vertex="1" parent="1">
  <mxGeometry x="320" y="140" width="160" height="60" as="geometry"/>
</mxCell>
<mxCell id="decision1" value="Condition?" style="rhombus;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#FFB800;strokeColor=#D69E00;fontColor=#333333;fontStyle=1;" vertex="1" parent="1">
  <mxGeometry x="320" y="240" width="160" height="80" as="geometry"/>
</mxCell>
<mxCell id="end" value="End" style="ellipse;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#DFB9B2;strokeColor=#B85450;fontColor=#333333;fontStyle=1;" vertex="1" parent="1">
  <mxGeometry x="340" y="380" width="120" height="60" as="geometry"/>
</mxCell>
```

## UML Class Diagram

Classes with attributes, methods, and relationships (inheritance, composition, aggregation, dependency).

### Shapes

| Element | Style |
|---------|-------|
| Class Box | `shape=class;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#DAE8FC;strokeColor=#6C8EBF;fontColor=#333333;fontStyle=1;` |
| Interface | `shape=class;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#D5E8D4;strokeColor=#82B366;fontColor=#333333;fontStyle=1;` |
| Abstract Class | `shape=class;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#E1D5E7;strokeColor=#9673A6;fontColor=#333333;fontStyle=2;` |

### Relationships

| Relationship | Edge Style |
|--------------|------------|
| Association | `endArrow=classic;html=1;sketch=1;fontFamily=Kalam;strokeColor=#333333;fontColor=#333333;` |
| Inheritance | `endArrow=block;endFill=0;html=1;sketch=1;fontFamily=Kalam;strokeColor=#333333;` |
| Implementation | `endArrow=block;endFill=0;dashed=1;html=1;sketch=1;fontFamily=Kalam;strokeColor=#333333;` |
| Composition | `endArrow=diamondThin;endFill=1;html=1;sketch=1;fontFamily=Kalam;strokeColor=#333333;` |
| Aggregation | `endArrow=diamondThin;endFill=0;html=1;sketch=1;fontFamily=Kalam;strokeColor=#333333;` |
| Dependency | `endArrow=classic;dashed=1;html=1;sketch=1;fontFamily=Kalam;strokeColor=#333333;fontColor=#333333;` |

### Class Box Structure

Use HTML labels for class boxes with compartments:

```xml
<mxCell id="class1" value="&lt;b&gt;ClassName&lt;/b&gt;&lt;hr&gt;- attribute1: Type&lt;br&gt;- attribute2: Type&lt;hr&gt;+ method1(): ReturnType&lt;br&gt;+ method2(param: Type): void" style="shape=class;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#DAE8FC;strokeColor=#6C8EBF;fontColor=#333333;" vertex="1" parent="1">
  <mxGeometry x="100" y="100" width="200" height="140" as="geometry"/>
</mxCell>
```

## ER Diagram (Entity-Relationship)

Entities with attributes and relationships (1:1, 1:N, M:N).

### Shapes

| Element | Style |
|---------|-------|
| Entity (Strong) | `shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=15;sketch=1;fontFamily=Kalam;fillColor=#1BA1E2;strokeColor=#006EAF;fontColor=#FFFFFF;fontStyle=1;` |
| Entity (Weak) | `shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=15;sketch=1;fontFamily=Kalam;fillColor=#7B61FF;strokeColor=#5F49CC;fontColor=#FFFFFF;fontStyle=1;dashed=1;` |
| Attribute (Key) | `ellipse;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#FFB800;strokeColor=#D69E00;fontColor=#333333;fontStyle=5;` |
| Attribute (Normal) | `ellipse;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#D5E8D4;strokeColor=#82B366;fontColor=#333333;` |
| Relationship | `rhombus;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#F8CECC;strokeColor=#B85450;fontColor=#333333;fontStyle=1;` |

### Relationship Cardinality

Label edges with cardinality:
- `1` - One
- `N` or `*` - Many
- `0..1` - Zero or One
- `1..N` - One or Many

```xml
<mxCell id="rel1" value="has" style="endArrow=classic;html=1;sketch=1;fontFamily=Kalam;strokeColor=#333333;strokeWidth=2;fontColor=#333333;" edge="1" parent="1" source="entity1" target="entity2">
  <mxGeometry relative="1" as="geometry"/>
</mxCell>
```

## Sequence Diagram

Objects with lifelines showing message exchanges over time.

### Shapes

| Element | Style |
|---------|-------|
| Actor | `shape=umlLifeline;perimeter=lifelinePerimeter;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#1BA1E2;strokeColor=#006EAF;fontColor=#FFFFFF;fontStyle=1;container=1;collapsible=0;recursiveResize=0;outlineConnect=0;size=40;` |
| Object | `shape=umlLifeline;perimeter=lifelinePerimeter;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#D5E8D4;strokeColor=#82B366;fontColor=#333333;fontStyle=1;container=1;collapsible=0;recursiveResize=0;outlineConnect=0;size=40;` |
| Activation Box | `shape=umlFrame;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#FFF2CC;strokeColor=#D6B656;` |

### Messages

| Message Type | Edge Style |
|--------------|------------|
| Synchronous | `endArrow=classic;html=1;sketch=1;fontFamily=Kalam;strokeColor=#333333;fontColor=#333333;` |
| Asynchronous | `endArrow=open;html=1;sketch=1;fontFamily=Kalam;strokeColor=#333333;fontColor=#333333;` |
| Return | `endArrow=open;dashed=1;html=1;sketch=1;fontFamily=Kalam;strokeColor=#333333;fontColor=#333333;` |
| Self-call | `endArrow=classic;html=1;sketch=1;fontFamily=Kalam;strokeColor=#333333;curved=1;fontColor=#333333;` |

### Layout

- Actors/objects across the top
- Lifelines extend vertically downward
- Messages flow horizontally between lifelines
- Time progresses downward

### Dark Theme Sequence Diagram

When using a dark canvas (`background="#1E1E1E"`), apply these adjustments:

**Lifeline actors:** Use dark fill with bright stroke:

```xml
<mxCell id="actor1" value="ActorName" style="shape=umlLifeline;perimeter=lifelinePerimeter;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#2A2A2A;strokeColor=#1BA1E2;fontColor=#FFFFFF;fontStyle=1;container=1;collapsible=0;recursiveResize=0;outlineConnect=0;size=40;" vertex="1" parent="1">
  <mxGeometry x="30" y="60" width="140" height="1250" as="geometry"/>
</mxCell>
```

**Message edges:** Use draw.io's default white label background with **dark text** (`fontColor=#333333`) and bright stroke colors. Do NOT use `labelBackgroundColor=none` with light text — that produces unreadable labels on dark canvases.

```xml
<mxCell id="msg1" value="methodName(param)" style="endArrow=classic;html=1;sketch=1;fontFamily=Kalam;strokeColor=#1BA1E2;strokeWidth=2;fontColor=#333333;fontSize=11;align=bottom;" edge="1" parent="1">
  <mxGeometry relative="1" as="geometry">
    <mxPoint x="100" y="120" as="sourcePoint"/>
    <mxPoint x="300" y="120" as="targetPoint"/>
  </mxGeometry>
</mxCell>
```

## Mindmap

Central topic with branching subtopics radiating outward.

### Shapes

| Element | Style |
|---------|-------|
| Central Topic | `ellipse;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#1BA1E2;strokeColor=#006EAF;fontColor=#FFFFFF;fontStyle=1;fontSize=16;` |
| Main Branch | `ellipse;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#60A548;strokeColor=#4A8C34;fontColor=#FFFFFF;fontStyle=1;fontSize=14;` |
| Sub-branch | `ellipse;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#7B61FF;strokeColor=#5F49CC;fontColor=#FFFFFF;fontSize=12;` |
| Leaf | `ellipse;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#FFB800;strokeColor=#D69E00;fontColor=#333333;fontSize=11;` |

### Connections

Use curved edges for organic mindmap appearance:

```xml
<mxCell id="branch1" style="curved=1;endArrow=none;html=1;sketch=1;fontFamily=Kalam;strokeColor=#333333;strokeWidth=3;" edge="1" parent="1" source="center" target="main1">
  <mxGeometry relative="1" as="geometry"/>
</mxCell>
```

### Layout

- Central topic in the center
- Main branches radiate outward
- Sub-branches extend from main branches
- Use organic/radial arrangement

## Architecture Diagram

System components with connections showing data flow and dependencies.

### Shapes

| Element | Style |
|---------|-------|
| Service/Component | `rounded=1;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#1BA1E2;strokeColor=#006EAF;fontColor=#FFFFFF;fontStyle=1;` |
| Database | `shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=15;sketch=1;fontFamily=Kalam;fillColor=#F8CECC;strokeColor=#B85450;fontColor=#333333;fontStyle=1;` |
| External System | `shape=hexagon;perimeter=hexagonPerimeter2;whiteSpace=wrap;html=1;fixedSize=1;sketch=1;fontFamily=Kalam;fillColor=#E1D5E7;strokeColor=#9673A6;fontColor=#333333;fontStyle=1;` |
| Queue/Message Bus | `shape=mxgraph.flowchart.data;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#FFE6CC;strokeColor=#D69E00;fontColor=#333333;fontStyle=1;` |
| Cloud | `ellipse;shape=cloud;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#D5E8D4;strokeColor=#82B366;fontColor=#333333;fontStyle=1;` |
| Load Balancer | `shape=mxgraph.cisco.network.load_balancer;sketch=1;fontFamily=Kalam;html=1;whiteSpace=wrap;fillColor=#FFB800;strokeColor=#D69E00;` |
| Firewall | `shape=mxgraph.cisco.firewalls.firewall;sketch=1;fontFamily=Kalam;html=1;whiteSpace=wrap;fillColor=#E6472A;strokeColor=#B83822;` |

### Grouping

Use swimlane containers for logical groupings (tiers, zones, networks):

```xml
<mxCell id="tier1" value="Presentation Tier" style="swimlane;startSize=30;fillColor=#F5F5F5;strokeColor=#666666;fontFamily=Kalam;fontStyle=1;fontColor=#333333;html=1;sketch=1;" vertex="1" parent="1">
  <mxGeometry x="50" y="50" width="600" height="150" as="geometry"/>
</mxCell>
```

### Connections

Use orthogonal routing for clean architecture diagrams:

```xml
<mxCell id="conn1" style="edgeStyle=orthogonalEdgeStyle;endArrow=classic;html=1;sketch=1;fontFamily=Kalam;strokeColor=#333333;strokeWidth=2;fontColor=#333333;" edge="1" parent="1" source="comp1" target="comp2">
  <mxGeometry relative="1" as="geometry"/>
</mxCell>
```

## Swim Lane Diagram

Processes organized into lanes by actor, role, or system.

### Structure

Each lane is a horizontal or vertical swimlane container:

```xml
<mxCell id="lane1" value="User" style="swimlane;startSize=30;fillColor=#DAE8FC;strokeColor=#6C8EBF;fontFamily=Kalam;fontStyle=1;fontColor=#333333;html=1;sketch=1;horizontal=0;" vertex="1" parent="1">
  <mxGeometry x="50" y="50" width="200" height="500" as="geometry"/>
</mxCell>
<mxCell id="lane2" value="System" style="swimlane;startSize=30;fillColor=#D5E8D4;strokeColor=#82B366;fontFamily=Kalam;fontStyle=1;fontColor=#333333;html=1;sketch=1;horizontal=0;" vertex="1" parent="1">
  <mxGeometry x="250" y="50" width="200" height="500" as="geometry"/>
</mxCell>
```

### Process Steps

Place process shapes inside lanes with `parent="lane_id"`:

```xml
<mxCell id="step1" value="Submit Form" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#1BA1E2;strokeColor=#006EAF;fontColor=#FFFFFF;fontStyle=1;" vertex="1" parent="lane1">
  <mxGeometry x="40" y="60" width="120" height="60" as="geometry"/>
</mxCell>
```

### Cross-Lane Connections

Edges crossing lanes use `parent="1"` (root layer):

```xml
<mxCell id="flow1" style="endArrow=classic;html=1;sketch=1;fontFamily=Kalam;strokeColor=#333333;strokeWidth=2;fontColor=#333333;" edge="1" parent="1" source="step1" target="step2">
  <mxGeometry relative="1" as="geometry"/>
</mxCell>
```

## Kanban Board

Columns representing workflow stages with cards as work items.

### Structure

Columns as vertical swimlanes. **Do NOT use `horizontal=0`** — that places the title vertically on the left side. Omit it so the column header appears at the top:

```xml
<mxCell id="todo" value="To Do" style="swimlane;startSize=30;fillColor=#F8CECC;strokeColor=#B85450;fontFamily=Kalam;fontStyle=1;fontColor=#333333;html=1;sketch=1;" vertex="1" parent="1">
  <mxGeometry x="50" y="50" width="200" height="500" as="geometry"/>
</mxCell>
<mxCell id="progress" value="In Progress" style="swimlane;startSize=30;fillColor=#FFF2CC;strokeColor=#D6B656;fontFamily=Kalam;fontStyle=1;fontColor=#333333;html=1;sketch=1;" vertex="1" parent="1">
  <mxGeometry x="270" y="50" width="200" height="500" as="geometry"/>
</mxCell>
<mxCell id="done" value="Done" style="swimlane;startSize=30;fillColor=#D5E8D4;strokeColor=#82B366;fontFamily=Kalam;fontStyle=1;fontColor=#333333;html=1;sketch=1;" vertex="1" parent="1">
  <mxGeometry x="490" y="50" width="200" height="500" as="geometry"/>
</mxCell>
```

### Cards

Cards as rounded rectangles inside columns:

```xml
<mxCell id="card1" value="&lt;b&gt;Task Title&lt;/b&gt;&lt;br&gt;&lt;font style=&quot;font-size:10px;&quot;&gt;Description text&lt;/font&gt;" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#FFFFFF;strokeColor=#333333;fontColor=#333333;verticalAlign=top;spacingTop=5;" vertex="1" parent="todo">
  <mxGeometry x="20" y="50" width="160" height="80" as="geometry"/>
</mxCell>
```

### Color Coding

Give each column a distinct fill/stroke color and match the cards within that column to the same palette. This creates visual grouping at a glance:

| Column | Fill | Stroke | Card Fill |
|--------|------|--------|-----------|
| To Do | `#1A3A52` | `#006EAF` | `#2A5A7A` |
| In Progress | `#4A3D1A` | `#D69E00` | `#6A5A2A` |
| Review | `#3D2D52` | `#9673A6` | `#5A4A7A` |
| Done | `#1A4A2D` | `#4A8C34` | `#2A6A4A` |

### Dark Background

Set the canvas background on `mxGraphModel` for dark-themed kanban boards:

```xml
<mxGraphModel background="#1E1E1E" adaptiveColors="auto" sketch="1" ...>
```

Use light font colors (`fontColor=#FFFFFF`) on column headers and cards when the background is dark.

## Venn Diagram

Overlapping circles showing set relationships.

### Shapes

Use ellipses with transparency for overlapping areas:

```xml
<mxCell id="setA" value="Set A" style="ellipse;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#1BA1E2;strokeColor=#006EAF;fontColor=#FFFFFF;fontStyle=1;opacity=60;" vertex="1" parent="1">
  <mxGeometry x="100" y="100" width="200" height="200" as="geometry"/>
</mxCell>
<mxCell id="setB" value="Set B" style="ellipse;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#E6472A;strokeColor=#B83822;fontColor=#FFFFFF;fontStyle=1;opacity=60;" vertex="1" parent="1">
  <mxGeometry x="200" y="100" width="200" height="200" as="geometry"/>
</mxCell>
```

### Overlap Label

Place a label in the intersection area:

```xml
<mxCell id="overlap" value="A &amp; B" style="text;html=1;sketch=1;fontFamily=Kalam;strokeColor=none;fillColor=none;fontColor=#333333;fontStyle=1;fontSize=14;align=center;verticalAlign=middle;" vertex="1" parent="1">
  <mxGeometry x="220" y="170" width="60" height="40" as="geometry"/>
</mxCell>
```

## Dependency Map

Nodes showing module/package/service dependencies.

### Shapes

| Element | Style |
|---------|-------|
| Module/Package | `rounded=1;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#1BA1E2;strokeColor=#006EAF;fontColor=#FFFFFF;fontStyle=1;` |
| External Dependency | `shape=hexagon;perimeter=hexagonPerimeter2;whiteSpace=wrap;html=1;fixedSize=1;sketch=1;fontFamily=Kalam;fillColor=#E1D5E7;strokeColor=#9673A6;fontColor=#333333;fontStyle=1;` |
| Database | `shape=cylinder3;whiteSpace=wrap;html=1;boundedLbl=1;backgroundOutline=1;size=15;sketch=1;fontFamily=Kalam;fillColor=#F8CECC;strokeColor=#B85450;fontColor=#333333;fontStyle=1;` |

### Dependency Edges

```xml
<mxCell id="dep1" value="uses" style="endArrow=classic;html=1;sketch=1;fontFamily=Kalam;strokeColor=#333333;strokeWidth=2;fontColor=#333333;" edge="1" parent="1" source="mod1" target="mod2">
  <mxGeometry relative="1" as="geometry"/>
</mxCell>
```

### Layout

Use organic or force-directed layout for natural clustering. Group related modules visually.

## Function Call Order Diagram (Call Flow Diagram)

Shows the sequence of function/method calls in a program. Each function is rendered as a pseudocode block with its signature and body. Numbered, color-coded edges connect blocks in call order.

### Light Theme Shapes

| Element | Style |
|---------|-------|
| Function | `rounded=1;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#1BA1E2;strokeColor=#006EAF;fontColor=#FFFFFF;fontStyle=1;` |
| Entry Point | `ellipse;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#60A548;strokeColor=#4A8C34;fontColor=#FFFFFF;fontStyle=1;` |
| Return | `ellipse;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#E6472A;strokeColor=#B83822;fontColor=#FFFFFF;fontStyle=1;` |

### Light Theme Call Edges

Label edges with call order numbers:

```xml
<mxCell id="call1" value="1" style="endArrow=classic;html=1;sketch=1;fontFamily=Kalam;strokeColor=#333333;strokeWidth=2;fontStyle=1;fontColor=#333333;" edge="1" parent="1" source="entry" target="func1">
  <mxGeometry relative="1" as="geometry"/>
</mxCell>
```

### Dark Theme (Pseudocode Blocks)

For dark-background diagrams, each function block contains HTML-formatted pseudocode: a colored bold function signature and a monospace body. Each block gets a distinct dark fill with a matching bright stroke. Edges use matching bright colors with large numbered labels.

**Canvas setup:**

```xml
<mxGraphModel dx="1422" dy="762" grid="1" gridSize="10" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="1200" pageHeight="1150" math="0" shadow="0" sketch="1" adaptiveColors="none" background="#1E1E1E">
```

**Title cell:**

```xml
<mxCell id="title" value="&lt;b&gt;&lt;font color=&quot;#FFFFFF&quot; style=&quot;font-size:20px;&quot;&gt;Title &amp;#8212; Function Call Order&lt;/font&gt;&lt;/b&gt;" style="text;html=1;sketch=1;fontFamily=Kalam;strokeColor=none;fillColor=none;fontColor=#FFFFFF;align=center;verticalAlign=middle;" vertex="1" parent="1">
  <mxGeometry x="200" y="12" width="800" height="44" as="geometry"/>
</mxCell>
```

**Function block (pseudocode):**

```xml
<mxCell id="func1" value="&lt;b&gt;&lt;font color=&quot;#80CBEE&quot; style=&quot;font-size:13px;&quot;&gt;function myFunction(param):&lt;/font&gt;&lt;/b&gt;&lt;br&gt;&lt;font face=&quot;Courier New&quot; color=&quot;#D0D0D0&quot; style=&quot;font-size:11px;&quot;&gt;&amp;nbsp;&amp;nbsp;result = doSomething(param)&lt;br&gt;&amp;nbsp;&amp;nbsp;return result&lt;/font&gt;" style="rounded=1;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#1A3A52;strokeColor=#006EAF;fontColor=#D0D0D0;verticalAlign=top;spacingTop=12;spacingLeft=15;spacingRight=10;align=left;arcSize=8;" vertex="1" parent="1">
  <mxGeometry x="300" y="70" width="600" height="110" as="geometry"/>
</mxCell>
```

**Dark theme block color palette (fill / stroke / signature color):**

| Block | Fill | Stroke | Signature |
|-------|------|--------|-----------|
| 1 | `#1A3A52` | `#006EAF` | `#80CBEE` |
| 2 | `#1A4A2D` | `#4A8C34` | `#A5CC97` |
| 3 | `#2D1A4A` | `#5F49CC` | `#C3BCE5` |
| 4 | `#0A3A4A` | `#0093A8` | `#5AD1E3` |
| 5 | `#4A3D1A` | `#D69E00` | `#FFB800` |
| 6 | `#4A1A1A` | `#B83822` | `#DFB9B2` |

**Colored call edges (matching block colors):**

```xml
<mxCell id="edge1" value="&lt;b&gt;&lt;font color=&quot;#1BA1E2&quot; style=&quot;font-size:16px;&quot;&gt;1&lt;/font&gt;&lt;/b&gt;" style="endArrow=classic;html=1;sketch=1;fontFamily=Kalam;strokeColor=#1BA1E2;strokeWidth=3;fontStyle=1;fontColor=#1BA1E2;fontSize=16;align=center;" edge="1" parent="1" source="func1" target="func2">
  <mxGeometry relative="1" as="geometry"/>
</mxCell>
```

**Edge color palette (matching block order):**

| Edge # | Color |
|--------|-------|
| 1 | `#1BA1E2` |
| 2 | `#60A548` |
| 3 | `#7B61FF` |
| 4 | `#00B8D4` |
| 5 | `#FFB800` |
| 6 | `#E6472A` |

### Layout

- Title at top, centered
- Functions arranged top-to-bottom in call order
- Each block ~600px wide, height varies with pseudocode length (110-200px)
- Vertical gap of ~40px between blocks
- Numbered edges connect bottom of one block to top of the next
- Return paths shown with dashed arrows (optional)

### HTML Formatting Rules for Pseudocode Blocks

- Function signature: `<b><font color="SIGNATURE_COLOR" style="font-size:13px;">function name(params):</font></b>`
- Body lines: `<font face="Courier New" color="#D0D0D0" style="font-size:11px;">` with `&amp;nbsp;` for indentation
- Use `&lt;br&gt;` for line breaks
- Escape special characters: `&amp;`, `&lt;`, `&gt;`, `&quot;`
- Set `verticalAlign=top;spacingTop=12;spacingLeft=15;align=left;` on the block style

## State Diagram

States and transitions showing system behavior.

### Shapes

| Element | Style |
|---------|-------|
| State | `rounded=1;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#DAE8FC;strokeColor=#6C8EBF;fontColor=#333333;fontStyle=1;arcSize=20;` |
| Initial State | `ellipse;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#333333;strokeColor=#333333;` |
| Final State | `ellipse;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#333333;strokeColor=#333333;` |
| Composite State | `rounded=1;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#D5E8D4;strokeColor=#82B366;fontColor=#333333;fontStyle=1;container=1;` |

### Transitions

```xml
<mxCell id="trans1" value="event [guard] / action" style="endArrow=classic;html=1;sketch=1;fontFamily=Kalam;strokeColor=#333333;strokeWidth=2;fontColor=#333333;" edge="1" parent="1" source="state1" target="state2">
  <mxGeometry relative="1" as="geometry"/>
</mxCell>
```

## Network Diagram

Network topology with devices and connections.

### Shapes

| Element | Style |
|---------|-------|
| Router | `shape=mxgraph.cisco.routers.router;sketch=1;fontFamily=Kalam;html=1;whiteSpace=wrap;fillColor=#1BA1E2;strokeColor=#006EAF;` |
| Switch | `shape=mxgraph.cisco.switches.switch;sketch=1;fontFamily=Kalam;html=1;whiteSpace=wrap;fillColor=#60A548;strokeColor=#4A8C34;` |
| Server | `shape=mxgraph.cisco.servers.standard_server;sketch=1;fontFamily=Kalam;html=1;whiteSpace=wrap;fillColor=#7B61FF;strokeColor=#5F49CC;` |
| Workstation | `shape=mxgraph.cisco.computers_and_peripherals.pc;sketch=1;fontFamily=Kalam;html=1;whiteSpace=wrap;fillColor=#FFB800;strokeColor=#D69E00;` |
| Firewall | `shape=mxgraph.cisco.firewalls.firewall;sketch=1;fontFamily=Kalam;html=1;whiteSpace=wrap;fillColor=#E6472A;strokeColor=#B83822;` |
| Cloud | `ellipse;shape=cloud;whiteSpace=wrap;html=1;sketch=1;fontFamily=Kalam;fillColor=#D5E8D4;strokeColor=#82B366;` |

### Network Links

```xml
<mxCell id="link1" style="endArrow=none;html=1;sketch=1;fontFamily=Kalam;strokeColor=#333333;strokeWidth=2;" edge="1" parent="1" source="router1" target="switch1">
  <mxGeometry relative="1" as="geometry"/>
</mxCell>
```

### Grouping

Use containers for network segments (VLANs, subnets, DMZ):

```xml
<mxCell id="dmz" value="DMZ" style="swimlane;startSize=25;fillColor=#F5F5F5;strokeColor=#666666;fontFamily=Kalam;fontStyle=1;fontColor=#333333;html=1;sketch=1;dashed=1;" vertex="1" parent="1">
  <mxGeometry x="50" y="50" width="300" height="200" as="geometry"/>
</mxCell>
```
