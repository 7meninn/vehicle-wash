import { Search, Filter, ShieldCheck, ShieldAlert } from 'lucide-react';

export default function WashersPage() {
  const washers = [
    { id: 'WSH-1021', name: 'Rahul Sharma', phone: '+91 98765 43220', location: 'Delhi NCR', joined: '10 Jan 2026', status: 'APPROVED', kyc: 'VERIFIED', rating: '4.91', jobs: 427 },
    { id: 'WSH-1022', name: 'Amit Kumar', phone: '+91 98765 43221', location: 'Delhi NCR', joined: '15 Jan 2026', status: 'APPROVED', kyc: 'VERIFIED', rating: '4.88', jobs: 382 },
    { id: 'WSH-1023', name: 'Suresh Patil', phone: '+91 98765 43222', location: 'Mumbai', joined: '20 Jun 2026', status: 'UNDER_REVIEW', kyc: 'PENDING', rating: 'N/A', jobs: 0 },
    { id: 'WSH-1024', name: 'Vikash Yadav', phone: '+91 98765 43223', location: 'Bangalore', joined: '05 May 2026', status: 'SUSPENDED', kyc: 'VERIFIED', rating: '4.1', jobs: 120 },
    { id: 'WSH-1025', name: 'Deepak Verma', phone: '+91 98765 43224', location: 'Pune', joined: '02 Jul 2026', status: 'APPROVED', kyc: 'VERIFIED', rating: '4.75', jobs: 45 },
  ];

  return (
    <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
      <header className="flex flex-col md:flex-row md:items-end justify-between gap-4">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-white">Washer Management</h1>
          <p className="text-gray-400 mt-1">Manage washers, approvals, and performance.</p>
        </div>
        
        <div className="flex gap-3">
          <div className="relative">
            <Search className="w-4 h-4 absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
            <input 
              type="text" 
              placeholder="Search washers..." 
              className="bg-slate-900 border border-white/10 text-sm rounded-lg pl-9 pr-4 py-2 text-white placeholder:text-gray-500 focus:outline-none focus:ring-2 focus:ring-purple-500/50 w-64 transition-all"
            />
          </div>
          <button className="flex items-center space-x-2 bg-slate-800 border border-white/10 px-4 py-2 rounded-lg hover:bg-slate-700 transition-colors text-sm font-medium">
            <Filter className="w-4 h-4" />
            <span>Filter</span>
          </button>
        </div>
      </header>

      <div className="glass-panel rounded-2xl border-white/10 overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-sm text-left">
            <thead className="text-xs text-gray-400 uppercase bg-slate-900/80 border-b border-white/10">
              <tr>
                <th className="px-6 py-4 font-medium">Washer Info</th>
                <th className="px-6 py-4 font-medium">Location</th>
                <th className="px-6 py-4 font-medium">Metrics</th>
                <th className="px-6 py-4 font-medium">KYC & Status</th>
                <th className="px-6 py-4 font-medium text-right">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-white/5">
              {washers.map((washer) => (
                <tr key={washer.id} className="hover:bg-white/5 transition-colors group">
                  <td className="px-6 py-4">
                    <div className="flex items-center space-x-3">
                      <div className="w-9 h-9 rounded-full bg-gradient-to-br from-purple-500 to-pink-600 flex items-center justify-center text-white font-bold text-sm">
                        {washer.name.charAt(0)}
                      </div>
                      <div>
                        <div className="font-medium text-white flex items-center space-x-2">
                          <span>{washer.name}</span>
                          <span className="text-[10px] text-gray-500 bg-white/5 px-1.5 py-0.5 rounded">{washer.id}</span>
                        </div>
                        <div className="text-xs text-gray-400">{washer.phone}</div>
                      </div>
                    </div>
                  </td>
                  <td className="px-6 py-4 text-gray-300">
                    {washer.location}
                  </td>
                  <td className="px-6 py-4">
                    <div className="text-sm">
                      <span className="text-yellow-400 font-medium">{washer.rating}</span> {washer.rating !== 'N/A' && <span className="text-gray-500 text-xs">★</span>}
                    </div>
                    <div className="text-xs text-gray-400">{washer.jobs} jobs</div>
                  </td>
                  <td className="px-6 py-4">
                    <div className="flex flex-col space-y-1.5">
                      <span className={`inline-flex w-fit px-2 py-0.5 rounded text-[10px] font-bold tracking-wider ${
                        washer.kyc === 'VERIFIED' ? 'bg-blue-500/10 text-blue-400' : 'bg-orange-500/10 text-orange-400'
                      }`}>
                        KYC: {washer.kyc}
                      </span>
                      <span className={`inline-flex w-fit px-2 py-0.5 rounded text-[10px] font-bold tracking-wider ${
                        washer.status === 'APPROVED' ? 'bg-green-500/10 text-green-400' : 
                        washer.status === 'SUSPENDED' ? 'bg-red-500/10 text-red-400' : 'bg-yellow-500/10 text-yellow-400'
                      }`}>
                        {washer.status}
                      </span>
                    </div>
                  </td>
                  <td className="px-6 py-4">
                    <div className="flex items-center justify-end space-x-2">
                      {washer.status === 'UNDER_REVIEW' && (
                        <button className="text-green-400 hover:text-green-300 bg-green-400/10 hover:bg-green-400/20 px-3 py-1.5 rounded-lg text-xs font-medium transition-colors border border-green-400/20 flex items-center space-x-1">
                          <ShieldCheck className="w-3.5 h-3.5" />
                          <span>Approve KYC</span>
                        </button>
                      )}
                      {washer.status !== 'SUSPENDED' && (
                        <button className="text-red-400 hover:text-red-300 bg-red-400/10 hover:bg-red-400/20 px-3 py-1.5 rounded-lg text-xs font-medium transition-colors border border-red-400/20 flex items-center space-x-1">
                          <ShieldAlert className="w-3.5 h-3.5" />
                          <span>Suspend</span>
                        </button>
                      )}
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
        
        <div className="p-4 border-t border-white/10 flex items-center justify-between text-sm text-gray-400">
          <div>Showing <span className="font-medium text-white">1</span> to <span className="font-medium text-white">5</span> of <span className="font-medium text-white">843</span> results</div>
          <div className="flex space-x-2">
            <button className="px-3 py-1 border border-white/10 rounded-md hover:bg-white/5 transition-colors disabled:opacity-50">Previous</button>
            <button className="px-3 py-1 border border-white/10 rounded-md hover:bg-white/5 transition-colors">Next</button>
          </div>
        </div>
      </div>
    </div>
  );
}
