"use client";

import React, { useState } from 'react';
import { Search, Filter, ShieldAlert, CheckCircle2, XCircle, Clock, ChevronRight } from 'lucide-react';

export default function DisputesPage() {
  const [filter, setFilter] = useState('all');
  const [isLoading, setIsLoading] = useState(true);

  // Fetch disputes from backend
  React.useEffect(() => {
    const fetchDisputes = async () => {
      try {
        setIsLoading(true);
        // Integrate with backend endpoint
        const response = await fetch('/api/admin/disputes?status=' + filter);
        if (response.ok) {
          const data = await response.json();
          // setDisputes(data);
        }
      } catch (error) {
        console.error("Failed to fetch disputes:", error);
      } finally {
        setIsLoading(false);
      }
    };
    
    fetchDisputes();
  }, [filter]);

  return (
    <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-8 pb-10">
      <div className="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-white mb-2">Disputes</h1>
          <p className="text-gray-400">Review and resolve customer and washer disputes securely.</p>
        </div>
        <div className="flex gap-3">
          <button className="flex items-center gap-2 px-4 py-2 rounded-xl bg-white/5 border border-white/10 text-white hover:bg-white/10 transition-colors">
            <Filter className="w-4 h-4" />
            <span>Filter</span>
          </button>
        </div>
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
        <KPICard title="Open Disputes" value="12" icon={<ShieldAlert className="w-5 h-5 text-amber-400" />} />
        <KPICard title="Pending Review" value="5" icon={<Clock className="w-5 h-5 text-blue-400" />} />
        <KPICard title="Resolved (30d)" value="48" icon={<CheckCircle2 className="w-5 h-5 text-green-400" />} />
        <KPICard title="Refunded (30d)" value="$640.00" />
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Disputes List */}
        <div className="lg:col-span-2 glass-panel rounded-2xl border-white/10 overflow-hidden flex flex-col min-h-[600px]">
          <div className="p-4 border-b border-white/10 flex flex-col sm:flex-row justify-between gap-4">
            <div className="flex space-x-1 bg-black/20 p-1 rounded-xl w-fit">
              <TabButton active={filter === 'all'} onClick={() => setFilter('all')}>All</TabButton>
              <TabButton active={filter === 'open'} onClick={() => setFilter('open')}>Open</TabButton>
              <TabButton active={filter === 'resolved'} onClick={() => setFilter('resolved')}>Resolved</TabButton>
            </div>
            <div className="relative w-full sm:w-64">
              <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
              <input 
                type="text" 
                placeholder="Search ID or user..." 
                className="w-full pl-10 pr-4 py-2 bg-white/5 border border-white/10 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-amber-500/50 text-white placeholder-gray-500"
              />
            </div>
          </div>
          
          <div className="flex-1 overflow-y-auto p-4 space-y-3">
            <DisputeCard 
              id="DSP-9021" 
              date="2 hours ago" 
              customer="Alice Johnson" 
              washer="John Smith" 
              issue="Poor wash quality" 
              status="open" 
            />
            <DisputeCard 
              id="DSP-8832" 
              date="5 hours ago" 
              customer="Mark Wilson" 
              washer="Sarah Davis" 
              issue="Washer did not arrive" 
              status="open" 
            />
            <DisputeCard 
              id="DSP-8710" 
              date="1 day ago" 
              customer="Emily Clark" 
              washer="Michael Chen" 
              issue="Scratched paint" 
              status="reviewing" 
            />
            <DisputeCard 
              id="DSP-8654" 
              date="2 days ago" 
              customer="Tom Hardy" 
              washer="Jessica Taylor" 
              issue="Late arrival" 
              status="resolved" 
            />
          </div>
        </div>

        {/* Selected Dispute Detail (Placeholder) */}
        <div className="glass-panel rounded-2xl border-white/10 p-6 flex flex-col h-[600px]">
          <div className="flex items-center justify-between mb-6">
            <h2 className="text-xl font-semibold text-white">Dispute Details</h2>
            <span className="px-3 py-1 rounded-full bg-amber-500/10 text-amber-400 text-xs font-medium border border-amber-500/20">Open</span>
          </div>
          
          <div className="flex-1 flex flex-col items-center justify-center text-center">
            <div className="w-16 h-16 rounded-full bg-white/5 flex items-center justify-center mb-4 border border-white/10">
              <ShieldAlert className="w-8 h-8 text-gray-400" />
            </div>
            <h3 className="text-lg font-medium text-white mb-2">Select a dispute</h3>
            <p className="text-gray-400 text-sm max-w-[200px]">Choose a dispute from the list to view evidence and take action.</p>
          </div>
        </div>
      </div>
    </div>
  );
}

// Subcomponents
function KPICard({ title, value, icon }: any) {
  return (
    <div className="glass-panel p-6 rounded-2xl border-white/10 relative overflow-hidden group">
      <div className="absolute inset-0 bg-gradient-to-br from-white/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500"></div>
      <div className="flex justify-between items-start mb-4 relative z-10">
        <h3 className="text-gray-400 font-medium text-sm">{title}</h3>
        {icon && <div>{icon}</div>}
      </div>
      <div className="relative z-10">
        <p className="text-3xl font-bold text-white tracking-tight">{value}</p>
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

function DisputeCard({ id, date, customer, washer, issue, status }: any) {
  return (
    <div className="p-4 rounded-xl border border-white/5 bg-white/5 hover:bg-white/10 transition-colors cursor-pointer group">
      <div className="flex justify-between items-start mb-3">
        <div className="flex items-center gap-2">
          <span className="font-mono text-xs text-amber-400 bg-amber-400/10 px-2 py-1 rounded-md">{id}</span>
          <span className="text-xs text-gray-500">{date}</span>
        </div>
        <StatusBadge status={status} />
      </div>
      
      <h4 className="font-medium text-white mb-3 text-sm">{issue}</h4>
      
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-4 text-xs text-gray-400">
          <div className="flex items-center gap-1.5">
            <div className="w-5 h-5 rounded-full bg-blue-500/20 text-blue-300 flex items-center justify-center font-medium">C</div>
            <span>{customer}</span>
          </div>
          <div className="flex items-center gap-1.5">
            <div className="w-5 h-5 rounded-full bg-purple-500/20 text-purple-300 flex items-center justify-center font-medium">W</div>
            <span>{washer}</span>
          </div>
        </div>
        <ChevronRight className="w-4 h-4 text-gray-500 group-hover:text-amber-400 transition-colors" />
      </div>
    </div>
  );
}

function StatusBadge({ status }: { status: string }) {
  if (status === 'open') {
    return <span className="flex items-center gap-1 text-xs font-medium text-amber-400"><AlertCircleIcon /> Action Required</span>;
  }
  if (status === 'reviewing') {
    return <span className="flex items-center gap-1 text-xs font-medium text-blue-400"><ClockIcon /> Under Review</span>;
  }
  return <span className="flex items-center gap-1 text-xs font-medium text-green-400"><CheckIcon /> Resolved</span>;
}

const AlertCircleIcon = () => <ShieldAlert className="w-3.5 h-3.5" />;
const ClockIcon = () => <Clock className="w-3.5 h-3.5" />;
const CheckIcon = () => <CheckCircle2 className="w-3.5 h-3.5" />;
