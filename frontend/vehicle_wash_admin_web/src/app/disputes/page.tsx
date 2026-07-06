export default function DisputesPage() {
  return (
    <div className="animate-in fade-in slide-in-from-bottom-4 duration-700">
      <h1 className="text-3xl font-bold tracking-tight text-white mb-2">Disputes</h1>
      <p className="text-gray-400 mb-8">Manage customer and washer disputes.</p>
      
      <div className="glass-panel rounded-2xl p-8 border-white/10 flex items-center justify-center min-h-[400px]">
        <div className="text-center">
          <div className="w-16 h-16 rounded-full bg-orange-500/10 flex items-center justify-center mx-auto mb-4 border border-orange-500/20">
            <span className="text-orange-400 text-2xl">⚠️</span>
          </div>
          <h2 className="text-xl font-medium text-white mb-2">Disputes Resolution Center</h2>
          <p className="text-gray-400">This module is under development.</p>
        </div>
      </div>
    </div>
  );
}
