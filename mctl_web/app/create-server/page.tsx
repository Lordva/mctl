import { PrismaClient } from '@prisma/client';

export default async function Page() {
    
    const prisma = new PrismaClient();

    const createServer = async (formData: FormData) => {
        "use server";
        const serverName = formData.get("serverName")?.toString();
        const serverVersion = formData.get("serverVersion")?.toString();
        const whitelist = formData.get("whitelist") === "on" ? true : false;
        const difficulty = formData.get("difficulty")?.toString();
        const modloader = formData.get("modloader")?.toString();
        if (!serverName || !serverVersion || !whitelist || !difficulty || !modloader){
            throw new Error("Missing required fields");
        }
        prisma.server.create({
            data: {
                name: serverName,
                version: serverVersion,
                whitelist: whitelist,
                modloader: modloader,
                ip: "1234",
                port: 25565,
            },
        })
    }


    return (
        <div className="bg-base-100 px-6 pb-10 xl:pr-2 gap-6 xl:flex-row">
            <div className="prose w-full pt-10">
                <h1>Create Server</h1>
                <p>Create a new minecraft server instance</p>
                <div className="card shadow-xl bg-base-200 card-body">
                <form action={createServer}>
                    <div className="space-y-4">
                        <label className="input input-bordered flex items-center gap-2">
                            <input type="text" name="serverName" placeholder="Server Name"/>
                        </label>
                        <label className="input input-bordered flex items-center gap-2">
                            <input type="text" name="serverVersion" placeholder="Version"/>
                        </label>
                        <label className="cursor-pointer label">
                            <span className="label-text">Enable whitelist</span>
                            <input type="checkbox" name="whitelist" className="toggle toggle-accent"/>
                        </label>
                        <div className="flex items-center gap-2">
                            <select name="difficulty" className="select select-primary w-full max-w-xs">
                                <option value="Vanilla">Peacefull</option>
                                <option value="forge">Easy</option>
                                <option value="fabric">Normal</option>
                                <option value="spigot">Hard</option>
                                <option value="paper">Hardcore</option>
                            </select>
                            <select name="modloader" className="select select-primary w-full max-w-xs">
                                <option value="Vanilla">Vanilla</option>
                                <option value="forge">Forge</option>
                                <option value="fabric">Fabric</option>
                                <option value="spigot">Spigot</option>
                                <option value="paper">Paper</option>
                            </select>
                        </div>
                        <button className="btn btn-primary w-full" type="submit">Create Server</button>
                    </div>
                </form>
            </div>
            </div>
        </div>
    )
}