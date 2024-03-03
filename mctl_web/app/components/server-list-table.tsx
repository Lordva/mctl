import { PrismaClient } from "@prisma/client";

export default async function ServerListTable(){


    const prisma = new PrismaClient();
    const minecraftContainers = await prisma.server.findMany();

    return (
        <div className="table">
            <table className="table w-full">
                <thead>
                    <tr>
                        <th>Server Name</th>
                        <th>Server IP</th>
                        <th>Server Port</th>
                    </tr>
                </thead>
                <tbody>
                {(minecraftContainers).map(container => (
                        <tr key={container.id}>
                            <td>{container.name}</td>
                            <td>{container.ip}</td>
                            <td>{container.port}</td>
                            <td><button className="btn btn-outline btn-primary btn-sm">Manage</button></td>
                        </tr>
                    ))}
                    <tr><td colSpan={4}><a className="divider divider-primary"></a></td></tr>
                    <tr key="addServer">
                        <td colSpan={4}><a href="../create-server" className="btn btn-accent btn-block">
                            <svg xmlns="http://www.w3.org/2000/svg" className="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path d="M4 12H20M12 4V20" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>Add Server</a></td>
                    </tr>
                </tbody>
            </table>
        </div>
    );
}
