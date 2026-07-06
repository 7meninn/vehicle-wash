import { Search, Filter, MoreVertical, ShieldAlert } from 'lucide-react';

export default function CustomersPage() {
  const customers = [
    { id: 'CUST-8392', name: 'Arjun Reddy', phone: '+91 98765 43210', email: 'arjun.r@example.com', joined: '12 Jan 2026', status: 'ACTIVE', bookings: 14 },
    { id: 'CUST-8393', name: 'Priya Sharma', phone: '+91 98765 43211', email: 'priya.s@example.com', joined: '15 Jan 2026', status: 'ACTIVE', bookings: 8 },
    { id: 'CUST-8394', name: 'Vikram Singh', phone: '+91 98765 43212', email: 'vikram.s@example.com', joined: '02 Feb 2026', status: 'SUSPENDED', bookings: 2 },
    { id: 'CUST-8395', name: 'Neha Gupta', phone: '+91 98765 43213', email: 'neha.g@example.com', joined: '18 Feb 2026', status: 'ACTIVE', bookings: 22 },
    { id: 'CUST-8396', name: 'Rohan Desai', phone: '+91 98765 43214', email: 'rohan.d@example.com', joined: '05 Mar 2026', status: 'ACTIVE', bookings: 5 },
  ];

  return (
    <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 duration-700">
      <header className="flex flex-col md:flex-row md:items-end justify-between gap-4">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-white">Customer Management</h1>
          <p className="text-gray-400 mt-1">View and manage customer accounts.</p>
        </div>
        
        <div className="flex gap-3">
          <div className="relative">
            <Search className="w-4 h-4 absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
            <input 
              type="text" 
              placeholder="Search customers..." 
              className="bg-slate-900 border border-white/10 text-sm rounded-lg pl-9 pr-4 py-2 text-white placeholder:text-gray-500 focus:outline-none focus:ring-2 focus:ring-blue-500/50 w-64 transition-all"
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
                <th className="px-6 py-4 font-medium">Customer ID</th>
                <th className="px-6 py-4 font-medium">Name & Contact</th>
                <th className="px-6 py-4 font-medium">Joined</th>
                <th className="px-6 py-4 font-medium">Total Bookings</th>
                <th className="px-6 py-4 font-medium">Status</th>
                <th className="px-6 py-4 font-medium text-right">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-white/5">
              {customers.map((customer) => (
                <tr key={customer.id} className="hover:bg-white/5 transition-colors group">
                  <td className="px-6 py-4 font-medium text-gray-300">
                    {customer.id}
                  </td>
                  <td className="px-6 py-4">
                    <div className="flex items-center space-x-3">
                      <div className="w-8 h-8 rounded-full bg-gradient-to-br from-blue-500 to-indigo-600 flex items-center justify-center text-white font-bold text-xs">
                        {customer.name.charAt(0)}
                      </div>
                      <div>
                        <div className="font-medium text-white">{customer.name}</div>
                        <div className="text-xs text-gray-400">{customer.phone} • {customer.email}</div>
                      </div>
                    </div>
                  </td>
                  <td className="px-6 py-4 text-gray-400">
                    {customer.joined}
                  </td>
                  <td className="px-6 py-4 text-gray-300">
                    {customer.bookings}
                  </td>
                  <td className="px-6 py-4">
                    <span className={`px-2.5 py-1 rounded-full text-xs font-medium border ${
                      customer.status === 'ACTIVE' 
                        ? 'bg-green-500/10 text-green-400 border-green-500/20' 
                        : 'bg-red-500/10 text-red-400 border-red-500/20'
                    }`}>
                      {customer.status}
                    </span>
                  </td>
                  <td className="px-6 py-4 text-right">
                    <button className="text-red-400 hover:text-red-300 bg-red-400/10 hover:bg-red-400/20 px-3 py-1.5 rounded-lg text-xs font-medium transition-colors border border-red-400/20 flex items-center space-x-1 ml-auto">
                      <ShieldAlert className="w-3.5 h-3.5" />
                      <span>Suspend</span>
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
        
        <div className="p-4 border-t border-white/10 flex items-center justify-between text-sm text-gray-400">
          <div>Showing <span className="font-medium text-white">1</span> to <span className="font-medium text-white">5</span> of <span className="font-medium text-white">2,482</span> results</div>
          <div className="flex space-x-2">
            <button className="px-3 py-1 border border-white/10 rounded-md hover:bg-white/5 transition-colors disabled:opacity-50">Previous</button>
            <button className="px-3 py-1 border border-white/10 rounded-md hover:bg-white/5 transition-colors">Next</button>
          </div>
        </div>
      </div>
    </div>
  );
}
