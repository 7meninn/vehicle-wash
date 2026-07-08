"use client";

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { 
  LayoutDashboard, 
  Users, 
  Car, 
  CalendarDays, 
  AlertTriangle,
  Settings
} from 'lucide-react';

const navItems = [
  { name: 'Dashboard', href: '/', icon: LayoutDashboard },
  { name: 'Customers', href: '/customers', icon: Users },
  { name: 'Washers', href: '/washers', icon: Car },
  { name: 'Bookings', href: '/bookings', icon: CalendarDays },
  { name: 'Disputes', href: '/disputes', icon: AlertTriangle },
];

export function Sidebar() {
  const pathname = usePathname();

  return (
    <aside className="w-64 h-screen bg-gray-900/40 backdrop-blur-xl border-r border-white/10 flex flex-col fixed left-0 top-0 text-gray-100">
      <div className="p-6 flex items-center space-x-3">
        <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-blue-500 to-purple-600 flex items-center justify-center shadow-lg shadow-blue-500/30">
          <Car className="text-white w-6 h-6" />
        </div>
        <span className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-blue-400 to-purple-400">WashAdmin</span>
      </div>
      
      <div className="px-4 py-6 flex-1 space-y-2 overflow-y-auto">
        <p className="px-2 text-xs font-semibold text-gray-400 uppercase tracking-wider mb-4">Menu</p>
        {navItems.map((item) => {
          const isActive = pathname === item.href;
          const Icon = item.icon;
          
          return (
            <Link
              key={item.name}
              href={item.href}
              className={`flex items-center space-x-3 px-3 py-3 rounded-xl transition-all duration-300 group ${
                isActive 
                  ? 'bg-blue-500/10 text-blue-400 relative overflow-hidden' 
                  : 'hover:bg-white/5 text-gray-400 hover:text-gray-200'
              }`}
            >
              {isActive && (
                <div className="absolute left-0 top-0 w-1 h-full bg-blue-500 rounded-r-full shadow-[0_0_10px_rgba(59,130,246,0.8)]" />
              )}
              <Icon className={`w-5 h-5 transition-transform duration-300 ${isActive ? 'scale-110' : 'group-hover:scale-110'}`} />
              <span className="font-medium">{item.name}</span>
            </Link>
          );
        })}
      </div>
      
      <div className="p-4 border-t border-white/10">
        <Link
          href="/settings"
          className="flex items-center space-x-3 px-3 py-3 rounded-xl transition-all duration-300 hover:bg-white/5 text-gray-400 hover:text-gray-200 group"
        >
          <Settings className="w-5 h-5 group-hover:rotate-90 transition-transform duration-500" />
          <span className="font-medium">Settings</span>
        </Link>
        <div className="mt-4 flex items-center space-x-3 px-3">
          <div className="w-9 h-9 rounded-full bg-gradient-to-br from-gray-700 to-gray-800 border border-gray-600"></div>
          <div>
            <p className="text-sm font-medium text-white">Admin User</p>
            <p className="text-xs text-gray-400">admin@washapp.com</p>
          </div>
        </div>
      </div>
    </aside>
  );
}
