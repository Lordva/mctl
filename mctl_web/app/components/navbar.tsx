"use client";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { signIn, signOut, useSession } from "next-auth/react";

function AuthButton(){
  const { data: session } = useSession();
  if(session){
    return (
      <div className="flex-none">
        <div className="dropdown dropdown-end">
          <div tabIndex={0} role="button" className="btn btn-ghost">
            <div>
              <a>{session.user?.name}</a>
            </div>
            <div className="w-10 rounded-full avatar">
              <img alt="avatar" src={session.user?.image} />
            </div>
            <ul tabIndex={0} className="mt-3 z-[1] p-2 shadow menu menu-sm dropdown-content bg-base-100 rounded-box w-52">
              <li>
                <a className="justify-between">
                  Profile
                </a>
              </li>
              <li><a>Settings</a></li>
              <li><a onClick={() => signOut()}>Logout</a></li> {/* Call the signOut function */}
            </ul>
          </div>
        </div>
      </div>
    )
  } else {
    return <button className="btn btn-ghost" onClick={() => signIn()}>Sign in</button>
  }
}

export default function Navbar(){
  const pathName = usePathname();
  return (
    <div className="navbar bg-base-100">
      <div className="navbar-start">
        <a className="btn btn-ghost text-xl">Mctl</a>
      </div>
      <div className="navbar-middle">
        <Link href="/" className="btn btn-ghost">Home</Link>
        <Link href="/dashboard" className="btn btn-ghost">Dashboard</Link>
        <Link href="/about" className="btn btn-ghost">About</Link>
        <Link href="/contat" className="btn btn-ghost">Contact</Link>
      </div>
      <div className="navbar-end">
        <AuthButton />
      </div>
    </div>
  )
}
