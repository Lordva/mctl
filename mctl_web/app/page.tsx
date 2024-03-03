
export default function Home() {
  const nb_player = 5;
  return (
    <div className="hero min-h-screen bg-base-200">
      <div className="text-center hero-content">
        <div className="max-w-md">
          <h1 className="mb-5 text-5xl font-bold">
            Welcome to Mctl
          </h1>
          <p className="py-6">
            Mctl is a web interface for managing Minecraft servers. <br/> {nb_player} players are currently connected.
          </p>
          <div className="flex justify-center gap-2">
            <a href="/dashboard" className="btn btn-primary">Open dashboard</a>
            <a href="/about" className="btn btn-secondary">Learn more</a>
          </div>
        </div>
      </div>
    </div>
  );
}
