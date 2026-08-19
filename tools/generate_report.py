from pathlib import Path
import re

from reportlab.lib import colors
from reportlab.lib.enums import TA_CENTER
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import mm
from reportlab.platypus import (
    ListFlowable,
    ListItem,
    PageBreak,
    Paragraph,
    SimpleDocTemplate,
    Spacer,
)


ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "docs" / "planazo3_informe.md"
OUTPUT = ROOT / "docs" / "planazo3_informe.pdf"


def inline_markup(text: str) -> str:
    text = re.sub(r"`([^`]+)`", r"<font name='Courier'>\1</font>", text)
    text = re.sub(r"\*\*([^*]+)\*\*", r"<b>\1</b>", text)
    return text.replace("&", "&amp;") if "&amp;" not in text else text


def build_story() -> list:
    styles = getSampleStyleSheet()
    styles.add(ParagraphStyle(
        name="ReportTitle", parent=styles["Title"], fontName="Helvetica-Bold",
        fontSize=23, leading=28, alignment=TA_CENTER, textColor=colors.HexColor("#D94801"),
        spaceAfter=16,
    ))
    styles.add(ParagraphStyle(
        name="H2Report", parent=styles["Heading2"], fontName="Helvetica-Bold",
        fontSize=14, leading=18, textColor=colors.HexColor("#9A3412"), spaceBefore=12, spaceAfter=7,
    ))
    styles.add(ParagraphStyle(
        name="H3Report", parent=styles["Heading3"], fontName="Helvetica-Bold",
        fontSize=11, leading=14, textColor=colors.HexColor("#C2410C"), spaceBefore=9, spaceAfter=4,
    ))
    styles.add(ParagraphStyle(
        name="BodyReport", parent=styles["BodyText"], fontName="Helvetica",
        fontSize=9.5, leading=13.5, spaceAfter=7,
    ))
    styles.add(ParagraphStyle(
        name="MetaReport", parent=styles["BodyText"], fontSize=9, leading=13,
        textColor=colors.HexColor("#555555"), alignment=TA_CENTER, spaceAfter=4,
    ))
    story = []
    pending_bullets = []

    def flush_bullets():
        nonlocal pending_bullets
        if pending_bullets:
            story.append(ListFlowable(
                [ListItem(Paragraph(inline_markup(item), styles["BodyReport"]), leftIndent=12)
                 for item in pending_bullets], bulletType="bullet", start="circle", leftIndent=16,
            ))
            story.append(Spacer(1, 3))
            pending_bullets = []

    for raw_line in SOURCE.read_text(encoding="utf-8").splitlines():
        line = raw_line.strip()
        if not line:
            flush_bullets()
            continue
        if line.startswith("# "):
            flush_bullets()
            story.append(Paragraph(inline_markup(line[2:]), styles["ReportTitle"]))
        elif line.startswith("## "):
            flush_bullets()
            story.append(Paragraph(inline_markup(line[3:]), styles["H2Report"]))
        elif line.startswith("### "):
            flush_bullets()
            story.append(Paragraph(inline_markup(line[4:]), styles["H3Report"]))
        elif line.startswith("- "):
            pending_bullets.append(line[2:])
        elif re.match(r"^\d+\. ", line):
            flush_bullets()
            story.append(Paragraph(inline_markup(line), styles["BodyReport"]))
        else:
            flush_bullets()
            style = styles["MetaReport"] if line.startswith("**") else styles["BodyReport"]
            story.append(Paragraph(inline_markup(line), style))
    flush_bullets()
    return story


def add_page_number(canvas, doc):
    canvas.saveState()
    canvas.setFont("Helvetica", 8)
    canvas.setFillColor(colors.HexColor("#777777"))
    canvas.drawRightString(A4[0] - 18 * mm, 12 * mm, f"Planazo | Pagina {doc.page}")
    canvas.restoreState()


def main():
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    document = SimpleDocTemplate(
        str(OUTPUT), pagesize=A4, rightMargin=18 * mm, leftMargin=18 * mm,
        topMargin=16 * mm, bottomMargin=18 * mm, title="Planazo - Informe tecnico",
        author="Analisis del proyecto",
    )
    document.build(build_story(), onFirstPage=add_page_number, onLaterPages=add_page_number)
    print(OUTPUT)


if __name__ == "__main__":
    main()