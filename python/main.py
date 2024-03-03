import argparse
import Server

def start(srv):
    pass

def stop(srv):
    pass


def status(srv):
    pass


def console(srv):
    pass


def restart(srv):
    pass

def install(srv):
    server = Server(srv.name, srv.version, srv.path, srv.type)
    server.install()

def main(args: argparse.Namespace):
    if args.start:
        start(args.server_name)
    elif args.stop:
        stop(args.server_name)
    elif args.restart:
        restart(args.server_name)
    elif args.status:
        status(args.server_name)
    elif args.console:
        console(args.server_name)
    elif args.install:
        for srv in args.server_name:
            install(srv)
    else:
        status(args.server_name)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        prog='mctl',
        description='A tool for managing your Minecraft server.'
    )
    parser.add_argument('server name', help='The name of the server.')
    parser.add_argument('-s', "--start", help='Start the server.')
    parser.add_argument("-r", '--restart', help='Restart the server.')
    parser.add_argument("-stat", '--status', help='Get the status of the server.')
    parser.add_argument("-c", '--console', help='Open the server console.')
    parser.add_argument("-i", '--install', help='Install the server.')
    args = parser.parse_args()
    print(args)
    #main(args)