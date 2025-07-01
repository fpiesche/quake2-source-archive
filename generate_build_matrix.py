import json
import os
from pathlib import Path
import re

build_platforms = [
    {"runner": "windows-latest", "arch": "i386", "platform_name": "Windows x86"},
    {"runner": "windows-latest", "arch": "x86_64", "platform_name": "Windows x86_64"},
    {"runner": "ubuntu-latest", "arch": "i386", "platform_name": "Linux x86"},
    {"runner": "ubuntu-latest", "arch": "x86_64", "platform_name": "Linux x86_64"},
    {"runner": "ubuntu-latest", "arch": "x86_64", "platform_name": "wasm"},
    {"runner": "macos-13", "arch": "x86_64", "platform_name": "macOS x86_64"},
    {"runner": "ubuntu-24.04-arm", "arch": "aarch64", "platform_name": "Linux aarch64"},
    {"runner": "macos-latest", "arch": "aarch64", "platform_name": "macOS aarch64"},
]

def get_matrix_items(mod_name: str) -> str:
    items = []
    for target in build_platforms:
        items.append({"name": mod_name, "runner": target["runner"], "arch": target["arch"], "platform_name": target["platform_name"]})
    return items


def get_mod_name(item: str) -> str:
    mod_dir = Path("sources")
    valid_mod_names = [item.name for item in mod_dir.iterdir() if item.is_dir()]

    item_path = Path(item)

    if item_path.name in valid_mod_names:
        return item_path.name
    else:
        if not item_path.is_relative_to("sources"):
            return None
        else:
            mod_name = item_path.parents[-3].stem
            if mod_name in valid_mod_names:
                return mod_name


if __name__ == "__main__":
    mods_to_build = [get_mod_name(item) for item in re.split(r'[;:,\s]+', os.environ.get("MODS", ""))]

    if not mods_to_build or mods_to_build == [""]:
        mod_dir = Path("sources")
        mods_to_build = [item.name for item in mod_dir.iterdir() if item.is_dir()]

    matrix = []
    for mod in mods_to_build:
        if mod not in [item["name"] for item in matrix]:
            matrix += get_matrix_items(mod)

    print(json.dumps(matrix))
