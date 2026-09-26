#!/usr/bin/env python3
import sys
import json
import math


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


def rgb_to_xyz(r, g, b):
    def linearize(c):
        c = c / 255.0
        return c / 12.92 if c <= 0.04045 else ((c + 0.055) / 1.055) ** 2.4
    rl, gl, bl = linearize(r), linearize(g), linearize(b)
    x = 0.4124564 * rl + 0.3575761 * gl + 0.1804375 * bl
    y = 0.2126729 * rl + 0.7151522 * gl + 0.0721750 * bl
    z = 0.0193339 * rl + 0.1191920 * gl + 0.9503041 * bl
    return x * 100, y * 100, z * 100


def xyz_to_lab(x, y, z):
    xn, yn, zn = 95.047, 100.000, 108.883
    def f(t):
        return t ** (1/3) if t > 0.008856 else (7.787 * t) + (16/116)
    fx, fy, fz = f(x/xn), f(y/yn), f(z/zn)
    L = 116 * fy - 16
    a = 500 * (fx - fy)
    b_val = 200 * (fy - fz)
    return L, a, b_val


def hex_to_lab(hex_color):
    return xyz_to_lab(*rgb_to_xyz(*hex_to_rgb(hex_color)))


def delta_e(hex1, hex2):
    L1, a1, b1 = hex_to_lab(hex1)
    L2, a2, b2 = hex_to_lab(hex2)
    return math.sqrt((L1 - L2)**2 + (a1 - a2)**2 + (b1 - b2)**2)


def best_text_color(bg_hex):
    white_ratio = contrast_ratio(bg_hex, "#FFFFFF")
    black_ratio = contrast_ratio(bg_hex, "#333333")
    return "#FFFFFF" if white_ratio >= black_ratio else "#333333"


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


def check_theme(theme):
    bg = theme["background"]
    text = theme["text_color"]
    accents = theme.get("accents", {})
    min_contrast = theme.get("min_contrast", 4.5)
    min_distance = theme.get("min_color_distance", 20)

    results = {"contrast": [], "distinctness": [], "background_visibility": [], "summary": {}}
    all_pass = True

    for name, fill in accents.items():
        bt = best_text_color(fill)
        ratio = contrast_ratio(fill, bt)
        passes = ratio >= min_contrast
        entry = {
            "name": name,
            "fill": fill,
            "best_text": bt,
            "ratio": round(ratio, 2),
            "passes": passes,
        }
        if not passes:
            entry["suggested_fill"] = adjust_for_contrast(fill, bt, min_contrast)
            entry["suggested_ratio"] = round(contrast_ratio(entry["suggested_fill"], bt), 2)
            all_pass = False
        results["contrast"].append(entry)

    bg_ratio = contrast_ratio(bg, text)
    results["background_text_contrast"] = {
        "background": bg,
        "text": text,
        "ratio": round(bg_ratio, 2),
        "passes": bg_ratio >= 4.5,
    }

    for name, fill in accents.items():
        bg_de = delta_e(fill, bg)
        entry = {
            "name": name,
            "fill": fill,
            "background": bg,
            "delta_e": round(bg_de, 1),
            "passes": bg_de >= 15,
        }
        if not entry["passes"]:
            all_pass = False
        results["background_visibility"].append(entry)

    names = list(accents.keys())
    for i in range(len(names)):
        for j in range(i + 1, len(names)):
            de = delta_e(accents[names[i]], accents[names[j]])
            passes = de >= min_distance
            entry = {
                "pair": f"{names[i]} vs {names[j]}",
                "colors": f"{accents[names[i]]} vs {accents[names[j]]}",
                "delta_e": round(de, 1),
                "passes": passes,
            }
            if not passes:
                all_pass = False
            results["distinctness"].append(entry)

    results["summary"] = {
        "all_pass": all_pass,
        "total_accents": len(accents),
        "contrast_failures": sum(1 for c in results["contrast"] if not c["passes"]),
        "distinctness_failures": sum(1 for d in results["distinctness"] if not d["passes"]),
        "bg_visibility_failures": sum(1 for v in results["background_visibility"] if not v["passes"]),
    }
    return results


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage:")
        print('  complement-check.py <theme_json>')
        print()
        print("Theme JSON format:")
        print('  {')
        print('    "background": "#fdf6e3",')
        print('    "text_color": "#586e75",')
        print('    "min_contrast": 4.5,')
        print('    "min_color_distance": 20,')
        print('    "accents": {')
        print('      "blue": "#268bd2",')
        print('      "green": "#859900"')
        print('    }')
        print('  }')
        print()
        print("Checks:")
        print("  1. Each accent fill vs text_color (WCAG contrast)")
        print("  2. Each accent pair (perceptual color distance, deltaE >= 20)")
        print("  3. Background vs text_color contrast")
        sys.exit(1)

    theme = json.loads(sys.argv[1])
    results = check_theme(theme)

    print("=" * 70)
    print("THEME COMPLEMENT VALIDATION")
    print("=" * 70)
    print(f"Background: {theme['background']}  |  Text: {theme['text_color']}")
    bg_info = results["background_text_contrast"]
    bg_status = "PASS" if bg_info["passes"] else "FAIL"
    print(f"Background-Text Contrast: {bg_info['ratio']}:1 [{bg_status}]")
    print()

    print("ACCENT LABEL CONTRAST (fill vs best text color)")
    print("-" * 70)
    for c in results["contrast"]:
        status = "PASS" if c["passes"] else "FAIL"
        line = f"  [{status}] {c['name']:20s} fill={c['fill']}  text={c['best_text']}  ratio={c['ratio']}"
        if not c["passes"]:
            line += f"  -> use fill={c['suggested_fill']} (ratio={c['suggested_ratio']})"
        print(line)
    print()

    print("BACKGROUND VISIBILITY (fill vs canvas background, deltaE >= 15)")
    print("-" * 70)
    for v in results["background_visibility"]:
        status = "PASS" if v["passes"] else "FAIL"
        print(f"  [{status}] {v['name']:20s} fill={v['fill']}  bg={v['background']}  deltaE={v['delta_e']}")
    print()

    print("COLOR DISTINCTNESS (deltaE >= 20)")
    print("-" * 70)
    for d in results["distinctness"]:
        status = "PASS" if d["passes"] else "FAIL"
        print(f"  [{status}] {d['pair']:35s}  deltaE={d['delta_e']}")
    print()

    s = results["summary"]
    icon = "ALL PASS" if s["all_pass"] else "FAILURES FOUND"
    print(f"Summary: {icon} | {s['total_accents']} accents, "
          f"{s['contrast_failures']} contrast failures, "
          f"{s['bg_visibility_failures']} bg visibility failures, "
          f"{s['distinctness_failures']} distinctness failures")
