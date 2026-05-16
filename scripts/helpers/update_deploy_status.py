#!/usr/bin/env python3
"""
verdict-engine/scripts/helpers/update_deploy_status.py

deploy_status.md 自動更新 helper script.

Purpose:
  verdict_deploy.sh の Phase 2 完了後に、deploy_status.md の以下を institutional に更新:
    - YAML frontmatter (last_updated, total_deployed, layer_1_count)
    - Section 1 (Layer 1) table に新 entry 追加
    - Section 3 (Scheduled) から該当行を削除

Usage:
  python3 update_deploy_status.py \
      --add "065:weaviate:Weaviate:Weaviate B.V.:Vector Database:v1.1:46:B" \
      --add "066:nemo_guardrails:NeMo Guardrails:NVIDIA Corporation:..." \
      --commit-hash abc1234 \
      --deploy-date 2026-05-15

Format of --add argument (colon-separated):
  NNN:slug:platform:owner:category:framework_version:score:tier

Author: VERDICT Operations
Version: 1.0
"""

import argparse
import re
import sys
from datetime import date
from pathlib import Path
import yaml


DEPLOY_STATUS_PATH = Path.home() / "Desktop/VERDICT/verdict-engine/docs/deploy_status.md"


def parse_evaluation_entry(entry_str):
    """Parse colon-separated entry: NNN:slug:platform:owner:category:fw_version:score:tier"""
    parts = entry_str.split(":", 7)
    if len(parts) != 8:
        raise ValueError(f"Invalid entry format: {entry_str} (expected 8 colon-separated fields)")
    return {
        "nnn": parts[0],
        "slug": parts[1],
        "platform": parts[2],
        "owner": parts[3],
        "category": parts[4],
        "framework_version": parts[5],
        "score": parts[6],
        "tier": parts[7],
    }


def read_deploy_status(path):
    """Read deploy_status.md and split YAML frontmatter from body."""
    if not path.exists():
        raise FileNotFoundError(f"deploy_status.md not found: {path}")
    
    content = path.read_text(encoding="utf-8")
    
    # YAML frontmatter pattern: ---\n<yaml>\n---\n<body>
    match = re.match(r"^---\n(.*?)\n---\n(.*)$", content, re.DOTALL)
    if not match:
        raise ValueError("YAML frontmatter not found")
    
    yaml_str = match.group(1)
    body = match.group(2)
    
    frontmatter = yaml.safe_load(yaml_str)
    return frontmatter, body


def update_frontmatter(frontmatter, new_count, deploy_date, commit_hash):
    """Update YAML frontmatter metadata."""
    frontmatter["last_updated"] = deploy_date
    frontmatter["last_updated_commit"] = commit_hash
    
    current_total = frontmatter.get("total_deployed", 0)
    current_layer1 = frontmatter.get("layer_1_count", 0)
    
    frontmatter["total_deployed"] = current_total + new_count
    frontmatter["layer_1_count"] = current_layer1 + new_count
    
    return frontmatter


def update_layer1_table(body, entries, deploy_date):
    """Add new entries to Section 1 Layer 1 table."""
    # 既存 Layer 1 table の最終行を探す (table end の前)
    # Pattern: "| 064 | guardrails_ai | ... |" 形式の最後の行
    
    table_pattern = r"(\| \d{3} \| [^\|]+ \|[^\|]+\|[^\|]+\|[^\|]+\|[^\|]+\|[^\|]+\|[^\|]+\|[^\n]*\n)"
    
    # 各 entry を table row として生成
    new_rows = []
    for entry in entries:
        row = (
            f"| {entry['nnn']} | `{entry['slug']}` | {entry['platform']} | "
            f"{entry['owner']} | {entry['category']} | {entry['score']} | "
            f"{entry['tier']} | {deploy_date} | "
            f"Framework {entry['framework_version']} |\n"
        )
        new_rows.append(row)
    
    # Section 1 の table end (## 2. Layer 2 の直前) に追加
    section2_pattern = r"(\n## 2\. Layer 2)"
    match = re.search(section2_pattern, body)
    
    if not match:
        raise ValueError("Section 2 Layer 2 boundary not found")
    
    insert_pos = match.start()
    
    # Section 1 の最後の table row 直後に挿入
    # 単純化: section 2 直前に new_rows を挿入
    new_body = body[:insert_pos] + "".join(new_rows) + body[insert_pos:]
    
    return new_body


def remove_from_scheduled(body, nnns):
    """Section 3 (Scheduled) から該当 NNN の行を削除."""
    lines = body.split("\n")
    new_lines = []
    in_section_3 = False
    
    for line in lines:
        if line.startswith("## 3. Scheduled deploy"):
            in_section_3 = True
            new_lines.append(line)
            continue
        if line.startswith("## 4.") or line.startswith("## 5."):
            in_section_3 = False
            new_lines.append(line)
            continue
        
        if in_section_3:
            skip = False
            for nnn in nnns:
                if re.match(rf"^\| {nnn} \|", line):
                    skip = True
                    break
            if not skip:
                new_lines.append(line)
        else:
            new_lines.append(line)
    
    return "\n".join(new_lines)


def write_deploy_status(path, frontmatter, body):
    """Write back deploy_status.md with updated content."""
    yaml_str = yaml.dump(frontmatter, default_flow_style=False, sort_keys=False, allow_unicode=True)
    new_content = f"---\n{yaml_str}---\n{body}"
    path.write_text(new_content, encoding="utf-8")


def main():
    parser = argparse.ArgumentParser(
        description="Update deploy_status.md with new evaluation deployments"
    )
    parser.add_argument(
        "--add", action="append", required=True,
        help="Evaluation entry: NNN:slug:platform:owner:category:fw_version:score:tier"
    )
    parser.add_argument(
        "--commit-hash", default="pending",
        help="Commit hash of the deploy (default: 'pending')"
    )
    parser.add_argument(
        "--deploy-date", default=date.today().isoformat(),
        help="Deploy date (default: today)"
    )
    parser.add_argument(
        "--path", default=str(DEPLOY_STATUS_PATH),
        help="Path to deploy_status.md"
    )
    parser.add_argument(
        "--dry-run", action="store_true",
        help="Show changes without writing"
    )
    
    args = parser.parse_args()
    
    path = Path(args.path)
    
    try:
        # Parse entries
        entries = [parse_evaluation_entry(e) for e in args.add]
        print(f"[INFO] {len(entries)} entries to add:")
        for e in entries:
            print(f"  - #{e['nnn']} {e['slug']} ({e['platform']})")
        
        # Read current state
        frontmatter, body = read_deploy_status(path)
        print(f"[INFO] Current total_deployed: {frontmatter.get('total_deployed', 0)}")
        
        # Update frontmatter
        frontmatter = update_frontmatter(
            frontmatter,
            len(entries),
            args.deploy_date,
            args.commit_hash
        )
        print(f"[INFO] Updated total_deployed: {frontmatter['total_deployed']}")
        
        # Update Layer 1 table
        body = update_layer1_table(body, entries, args.deploy_date)
        
        # Remove from Scheduled section
        nnns = [e["nnn"] for e in entries]
        body = remove_from_scheduled(body, nnns)
        
        if args.dry_run:
            print("[DRY-RUN] No changes written")
            print(yaml.dump(frontmatter))
            return 0
        
        # Write back
        write_deploy_status(path, frontmatter, body)
        print(f"[OK] deploy_status.md updated: {path}")
        
        return 0
    except Exception as e:
        print(f"[ERROR] {e}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
