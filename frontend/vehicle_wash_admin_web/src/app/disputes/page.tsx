"use client";

import { useState } from "react";
import { 
  Search, 
  Filter, 
  Eye, 
  AlertCircle, 
  CheckCircle, 
  Clock, 
  X, 
  ImageIcon, 
  ShieldAlert, 
  MessageSquare,
  User,
  Car,
  Calendar,
  Info,
  Check
} from "lucide-react";

// Types
export type DisputeStatus = 'OPEN' | 'UNDER_REVIEW' | 'RESOLVED' | 'REJECTED';
export type ResolutionAction = 'FULL_REFUND' | 'PARTIAL_REFUND' | 'WASHER_WARNING' | 'WASHER_PENALTY' | 'DISMISS' | '';

export interface Dispute {
  id: string;
  bookingId: string;
  dateReported: string;
  reporter: 'CUSTOMER' | 'WASHER';
  customerName: string;
  washerName: string;
  reason: string;
  description: string;
  status: DisputeStatus;
  evidenceUrls: string[];
  resolution?: {
    action: ResolutionAction;
    notes: string;
    resolvedAt: string;
    resolvedBy: string;
  };
}

// Mock Data
const MOCK_DISPUTES: Dispute[] = [
  {
    id: "DSP-1029",
    bookingId: "BKG-5521",
    dateReported: "2026-07-07T14:30:00Z",
    reporter: "CUSTOMER",
    customerName: "Alice Smith",
    washerName: "John Doe",
    reason: "Damage to vehicle",
    description: "The washer scratched the left side mirror during the premium wash. I noticed it immediately after they left. The scratch wasn't there before, you can check the before photos.",
    status: "OPEN",
    evidenceUrls: [
      "https://images.unsplash.com/photo-1605270018596-fdd9a33d9c1f?auto=format&fit=crop&q=80&w=400&h=300",
      "https://images.unsplash.com/photo-1542318049-74d150fbab71?auto=format&fit=crop&q=80&w=400&h=300"
    ]
  },
  {
    id: "DSP-1028",
    bookingId: "BKG-5510",
    dateReported: "2026-07-06T09:15:00Z",
    reporter: "WASHER",
    customerName: "Bob Johnson",
    washerName: "Sarah Connor",
    reason: "Customer hostile behavior",
    description: "Customer was extremely rude and refused to provide access to the water hookup as agreed in the instructions. Threatened to give a 1 star review.",
    status: "UNDER_REVIEW",
    evidenceUrls: []
  },
  {
    id: "DSP-1025",
    bookingId: "BKG-5489",
    dateReported: "2026-07-05T16:45:00Z",
    reporter: "CUSTOMER",
    customerName: "Charlie Davis",
    washerName: "Mike Tyson",
    reason: "Poor wash quality",
    description: "The interior was not vacuumed properly, lots of dirt left under the mats. I paid for the premium interior detailing package.",
    status: "RESOLVED",
    evidenceUrls: [
      "https://images.unsplash.com/photo-1503376712356-068307270b28?auto=format&fit=crop&q=80&w=400&h=300"
    ],
    resolution: {
      action: "PARTIAL_REFUND",
      notes: "Issued 30% refund to customer. Washer given a warning regarding interior detailing quality.",
      resolvedAt: "2026-07-06T10:00:00Z",
      resolvedBy: "Admin01"
    }
  },
  {
    id: "DSP-1024",
    bookingId: "BKG-5480",
    dateReported: "2026-07-04T11:20:00Z",
    reporter: "WASHER",
    customerName: "Diana Prince",
    washerName: "Bruce Wayne",
    reason: "Vehicle significantly dirtier than stated",
    description: "The vehicle was covered in thick mud, presumably from off-roading. The standard wash package does not cover this level of soil.",
    status: "REJECTED",
    evidenceUrls: [
      "https://images.unsplash.com/photo-1517524008697-84bbe3c3fd98?auto=format&fit=crop&q=80&w=400&h=300"
    ],
    resolution: {
      action: "DISMISS",
      notes: "Washer did not raise the issue before starting the wash. Policies state washers must request price adjustment before beginning work.",
      resolvedAt: "2026-07-05T09:15:00Z",
      resolvedBy: "Admin02"
    }
  }
];

const StatusBadge = ({ status }: { status: DisputeStatus }) => {
  switch (status) {
    case 'OPEN':
      return <span className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium bg-red-500/10 text-red-400 border border-red-500/20"><AlertCircle className="w-3.5 h-3.5" /> Open</span>;
    case 'UNDER_REVIEW':
      return <span className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium bg-amber-500/10 text-amber-400 border border-amber-500/20"><Clock className="w-3.5 h-3.5" /> Under Review</span>;
    case 'RESOLVED':
      return <span className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium bg-green-500/10 text-green-400 border border-green-500/20"><CheckCircle className="w-3.5 h-3.5" /> Resolved</span>;
    case 'REJECTED':
      return <span className="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-xs font-medium bg-slate-500/10 text-slate-400 border border-slate-500/20"><X className="w-3.5 h-3.5" /> Rejected</span>;
    default:
      return null;
  }
};

export default function DisputesPage() {
  const [disputes, setDisputes] = useState<Dispute[]>(MOCK_DISPUTES);
  const [searchTerm, setSearchTerm] = useState("");
  const [statusFilter, setStatusFilter] = useState<DisputeStatus | 'ALL'>('ALL');
  
  const [selectedDispute, setSelectedDispute] = useState<Dispute | null>(null);
  
  // Resolution form state
  const [resolutionAction, setResolutionAction] = useState<ResolutionAction>('');
  const [resolutionNotes, setResolutionNotes] = useState("");

  const filteredDisputes = disputes.filter(d => {
    const matchesSearch = 
      d.id.toLowerCase().includes(searchTerm.toLowerCase()) || 
      d.bookingId.toLowerCase().includes(searchTerm.toLowerCase()) ||
      d.customerName.toLowerCase().includes(searchTerm.toLowerCase()) ||
      d.washerName.toLowerCase().includes(searchTerm.toLowerCase());
      
    const matchesStatus = statusFilter === 'ALL' || d.status === statusFilter;
    
    return matchesSearch && matchesStatus;
  });

  const handleResolve = () => {
    if (!selectedDispute || !resolutionAction) return;
    
    setDisputes(prev => prev.map(d => {
      if (d.id === selectedDispute.id) {
        return {
          ...d,
          status: resolutionAction === 'DISMISS' ? 'REJECTED' : 'RESOLVED',
          resolution: {
            action: resolutionAction,
            notes: resolutionNotes,
            resolvedAt: new Date().toISOString(),
            resolvedBy: "Admin (Current User)"
          }
        };
      }
      return d;
    }));
    
    // Update local state to show changes immediately in modal
    setSelectedDispute(prev => {
      if (!prev) return null;
      return {
        ...prev,
        status: resolutionAction === 'DISMISS' ? 'REJECTED' : 'RESOLVED',
        resolution: {
          action: resolutionAction,
          notes: resolutionNotes,
          resolvedAt: new Date().toISOString(),
          resolvedBy: "Admin (Current User)"
        }
      };
    });
  };

  const markUnderReview = () => {
    if (!selectedDispute) return;
    
    setDisputes(prev => prev.map(d => 
      d.id === selectedDispute.id ? { ...d, status: 'UNDER_REVIEW' } : d
    ));
    
    setSelectedDispute(prev => prev ? { ...prev, status: 'UNDER_REVIEW' } : null);
  };

  const closeModal = () => {
    setSelectedDispute(null);
    setResolutionAction('');
    setResolutionNotes('');
  };

  return (
    <div className="animate-in fade-in slide-in-from-bottom-4 duration-700 pb-10">
      <div className="flex justify-between items-center mb-6">
        <div>
          <h1 className="text-3xl font-bold tracking-tight text-white mb-2">Disputes Management</h1>
          <p className="text-gray-400">Review and resolve customer and washer disputes.</p>
        </div>
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-8">
        <div className="glass-panel p-5 rounded-2xl">
          <div className="flex justify-between items-start mb-2">
            <p className="text-gray-400 text-sm font-medium">Total Active Disputes</p>
            <ShieldAlert className="w-5 h-5 text-indigo-400" />
          </div>
          <p className="text-3xl font-bold text-white">{disputes.filter(d => d.status === 'OPEN' || d.status === 'UNDER_REVIEW').length}</p>
        </div>
        <div className="glass-panel p-5 rounded-2xl">
          <div className="flex justify-between items-start mb-2">
            <p className="text-gray-400 text-sm font-medium">Needs Attention (Open)</p>
            <AlertCircle className="w-5 h-5 text-red-400" />
          </div>
          <p className="text-3xl font-bold text-white">{disputes.filter(d => d.status === 'OPEN').length}</p>
        </div>
        <div className="glass-panel p-5 rounded-2xl">
          <div className="flex justify-between items-start mb-2">
            <p className="text-gray-400 text-sm font-medium">Under Review</p>
            <Clock className="w-5 h-5 text-amber-400" />
          </div>
          <p className="text-3xl font-bold text-white">{disputes.filter(d => d.status === 'UNDER_REVIEW').length}</p>
        </div>
        <div className="glass-panel p-5 rounded-2xl">
          <div className="flex justify-between items-start mb-2">
            <p className="text-gray-400 text-sm font-medium">Resolved Today</p>
            <CheckCircle className="w-5 h-5 text-green-400" />
          </div>
          <p className="text-3xl font-bold text-white">0</p>
        </div>
      </div>

      {/* Filters and Table */}
      <div className="glass-panel rounded-2xl border-white/10 overflow-hidden">
        <div className="p-4 border-b border-white/10 flex flex-col sm:flex-row gap-4 justify-between items-center bg-white/[0.02]">
          <div className="relative w-full sm:w-96">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-gray-400" />
            <input 
              type="text" 
              placeholder="Search by ID, Booking, Name..." 
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="w-full bg-black/20 border border-white/10 rounded-lg pl-10 pr-4 py-2 text-sm text-white placeholder:text-gray-500 focus:outline-none focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500 transition-all"
            />
          </div>
          
          <div className="flex items-center gap-2 w-full sm:w-auto overflow-x-auto pb-2 sm:pb-0 hide-scrollbar">
            <Filter className="w-4 h-4 text-gray-400 mr-2 shrink-0" />
            {(['ALL', 'OPEN', 'UNDER_REVIEW', 'RESOLVED', 'REJECTED'] as const).map(status => (
              <button
                key={status}
                onClick={() => setStatusFilter(status)}
                className={`px-3 py-1.5 rounded-lg text-xs font-medium whitespace-nowrap transition-colors ${
                  statusFilter === status 
                    ? 'bg-indigo-500 text-white' 
                    : 'bg-white/5 text-gray-400 hover:bg-white/10 hover:text-white'
                }`}
              >
                {status.replace('_', ' ')}
              </button>
            ))}
          </div>
        </div>

        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse">
            <thead>
              <tr className="border-b border-white/10 text-xs uppercase tracking-wider text-gray-400 bg-black/20">
                <th className="px-6 py-4 font-medium">Dispute</th>
                <th className="px-6 py-4 font-medium">Parties Involved</th>
                <th className="px-6 py-4 font-medium">Reason</th>
                <th className="px-6 py-4 font-medium">Reported</th>
                <th className="px-6 py-4 font-medium">Status</th>
                <th className="px-6 py-4 font-medium text-right">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-white/5">
              {filteredDisputes.length > 0 ? (
                filteredDisputes.map(dispute => (
                  <tr key={dispute.id} className="hover:bg-white/[0.02] transition-colors group">
                    <td className="px-6 py-4">
                      <div className="flex flex-col">
                        <span className="text-sm font-medium text-white">{dispute.id}</span>
                        <span className="text-xs text-gray-500 flex items-center gap-1 mt-1">
                          <Car className="w-3 h-3" /> {dispute.bookingId}
                        </span>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex flex-col gap-1 text-sm">
                        <div className="flex items-center gap-2">
                          <User className="w-3.5 h-3.5 text-gray-500" />
                          <span className="text-gray-300">{dispute.customerName} (C)</span>
                        </div>
                        <div className="flex items-center gap-2">
                          <User className="w-3.5 h-3.5 text-indigo-400" />
                          <span className="text-gray-300">{dispute.washerName} (W)</span>
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4">
                      <div className="flex flex-col">
                        <span className="text-sm text-gray-200">{dispute.reason}</span>
                        <span className="text-xs text-gray-500 mt-1">
                          Reported by: <span className="text-indigo-400">{dispute.reporter}</span>
                        </span>
                      </div>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <span className="text-sm text-gray-400 flex items-center gap-1.5">
                        <Calendar className="w-3.5 h-3.5" />
                        {new Date(dispute.dateReported).toLocaleDateString()}
                      </span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <StatusBadge status={dispute.status} />
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-right">
                      <button 
                        onClick={() => setSelectedDispute(dispute)}
                        className="inline-flex items-center gap-1.5 px-3 py-1.5 bg-white/5 hover:bg-white/10 text-white text-sm font-medium rounded-lg transition-colors"
                      >
                        <Eye className="w-4 h-4" /> View
                      </button>
                    </td>
                  </tr>
                ))
              ) : (
                <tr>
                  <td colSpan={6} className="px-6 py-12 text-center text-gray-500">
                    <ShieldAlert className="w-12 h-12 mx-auto mb-3 opacity-20" />
                    <p>No disputes found matching your criteria.</p>
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </div>

      {/* Dispute Detail Modal */}
      {selectedDispute && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 sm:p-6">
          <div className="absolute inset-0 bg-black/60 backdrop-blur-sm" onClick={closeModal} />
          
          <div className="relative w-full max-w-5xl max-h-[90vh] bg-slate-900 border border-white/10 rounded-2xl shadow-2xl overflow-hidden flex flex-col">
            {/* Modal Header */}
            <div className="flex items-center justify-between px-6 py-4 border-b border-white/10 bg-slate-900">
              <div className="flex items-center gap-3">
                <h2 className="text-lg font-semibold text-white flex items-center gap-2">
                  Dispute Details: <span className="text-indigo-400">{selectedDispute.id}</span>
                </h2>
                <StatusBadge status={selectedDispute.status} />
              </div>
              <button 
                onClick={closeModal}
                className="p-2 text-gray-400 hover:text-white hover:bg-white/10 rounded-full transition-colors"
              >
                <X className="w-5 h-5" />
              </button>
            </div>

            {/* Modal Body */}
            <div className="flex-1 overflow-y-auto p-6 flex flex-col lg:flex-row gap-8">
              
              {/* Left Column: Info & Evidence */}
              <div className="flex-1 space-y-8">
                
                {/* Details Section */}
                <section>
                  <h3 className="text-sm font-medium text-gray-400 uppercase tracking-wider mb-4 border-b border-white/10 pb-2">Information</h3>
                  
                  <div className="grid grid-cols-2 gap-4">
                    <div className="bg-white/5 p-4 rounded-xl border border-white/5">
                      <p className="text-xs text-gray-500 mb-1">Booking Reference</p>
                      <p className="text-sm font-medium text-white flex items-center gap-1.5"><Car className="w-4 h-4 text-indigo-400"/> {selectedDispute.bookingId}</p>
                    </div>
                    <div className="bg-white/5 p-4 rounded-xl border border-white/5">
                      <p className="text-xs text-gray-500 mb-1">Date Reported</p>
                      <p className="text-sm font-medium text-white flex items-center gap-1.5"><Calendar className="w-4 h-4 text-indigo-400"/> {new Date(selectedDispute.dateReported).toLocaleString()}</p>
                    </div>
                    <div className="bg-white/5 p-4 rounded-xl border border-white/5">
                      <p className="text-xs text-gray-500 mb-1">Customer</p>
                      <p className="text-sm font-medium text-white flex items-center gap-1.5"><User className="w-4 h-4 text-gray-400"/> {selectedDispute.customerName}</p>
                    </div>
                    <div className="bg-white/5 p-4 rounded-xl border border-white/5">
                      <p className="text-xs text-gray-500 mb-1">Washer</p>
                      <p className="text-sm font-medium text-white flex items-center gap-1.5"><User className="w-4 h-4 text-indigo-400"/> {selectedDispute.washerName}</p>
                    </div>
                  </div>
                </section>

                {/* Description Section */}
                <section>
                  <h3 className="text-sm font-medium text-gray-400 uppercase tracking-wider mb-4 border-b border-white/10 pb-2">Report Details</h3>
                  <div className="bg-white/5 p-5 rounded-xl border border-white/5">
                    <div className="flex items-start gap-3">
                      <MessageSquare className="w-5 h-5 text-indigo-400 mt-0.5 shrink-0" />
                      <div>
                        <p className="text-sm font-medium text-white mb-2">{selectedDispute.reason}</p>
                        <p className="text-sm text-gray-300 leading-relaxed">{selectedDispute.description}</p>
                      </div>
                    </div>
                  </div>
                </section>

                {/* Evidence Section */}
                <section>
                  <h3 className="text-sm font-medium text-gray-400 uppercase tracking-wider mb-4 border-b border-white/10 pb-2">Attached Evidence</h3>
                  {selectedDispute.evidenceUrls.length > 0 ? (
                    <div className="grid grid-cols-2 gap-4">
                      {selectedDispute.evidenceUrls.map((url, idx) => (
                        <div key={idx} className="relative group rounded-xl overflow-hidden border border-white/10 aspect-video bg-black">
                          <img src={url} alt={`Evidence ${idx + 1}`} className="w-full h-full object-cover" />
                        </div>
                      ))}
                    </div>
                  ) : (
                    <div className="flex flex-col items-center justify-center p-8 bg-white/5 rounded-xl border border-white/5 border-dashed">
                      <ImageIcon className="w-8 h-8 text-gray-600 mb-2" />
                      <p className="text-sm text-gray-500">No evidence attached.</p>
                    </div>
                  )}
                </section>
              </div>

              {/* Right Column: Resolution Form */}
              <div className="w-full lg:w-80 shrink-0">
                <div className="sticky top-0 bg-white/[0.02] p-5 rounded-2xl border border-white/10 h-full flex flex-col">
                  
                  {selectedDispute.status === 'OPEN' || selectedDispute.status === 'UNDER_REVIEW' ? (
                    <>
                      <h3 className="text-lg font-medium text-white mb-4 flex items-center gap-2">
                        <CheckCircle className="w-5 h-5 text-indigo-400" /> Resolution Actions
                      </h3>
                      
                      {selectedDispute.status === 'OPEN' && (
                        <button 
                          onClick={markUnderReview}
                          className="w-full mb-6 py-2 px-4 bg-amber-500/10 hover:bg-amber-500/20 text-amber-400 border border-amber-500/20 rounded-lg text-sm font-medium transition-colors flex items-center justify-center gap-2"
                        >
                          <Clock className="w-4 h-4" /> Mark as Under Review
                        </button>
                      )}
                      
                      <div className="space-y-4 flex-1">
                        <div>
                          <label className="block text-sm font-medium text-gray-300 mb-2">Action Required</label>
                          <select 
                            value={resolutionAction}
                            onChange={(e) => setResolutionAction(e.target.value as ResolutionAction)}
                            className="w-full bg-black/40 border border-white/10 rounded-lg px-3 py-2.5 text-sm text-white focus:outline-none focus:border-indigo-500 transition-colors"
                          >
                            <option value="" disabled>Select an action...</option>
                            <option value="FULL_REFUND">Issue Full Refund</option>
                            <option value="PARTIAL_REFUND">Issue Partial Refund</option>
                            <option value="WASHER_WARNING">Issue Warning to Washer</option>
                            <option value="WASHER_PENALTY">Apply Penalty to Washer</option>
                            <option value="DISMISS">Dismiss / Reject Dispute</option>
                          </select>
                        </div>
                        
                        <div>
                          <label className="block text-sm font-medium text-gray-300 mb-2">Resolution Notes</label>
                          <textarea 
                            value={resolutionNotes}
                            onChange={(e) => setResolutionNotes(e.target.value)}
                            placeholder="Provide details about the decision..."
                            className="w-full bg-black/40 border border-white/10 rounded-lg px-3 py-2.5 text-sm text-white focus:outline-none focus:border-indigo-500 transition-colors h-32 resize-none"
                          />
                        </div>
                      </div>

                      <div className="mt-6 pt-6 border-t border-white/10">
                        <button 
                          onClick={handleResolve}
                          disabled={!resolutionAction || !resolutionNotes.trim()}
                          className="w-full py-2.5 px-4 bg-indigo-600 hover:bg-indigo-700 disabled:bg-indigo-600/50 disabled:text-white/50 text-white rounded-lg text-sm font-medium transition-colors flex items-center justify-center gap-2 shadow-lg"
                        >
                          <Check className="w-4 h-4" /> Submit Resolution
                        </button>
                      </div>
                    </>
                  ) : (
                    <>
                      <h3 className="text-lg font-medium text-white mb-4 flex items-center gap-2">
                        <Info className="w-5 h-5 text-indigo-400" /> Resolution Details
                      </h3>
                      
                      {selectedDispute.resolution ? (
                        <div className="space-y-5">
                          <div>
                            <p className="text-xs text-gray-500 mb-1">Action Taken</p>
                            <div className="inline-block px-3 py-1 bg-white/10 rounded-lg text-sm text-white border border-white/5 font-medium">
                              {selectedDispute.resolution.action.replace('_', ' ')}
                            </div>
                          </div>
                          
                          <div>
                            <p className="text-xs text-gray-500 mb-1">Admin Notes</p>
                            <p className="text-sm text-gray-300 bg-black/20 p-3 rounded-lg border border-white/5 leading-relaxed">
                              {selectedDispute.resolution.notes}
                            </p>
                          </div>
                          
                          <div className="pt-4 border-t border-white/10 flex justify-between items-center text-xs text-gray-500">
                            <span>By {selectedDispute.resolution.resolvedBy}</span>
                            <span>{new Date(selectedDispute.resolution.resolvedAt).toLocaleDateString()}</span>
                          </div>
                        </div>
                      ) : (
                        <p className="text-sm text-gray-400">No resolution details found.</p>
                      )}
                    </>
                  )}
                </div>
              </div>

            </div>
          </div>
        </div>
      )}
    </div>
  );
}
