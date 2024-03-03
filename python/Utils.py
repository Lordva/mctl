import requests


def check_version(version: str) -> bool:
    """Check if the given version is a valid minecraft version"""
    if not version.startswith("1."):
        return False
    version = version.split(".")
    latest_version = int(get_version_manifest()["latest"]["release"].split("."))
    if 7 <= int(version[1]) <= latest_version[1]:
        if len(version) == 3:
            if 0 <= int(version[2]) <= latest_version[2]:
                return True
            else:
                return False
        return True
    return False


def check_type(type: str) -> bool:
    """Check if the given type is a valid minecraft server type"""
    return type in ["vanilla", "paper", "forge", "fabric"]

def get_version_manifest() -> dict:
    """Get the version manifest from the Mojang API"""
    return requests.get("https://launchermeta.mojang.com/mc/game/version_manifest.json").json()