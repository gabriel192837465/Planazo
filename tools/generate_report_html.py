from html import escape
from pathlib import Path
import re


ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "docs" / "planazo3_informe.md"
OUTPUT = ROOT / "docs" / "planazo3_informe.html"


def inline_markup(text):
    text = escape(text)
    text = re.sub(r"`([^`]+)`", r"<code>\1</code>", text)
    text = re.sub(r"\*\*([^*]+)\*\*", r"<strong>\1</strong>", text)
    return text


def convert():
    output = ["""<!doctype html><html lang=\"es\"><head><meta charset=\"utf-8\"><title>Planazo - Informe tecnico</title><style>
@page{size:A4;margin:16mm 18mm 18mm}body{font-family:Georgia,serif;color:#202124;line-height:1.45;font-size:11pt}h1{font-family:Arial,sans-serif;color:#d94801;text-align:center;font-size:28pt;margin:0 0 20pt}h2{font-family:Arial,sans-serif;color:#9a3412;font-size:17pt;border-bottom:1px solid #f0b08a;padding-bottom:4pt;margin-top:22pt}h3{font-family:Arial,sans-serif;color:#c2410c;font-size:13pt;margin-top:16pt}p{margin:0 0 9pt}ul{margin-top:0;padding-left:22pt}li{margin-bottom:5pt}code{font-family:Consolas,monospace;background:#fff1eb;padding:1px 3px}strong{font-family:Arial,sans-serif}.meta{text-align:center;color:#666;font-family:Arial,sans-serif;font-size:10pt} .page-number{position:fixed;bottom:-12mm;right:0;color:#777;font:9pt Arial,sans-serif}</style></head><body>"""]
    in_list = False
    for raw_line in SOURCE.read_text(encoding="utf-8").splitlines():
        line = raw_line.strip()
        if line.startswith("# "):
            output.append(f"<h1>{inline_markup(line[2:])}</h1>")
        elif line.startswith("## "):
            output.append(f"<h2>{inline_markup(line[3:])}</h2>")
        elif line.startswith("### "):
            output.append(f"<h3>{inline_markup(line[4:])}</h3>")
        elif line.startswith("- "):
            if not in_list:
                output.append("<ul>")
                in_list = True
            output.append(f"<li>{inline_markup(line[2:])}</li>")
        elif re.match(r"^\d+\. ", line):
            if in_list:
                output.append("</ul>")
                in_list = False
            output.append(f"<p>{inline_markup(line)}</p>")
        elif not line:
            if in_list:
                output.append("</ul>")
                in_list = False
        else:
            if in_list:
                output.append("</ul>")
                in_list = False
            class_name = " class=\"meta\"" if line.startswith("**") else ""
            output.append(f"<p{class_name}>{inline_markup(line)}</p>")
    if in_list:
        output.append("</ul>")
    output.append('<div class="page-number">Planazo | Informe tecnico</div></body></html>')
    OUTPUT.write_text("\n".join(output), encoding="utf-8")
    print(OUTPUT)


if __name__ == "__main__":
    convert()