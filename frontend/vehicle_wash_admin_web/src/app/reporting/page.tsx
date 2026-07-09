"use client";

import React, { useState } from 'react';
import { Download, Calendar, BarChart3, LineChart, PieChart, TrendingUp, DollarSign, Users, Car } from 'lucide-react';

export default function ReportingPage() {
  const [dateRange, setDateRange] = useState('This Month');
  const [isLoading, setIsLoading] = useState(true);

  // Fetch reporting data from backend
  React.useEffect(() => {
    const fetchReports = async () => {
      try {
        setIsLoading(true);
        // Integrate with backend endpoint
        const response = await fetch('/api/admin/reports?range=' + dateRange);
        if (response.ok) {
          const data = await response.json();
          // setReportData(data);
        }
      } catch (error) {
        console.error("Failed to fetch reports:", error);
      } finally {
        setIsLoading(false);
      }
    };
    
    fetchReports();
  }, [dateRange]);

  return (
    <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 space-y-8 pb-10">
      <div className="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-white mb-2">Reporting & Analytics</h1>
          <p className="text-gray-400">Platform performance, financial metrics, and user growth.</p>
        </div>
        <div className="flex gap-3">
          <button className="flex items-center gap-2 px-4 py-2 rounded-xl bg-white/5 border border-white/10 text-white hover:bg-white/10 transition-colors">
            <Calendar className="w-4 h-4" />
            <span>{dateRange}</span>
          </button>
          <button className="flex items-center gap-2 px-4 py-2 rounded-xl bg-gradient-to-r from-amber-500 to-amber-600 text-white hover:opacity-90 transition-opacity font-medium">
            <Download className="w-4 h-4" />
            <span>Export Report</span>
          </button>
        </div>
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <KPICard title="Total Revenue" value="$45,231.89" trend="+14.2%" isPositive={true} icon={<DollarSign className="w-5 h-5 text-green-400" />} />
        <KPICard title="Active Washers" value="142" trend="+5.4%" isPositive={true} icon={<Car className="w-5 h-5 text-amber-400" />} />
        <KPICard title="New Customers" value="892" trend="+21.0%" isPositive={true} icon={<Users className="w-5 h-5 text-blue-400" />} />
        <KPICard title="Avg Rating" value="4.8/5.0" trend="-0.1%" isPositive={false} icon={<TrendingUp className="w-5 h-5 text-purple-400" />} />
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Chart 1: Revenue Over Time */}
        <div className="glass-panel p-6 rounded-2xl border-white/10 flex flex-col h-[400px]">
          <div className="flex justify-between items-center mb-6">
            <h2 className="text-lg font-semibold text-white flex items-center gap-2">
              <LineChart className="w-5 h-5 text-amber-500" />
              Revenue Over Time
            </h2>
          </div>
          <div className="flex-1 flex items-end gap-2 mt-4">
            {/* Simulated Bar Chart */}
            {[40, 55, 45, 70, 65, 85, 100].map((height, i) => (
              <div key={i} className="flex-1 flex flex-col justify-end group">
                <div 
                  className="w-full bg-amber-500/20 hover:bg-amber-500 rounded-t-sm transition-all duration-300 relative"
                  style={{ height: `${height}%` }}
                >
                  <div className="opacity-0 group-hover:opacity-100 absolute -top-8 left-1/2 -translate-x-1/2 bg-black text-xs text-white px-2 py-1 rounded whitespace-nowrap transition-opacity">
                    ${height * 100}
                  </div>
                </div>
              </div>
            ))}
          </div>
          <div className="flex justify-between text-xs text-gray-500 mt-4 px-2">
            <span>Mon</span><span>Tue</span><span>Wed</span><span>Thu</span><span>Fri</span><span>Sat</span><span>Sun</span>
          </div>
        </div>

        {/* Chart 2: Bookings by Category */}
        <div className="glass-panel p-6 rounded-2xl border-white/10 flex flex-col h-[400px]">
          <div className="flex justify-between items-center mb-6">
            <h2 className="text-lg font-semibold text-white flex items-center gap-2">
              <PieChart className="w-5 h-5 text-blue-500" />
              Bookings by Category
            </h2>
          </div>
          <div className="flex-1 flex items-center justify-center relative">
            {/* Simulated Donut Chart using borders */}
            <div className="w-48 h-48 rounded-full border-[16px] border-white/5 relative overflow-hidden flex items-center justify-center">
               <div className="absolute inset-0 border-[16px] border-amber-500/80 rounded-full" style={{ clipPath: 'polygon(50% 50%, 50% 0, 100% 0, 100% 100%, 0 100%, 0 70%)' }}></div>
               <div className="absolute inset-0 border-[16px] border-blue-500/80 rounded-full" style={{ clipPath: 'polygon(50% 50%, 0 70%, 0 0, 50% 0)' }}></div>
               <div className="text-center">
                 <div className="text-2xl font-bold text-white">1,245</div>
                 <div className="text-xs text-gray-400">Total Bookings</div>
               </div>
            </div>
          </div>
          <div className="flex justify-center gap-6 text-sm mt-4">
            <div className="flex items-center gap-2"><div className="w-3 h-3 rounded-full bg-amber-500"></div><span className="text-gray-300">Exterior Wash (65%)</span></div>
            <div className="flex items-center gap-2"><div className="w-3 h-3 rounded-full bg-blue-500"></div><span className="text-gray-300">Full Detail (35%)</span></div>
          </div>
        </div>

        {/* Top Washers Table */}
        <div className="lg:col-span-2 glass-panel p-6 rounded-2xl border-white/10">
          <div className="flex justify-between items-center mb-6">
            <h2 className="text-lg font-semibold text-white flex items-center gap-2">
              <BarChart3 className="w-5 h-5 text-purple-500" />
              Top Performing Washers
            </h2>
          </div>
          <div className="overflow-x-auto">
            <table className="w-full text-left">
              <thead>
                <tr className="text-xs uppercase tracking-wider text-gray-400 border-b border-white/10">
                  <th className="pb-3 font-medium">Washer</th>
                  <th className="pb-3 font-medium text-center">Completed Jobs</th>
                  <th className="pb-3 font-medium text-center">Rating</th>
                  <th className="pb-3 font-medium text-right">Revenue Generated</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-white/5 text-sm">
                <tr className="hover:bg-white/5 transition-colors">
                  <td className="py-4">
                    <div className="flex items-center gap-3">
                      <div className="w-8 h-8 rounded-full bg-amber-500/20 text-amber-300 flex items-center justify-center font-bold text-xs">1</div>
                      <span className="font-medium text-gray-200">Michael Chen</span>
                    </div>
                  </td>
                  <td className="py-4 text-center text-gray-400">142</td>
                  <td className="py-4 text-center text-amber-400">4.9 ★</td>
                  <td className="py-4 text-right font-medium text-white">$4,250.00</td>
                </tr>
                <tr className="hover:bg-white/5 transition-colors">
                  <td className="py-4">
                    <div className="flex items-center gap-3">
                      <div className="w-8 h-8 rounded-full bg-gray-300/20 text-gray-300 flex items-center justify-center font-bold text-xs">2</div>
                      <span className="font-medium text-gray-200">Sarah Davis</span>
                    </div>
                  </td>
                  <td className="py-4 text-center text-gray-400">128</td>
                  <td className="py-4 text-center text-amber-400">4.8 ★</td>
                  <td className="py-4 text-right font-medium text-white">$3,840.50</td>
                </tr>
                <tr className="hover:bg-white/5 transition-colors">
                  <td className="py-4">
                    <div className="flex items-center gap-3">
                      <div className="w-8 h-8 rounded-full bg-amber-700/20 text-amber-600 flex items-center justify-center font-bold text-xs">3</div>
                      <span className="font-medium text-gray-200">John Smith</span>
                    </div>
                  </td>
                  <td className="py-4 text-center text-gray-400">115</td>
                  <td className="py-4 text-center text-amber-400">4.7 ★</td>
                  <td className="py-4 text-right font-medium text-white">$3,450.25</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  );
}

// Subcomponents
function KPICard({ title, value, trend, isPositive, icon }: any) {
  return (
    <div className="glass-panel p-6 rounded-2xl border-white/10 relative overflow-hidden group">
      <div className="absolute inset-0 bg-gradient-to-br from-white/5 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500"></div>
      <div className="flex justify-between items-start mb-4 relative z-10">
        <h3 className="text-gray-400 font-medium text-sm">{title}</h3>
        {icon && <div className="p-2 bg-white/5 rounded-lg border border-white/10">{icon}</div>}
      </div>
      <div className="relative z-10 flex items-end justify-between">
        <p className="text-3xl font-bold text-white tracking-tight">{value}</p>
        {trend && (
          <span className={`text-sm font-medium mb-1 ${isPositive ? 'text-green-400' : 'text-red-400'}`}>
            {trend}
          </span>
        )}
      </div>
    </div>
  );
}
