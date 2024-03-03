import { redirect } from "next/navigation";
import { getServerSession } from "next-auth";
import ServerListTable from "../components/server-list-table";

export default async function DashboardRoute(){
    const session = await getServerSession();
    if(!session){
        redirect("/api/auth/signin");
    }

    return (
        <div className="bg-base-100 drawer lg:drawer-open">
            <input id="drawer" type="checkbox" className="drawer-toggle" />
            <div className="drawer-content">
                <h1 className="max-w-[100vw] px-6 pt-5 xl:pr-2 prose-lg font-bold">Your servers</h1>
                <div className="max-w-[100vw] px-6 pb-16 xl:pr-2">
                    <div className="flex flex-col-reverse justify-between gap-6 pt-7">
                        <div className="">
                        < ServerListTable />
                        </div>
                    </div>
                </div>
            </div>
            <div className="drawer-side z-40 5rem">
                <aside className="bg-base-300 min-h-screen w-80">
                    <div className="h-4"></div>
                    <ul className="menu px-4 py-0">

                    </ul>
                </aside>
            </div>
            
        </div>
    )
}