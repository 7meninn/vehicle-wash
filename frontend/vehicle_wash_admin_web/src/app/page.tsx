import { 
  TrendingUp, 
  Users, 
  Car, 
  CheckCircle, 
  AlertCircle,
  DollarSign,
  CalendarDays
} from "lucide-react";

export default function Dashboard() {
  const kpis = [
    {
      title: "Today's Bookings",
      value: "124",
      trend: "+12.5%",
      isPositive: true,
      icon: CalendarDays,
      color: "text-blue-400",
      bg: "bg-blue-400/10",
      border: "border-blue-400/20"
    },
    {
      title: "Active Washers",
      value: "58",
      trend: "+4.2%",
      isPositive: true,
      icon: Car,
      color: "text-purple-400",
      bg: "bg-purple-400/10",
      border: "border-purple-400/20"
    },
    {
      title: "Today's Revenue",
      value: "$28,450.75",
      trend: "+18.2%",
      isPositive: true,
      icon: DollarSign,
      color: "text-green-400",
      bg: "bg-green-400/10",
      border: "border-green-400/20"
    },
    {
      title: "Pending Disputes",
      value: "6",
      trend: "-2.5%",
      isPositive: true,
      icon: AlertCircle,
      color: "text-amber-400",
      bg: "bg-amber-400/10",
      border: "border-amber-400/20"
    }
  ];

  return (
    <div className="space-y-8 animate-in fade-in slide-in-from-bottom-4 duration-700">
      <header className="flex justify-between items-end">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-white">Dashboard Overview</h1>
          <p className="text-stone-400 mt-2">Welcome back, here's what's happening today.</p>
        </div>
        <div className="flex items-center space-x-2 text-sm text-stone-400 bg-white/5 px-4 py-2 rounded-lg border border-white/10">
          <span className="w-2 h-2 rounded-full bg-green-500 animate-pulse"></span>
          <span>System Normal</span>
        </div>
      </header>

      {/* KPI Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {kpis.map((kpi, idx) => {
          const Icon = kpi.icon;
          return (
            <div 
              key={idx} 
              className={`glass-panel p-6 rounded-2xl border ${kpi.border} hover:bg-white/5 transition-all duration-300 group`}
            >
              <div className="flex justify-between items-start mb-4">
                <div className={`p-3 rounded-xl ${kpi.bg}`}>
                  <Icon className={`w-6 h-6 ${kpi.color} group-hover:scale-110 transition-transform duration-300`} />
                </div>
                <div className={`flex items-center space-x-1 text-sm font-medium ${kpi.isPositive ? 'text-green-400' : 'text-red-400'}`}>
                  <span>{kpi.trend}</span>
                  <TrendingUp className="w-4 h-4" />
                </div>
              </div>
              
              <div>
                <p className="text-sm font-medium text-stone-400 mb-1">{kpi.title}</p>
                <h3 className="text-3xl font-bold text-white tracking-tight">{kpi.value}</h3>
              </div>
            </div>
          );
        })}
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Recent Bookings - Takes 2 cols */}
        <div className="lg:col-span-2 glass-panel rounded-2xl p-6 border-white/10">
          <div className="flex justify-between items-center mb-6">
            <h2 className="text-xl font-semibold">Recent Bookings</h2>
            <button className="text-sm text-amber-500 hover:text-amber-400 transition-colors">View All</button>
          </div>
          
          <div className="space-y-4">
            {[1, 2, 3, 4].map((i) => (
              <div key={i} className="flex items-center justify-between p-4 rounded-xl bg-white/5 hover:bg-white/10 transition-colors border border-transparent hover:border-white/5">
                <div className="flex items-center space-x-4">
                  <div className="w-10 h-10 rounded-full bg-amber-500/20 flex items-center justify-center">
                    <Car className="w-5 h-5 text-amber-500" />
                  </div>
                  <div>
                    <p className="text-sm font-medium text-white">Booking #BK-{1000 + i}</p>
                    <p className="text-xs text-stone-400">Exterior Wash • 2 mins ago</p>
                  </div>
                </div>
                
                <div className="flex items-center space-x-6">
                  <div className="text-right">
                    <p className="text-sm font-medium text-white">$49.00</p>
                    <p className="text-xs text-stone-400">Card Payment</p>
                  </div>
                  <div className="px-3 py-1 rounded-full bg-green-500/20 text-green-400 border border-green-500/20 text-xs font-medium flex items-center space-x-1">
                    <CheckCircle className="w-3 h-3" />
                    <span>Completed</span>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Top Washers */}
        <div className="glass-panel rounded-2xl p-6 border-white/10">
          <div className="flex justify-between items-center mb-6">
            <h2 className="text-xl font-semibold">Top Washers</h2>
          </div>
          
          <div className="space-y-5">
            {[
              { name: 'Michael Chen', rating: '4.91', jobs: 427, img: 'bg-amber-600' },
              { name: 'Sarah Davis', rating: '4.88', jobs: 382, img: 'bg-stone-600' },
              { name: 'John Smith', rating: '4.85', jobs: 315, img: 'bg-amber-800' },
            ].map((washer, idx) => (
              <div key={idx} className="flex items-center justify-between group">
                <div className="flex items-center space-x-3">
                  <div className={`w-10 h-10 rounded-full ${washer.img} flex items-center justify-center text-white font-bold shadow-lg`}>
                    {washer.name.charAt(0)}
                  </div>
                  <div>
                    <p className="text-sm font-medium text-white group-hover:text-amber-500 transition-colors">{washer.name}</p>
                    <p className="text-xs text-stone-400">{washer.jobs} Jobs completed</p>
                  </div>
                </div>
                <div className="flex items-center space-x-1 bg-amber-500/10 px-2 py-1 rounded border border-amber-500/20 text-amber-500">
                  <span className="text-xs font-bold">{washer.rating}</span>
                  <span className="text-[10px]">★</span>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}
