#!/usr/bin/env python3
import sys
import json


def hex_to_rgb(hex_color):
    h = hex_color.lstrip("#")
    return tuple(int(h[i:i+2], 16) for i in (0, 2, 4))


def rgb_to_hex(r, g, b):
    return "#{:02X}{:02X}{:02X}".format(r, g, b)


def relative_luminance(r, g, b):
    def linearize(c):
        c = c / 255.0
        return c / 12.92 if c <= 0.04045 else ((c + 0.055) / 1.055) ** 2.4
    return 0.2126 * linearize(r) + 0.7152 * linearize(g) + 0.0722 * linearize(b)


def contrast_ratio(hex1, hex2):
    l1 = relative_luminance(*hex_to_rgb(hex1))
    l2 = relative_luminance(*hex_to_rgb(hex2))
    lighter = max(l1, l2)
    darker = min(l1, l2)
    return (lighter + 0.05) / (darker + 0.05)


def best_text_color(bg_hex):
    white_ratio = contrast_ratio(bg_hex, "#FFFFFF")
    black_ratio = contrast_ratio(bg_hex, "#333333")
    return "#FFFFFF" if white_ratio >= black_ratio else "#333333"


def ensure_contrast(bg_hex, text_hex="#333333", min_ratio=7.0):
    ratio = contrast_ratio(bg_hex, text_hex)
    result = {"background": bg_hex, "text": text_hex, "ratio": round(ratio, 2), "passes_wcag_aaa": ratio >= min_ratio}
    if not result["passes_wcag_aaa"]:
        result["suggested_background"] = adjust_for_contrast(bg_hex, text_hex, min_ratio)
        result["suggested_ratio"] = round(contrast_ratio(result["suggested_background"], text_hex), 2)
    return result


def adjust_for_contrast(bg_hex, target_text_hex, min_ratio=4.5):
    r, g, b = hex_to_rgb(bg_hex)
    lum_bg = relative_luminance(r, g, b)
    lum_text = relative_luminance(*hex_to_rgb(target_text_hex))
    lighten = lum_bg > lum_text
    for step in range(1, 256):
        factor = step / 255.0
        if lighten:
            nr = int(r + (255 - r) * factor)
            ng = int(g + (255 - g) * factor)
            nb = int(b + (255 - b) * factor)
        else:
            nr = int(r * (1 - factor))
            ng = int(g * (1 - factor))
            nb = int(b * (1 - factor))
        candidate = rgb_to_hex(nr, ng, nb)
        if contrast_ratio(candidate, target_text_hex) >= min_ratio:
            return candidate
    return bg_hex


def check_palette(colors, text_hex="#333333"):
    results = []
    for name, bg in colors.items():
        result = ensure_contrast(bg, text_hex)
        result["name"] = name
        results.append(result)
    return results


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage:")
        print("  contrast-check.py <hex>                    - check bg against default dark text (#333333)")
        print("  contrast-check.py <hex> <text_hex>         - check bg against specific text color")
        print("  contrast-check.py --ratio <hex1> <hex2>    - contrast ratio between two colors")
        print("  contrast-check.py --palette <json>         - check multiple colors (all use dark text)")
        print()
        print("Note: Text color is fixed based on canvas background. On white canvas, use #333333.")
        print("      Box backgrounds are adjusted to contrast with the fixed text color.")
        print()
        print("Examples:")
        print('  contrast-check.py "#1BA1E2"')
        print('  contrast-check.py "#1BA1E2" "#FFFFFF"')
        print('  contrast-check.py --ratio "#1BA1E2" "#333333"')
        print('  contrast-check.py --palette \'{"blue":"#1BA1E2","amber":"#FFB800"}\'')
        sys.exit(1)

    if sys.argv[1] == "--ratio":
        print(f"{contrast_ratio(sys.argv[2], sys.argv[3]):.2f}")
    elif sys.argv[1] == "--palette":
        palette = json.loads(sys.argv[2])
        for r in check_palette(palette):
            status = "PASS" if r["passes_wcag_aaa"] else "FAIL"
            line = f"[{status}] {r['name']:20s} bg={r['background']}  text={r['text']}  ratio={r['ratio']}"
            if "suggested_background" in r:
                line += f"  -> use bg={r['suggested_background']} (ratio={r['suggested_ratio']})"
            print(line)
    else:
        text_hex = sys.argv[2] if len(sys.argv) > 2 else "#333333"
        result = ensure_contrast(sys.argv[1], text_hex)
        print(json.dumps(result, indent=2))
