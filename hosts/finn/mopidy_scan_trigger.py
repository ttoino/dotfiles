import json
import os
import subprocess
import sys
import urllib.request
import xml.etree.ElementTree as ET
from pathlib import Path

CONFIG_PATH = (
    Path(os.environ.get("XDG_CONFIG_HOME", str(Path.home() / ".config")))
    / "syncthing"
    / "config.xml"
)
STATE_DIR = (
    Path(
        os.environ.get("XDG_STATE_HOME", str(Path.home() / ".local" / "state"))
    )
    / "mopidy-scan"
)
STATE_FILE = STATE_DIR / "last-state"
GUI_URL = "http://127.0.0.1:8384"
FOLDER_ID = "music"
IDLE = "idle"


def main() -> None:
    if not CONFIG_PATH.exists():
        sys.exit(0)

    try:
        tree = ET.parse(CONFIG_PATH)
        gui = tree.find(".//gui/apikey")
        if gui is None or gui.text is None:
            sys.exit(0)
        api_key = gui.text
    except (ET.ParseError, FileNotFoundError):
        sys.exit(0)

    try:
        req = urllib.request.Request(
            f"{GUI_URL}/rest/db/status?folder={FOLDER_ID}",
            headers={"X-API-Key": api_key},
        )
        with urllib.request.urlopen(req, timeout=10) as resp:
            data = json.loads(resp.read())
        current_state = data.get("state", IDLE)
    except (OSError, ValueError):
        sys.exit(0)

    STATE_DIR.mkdir(parents=True, exist_ok=True)
    last_state = STATE_FILE.read_text().strip() if STATE_FILE.exists() else ""

    if current_state == IDLE and last_state not in (IDLE, ""):
        subprocess.run(
            ["systemctl", "--user", "start", "mopidy-scan.service"],
            check=False,
        )

    STATE_FILE.write_text(current_state)


if __name__ == "__main__":
    main()
