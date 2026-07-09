import type { Metadata } from "next";
import { Fira_Sans } from "next/font/google";
import "./globals.css";
import { Sidebar } from "@/components/layout/Sidebar";

const firaSans = Fira_Sans({ 
  subsets: ["latin"], 
  weight: ['300', '400', '500', '600', '700'],
  variable: '--font-fira'
});

export const metadata: Metadata = {
  title: "Vehicle Wash Admin",
  description: "Enterprise Admin Portal for Vehicle Wash Marketplace",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className="dark">
      <body
        className={`${firaSans.className} bg-[#0C0A09] text-stone-50 min-h-screen antialiased flex selection:bg-amber-500/30`}
      >
        {/* Premium Background Elements */}
        <div className="fixed inset-0 z-[-1] overflow-hidden pointer-events-none bg-[#0C0A09]">
          <div className="absolute top-0 left-0 w-full h-[500px] bg-gradient-to-b from-amber-900/10 to-transparent" />
          <div className="absolute top-[-20%] right-[-10%] w-[50%] h-[50%] rounded-full bg-amber-600/5 blur-[150px]" />
        </div>
        
        <Sidebar />
        
        <main className="flex-1 ml-64 p-8 relative overflow-y-auto h-screen scroll-smooth">
          <div className="max-w-7xl mx-auto">
            {children}
          </div>
        </main>
      </body>
    </html>
  );
}
