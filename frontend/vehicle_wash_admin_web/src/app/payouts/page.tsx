"use client";

import React, { useState, useEffect } from 'react';
import { Download, Search, CheckCircle2, AlertCircle, Clock, Filter, ArrowUpRight, ArrowDownRight } from 'lucide-react';

export default function PayoutsPage() {
  const [activeTab, setActiveTab] = useState('pending');
  const [isLoading, setIsLoading] = useState(true);

  // Fetch payouts from backend
  useEffect(() => {
    const fetchPayouts = async () => {
      try {
        setIsLoading(true);
        // Integrate with backend endpoint
        const response = await fetch('/api/admin/payouts?status=' + activeTab);
        if (response.ok) {
          const data = await response.json();
          // setPayouts(data);
        }
      } catch (error) {
        console.error("Failed to fetch payouts:", error);
      } finally {
        setIsLoading(false);
      }
    };
    
    fetchPayouts();
  }, [activeTab]);

  return (
    <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-8 pb-10">
      <div className="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-white mb-2">Payouts Management</h1>
          <p className="text-gray-400">Manage and process washer payouts and financial settlements.</p>
        </div>
        <div className="flex gap-3">
          <button className="flex items-center gap-2 px-4 py-2 rounded-xl bg-white/5 border border-white/10 text-white hover:bg-white/10 transition-colors">
            <Filter className="w-4 h-4" />
            <span>Filter</span>
          </button>
          <button className="flex items-center gap-2 px-4 py-2 rounded-xl bg-gradient-to-r from-amber-500 to-amber-600 text-white hover:opacity-90 transition-opacity font-medium">
            <Download className="w-4 h-4" />
            <span>Export CSV</span>
          </button>
        </div>
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        <KPICard title="Total Processed" value="$124,500" trend="+12.5%" isPositive={true} />
        <KPICard title="Pending Payouts" value="$8,450" subtitle="24 Washers" />
        <KPICard title="Failed Transfers" value="$320" subtitle="2 Washers" icon={<AlertCircle className="w-5 h-5 text-red-400" />} />
        <KPICard title="Next Processing" value="Today, 5PM" subtitle="Automatic schedule" icon={<Clock className="w-5 h-5 text-blue-400" />} />
      </div>

      {/* Main Content Area */}
      <div className="glass-panel rounded-2xl border-white/10 overflow-hidden flex flex-col min-h-[500px]">
        {/* Tabs & Search */}
        <div className="p-4 border-b border-white/10 flex flex-col sm:flex-row justify-between gap-4">
          <div className="flex space-x-1 bg-black/20 p-1 rounded-xl w-fit">
            <TabButton active={activeTab === 'pending'} onClick={() => setActiveTab('pending')}>Pending (24)</TabButton>
            <TabButton active={activeTab === 'completed'} onClick={() => setActiveTab('completed')}>Completed</TabButton>
            <TabButton active={activeTab === 'failed'} onClick={() => setActiveTab('failed')}>Failed (2)</TabButton>
          </div>
          <div className="relative w-full sm:w-64">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
            <input 
              type="text" 
              placeholder="Search washer or ID..." 
              className="w-full pl-10 pr-4 py-2 bg-white/5 border border-white/10 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-amber-500/50 text-white placeholder-gray-500"
            />
          </div>
        </div>

        {/* Data Table */}
        <div className="flex-1 overflow-x-auto relative">
          {isLoading ? (
            <div className="absolute inset-0 flex items-center justify-center">
              <div className="w-8 h-8 border-2 border-amber-500 border-t-transparent rounded-full animate-spin"></div>
            </div>
          ) : (
            <table className="w-full text-left border-collapse">
              <thead>
                <tr className="bg-white/5 text-xs uppercase tracking-wider text-gray-400 border-b border-white/10">
                  <th className="p-4 font-medium">Washer Info</th>
                  <th className="p-4 font-medium">Period</th>
                  <th className="p-4 font-medium">Completed Jobs</th>
                  <th className="p-4 font-medium">Amount</th>
                  <th className="p-4 font-medium">Status</th>
                  <th className="p-4 font-medium text-right">Actions</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-white/5 text-sm">
                <PayoutRow 
                  name="John Smith" 
                  id="W-8472" 
                  period="Jul 1 - Jul 7" 
                  jobs={42} 
                  amount="$845.50" 
                  status={activeTab as any} 
                />
                <PayoutRow 
                  name="Sarah Davis" 
                  id="W-1293" 
                  period="Jul 1 - Jul 7" 
                  jobs={38} 
                  amount="$720.00" 
                  status={activeTab as any} 
                />
                <PayoutRow 
                  name="Michael Chen" 
                  id="W-4492" 
                  period="Jul 1 - Jul 7" 
                  jobs={51} 
                  amount="$1,120.25" 
                  status={activeTab as any} 
                />
                <PayoutRow 
                  name="Jessica Taylor" 
                  id="W-9021" 
                  period="Jul 1 - Jul 7" 
                  jobs={24} 
                  amount="$480.00" 
                  status={activeTab as any} 
                />
              </tbody>
            </table>
          )}
        </div>
        
        {/* Pagination */}
        <div className="p-4 border-t border-white/10 flex items-center justify-between text-sm text-gray-400">
          <span>Showing 1-4 of 24 entries</span>
          <div className="flex gap-2">
            <button className="px-3 py-1 rounded-lg bg-white/5 border border-white/10 hover:bg-white/10 disabled:opacity-50">Prev</button>
            <button className="px-3 py-1 rounded-lg bg-white/5 border border-white/10 hover:bg-white/10">Next</button>
          </div>
        </div>
      </div>
    </div>
  );
}

// Subcomponents
function KPICard({ title, value, subtitle, trend, isPositive, icon }: any) {
  return (
    <div className="glass-panel p-6 rounded-2xl border-white/10 relative overflow-hidden group">
      <div className="absolute inset-0 bg-gradient-to-br from-white/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500"></div>
      <div className="flex justify-between items-start mb-4 relative z-10">
        <h3 className="text-gray-400 font-medium text-sm">{title}</h3>
        {icon && <div>{icon}</div>}
        {trend && (
          <span className={`flex items-center text-xs font-medium px-2 py-1 rounded-full ${isPositive ? 'bg-green-500/10 text-green-400' : 'bg-red-500/10 text-red-400'}`}>
            {isPositive ? <ArrowUpRight className="w-3 h-3 mr-1" /> : <ArrowDownRight className="w-3 h-3 mr-1" />}
            {trend}
          </span>
        )}
      </div>
      <div className="relative z-10">
        <p className="text-3xl font-bold text-white tracking-tight">{value}</p>
        {subtitle && <p className="text-sm text-gray-500 mt-1">{subtitle}</p>}
      </div>
    </div>
  );
}

function TabButton({ children, active, onClick }: any) {
  return (
    <button
      onClick={onClick}
      className={`px-4 py-2 rounded-lg text-sm font-medium transition-all duration-300 ${
        active 
          ? 'bg-white/10 text-white shadow-sm' 
          : 'text-gray-400 hover:text-gray-200 hover:bg-white/5'
      }`}
    >
      {children}
    </button>
  );
}

function PayoutRow({ name, id, period, jobs, amount, status }: any) {
  return (
    <tr className="hover:bg-white/5 transition-colors group">
      <td className="p-4">
        <div className="flex items-center gap-3">
          <div className="w-9 h-9 rounded-full bg-gradient-to-br from-indigo-500/20 to-purple-500/20 flex items-center justify-center border border-white/10">
            <span className="text-indigo-300 font-medium">{name.charAt(0)}</span>
          </div>
          <div>
            <div className="font-medium text-gray-200">{name}</div>
            <div className="text-xs text-gray-500">{id}</div>
          </div>
        </div>
      </td>
      <td className="p-4 text-gray-400">{period}</td>
      <td className="p-4 text-gray-300">{jobs}</td>
      <td className="p-4 font-medium text-white">{amount}</td>
      <td className="p-4">
        <StatusBadge status={status} />
      </td>
      <td className="p-4 text-right">
        <button className="text-amber-500 hover:text-amber-400 text-sm font-medium opacity-0 group-hover:opacity-100 transition-opacity">
          {status === 'pending' ? 'Process Now' : 'View Details'}
        </button>
      </td>
    </tr>
  );
}

function StatusBadge({ status }: { status: string }) {
  if (status === 'pending') {
    return (
      <span className="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium bg-amber-500/10 text-amber-400 border border-amber-500/20">
        <Clock className="w-3 h-3 mr-1" /> Pending
      </span>
    );
  }
  if (status === 'failed') {
    return (
      <span className="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium bg-red-500/10 text-red-400 border border-red-500/20">
        <AlertCircle className="w-3 h-3 mr-1" /> Failed
      </span>
    );
  }
  return (
    <span className="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium bg-green-500/10 text-green-400 border border-green-500/20">
      <CheckCircle2 className="w-3 h-3 mr-1" /> Completed
    </span>
  );
}
