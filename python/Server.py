import os
import requests
from Utils import check_version, check_type, get_version_manifest


class Server():
    def __init__(self, name: str, version: str, path: str ,type="vanilla") -> None:
        self._name = str(name)
        if check_version(version):
            self._version = version
        else:
            raise ValueError("Invalid version")
        if check_type(type):
            self._type = type
        else:
            raise ValueError("Invalid server type")
        self._path = path

    def install(self):
        try:
            self._check_rights()
            self._check_path()
            self._java_install()
        except Exception as e:
            raise e
        os.chdir(self._path + "/" + self._name)
        server_jar = get_version_manifest()["versions"][self._version]["url"]
        server_jar = requests.get(server_jar).json()["downloads"]["server"]["url"]


    def _check_rights(self):
        if not os.getuid() == 0:
            raise Exception("You need to be root to install a server")
        
    def _check_path(self):
        if os.path.exists(self._path + "/" + self._name):
            raise Exception("Server already exists")
        if not os.path.exists(self._path):
            os.mkdir(self._path)

    def _java_install(self):
        if not os.system("java -version") == 0:
            raise Exception("Java is not installed")

                

    def start(self):
        pass

    def stop(self):
        pass

    def restart(self):
        pass

    def status(self):
        pass

    def console(self):
        pass


class Proxy(Server):
    def __init__(self, name: str, version: str, path: str, type="bungeecord") -> None:
        super().__init__(name, version, path, type)

class Forge(Server):
    def __init__(self, name: str, version: str, path: str, type="forge") -> None:
        super().__init__(name, version, path, type)

class Fabric(Server):
    def __init__(self, name: str, version: str, path: str, type="fabric") -> None:
        super().__init__(name, version, path, type)

class Paper(Server):
    def __init__(self, name: str, version: str, path: str, type="paper") -> None:
        super().__init__(name, version, path, type)

class Spigot(Server):
    def __init__(self, name: str, version: str, path: str, type="spigot") -> None:
        super().__init__(name, version, path, type)

