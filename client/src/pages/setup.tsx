import { useState } from "react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Plug, Settings } from "lucide-react";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import { apiRequest } from "@/lib/queryClient";
import { useToast } from "@/hooks/use-toast";
import { ModuleInstallation } from "@/components/module-installation";
import { PowerShellTerminal } from "@/components/powershell-terminal";
import { AuthDialog } from "@/components/auth-dialog";
import { TenantInfo } from "@/components/tenant-info";

export default function SetupPage() {
  const [tenantDomain, setTenantDomain] = useState("");
  const [authMethod, setAuthMethod] = useState("interactive");
  const [showAuthDialog, setShowAuthDialog] = useState(false);
  const { toast } = useToast();
  const queryClient = useQueryClient();

  const connectExchangeMutation = useMutation({
    mutationFn: () => apiRequest('POST', '/api/connections/exchange', { 
      tenantDomain: tenantDomain || undefined 
    }),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['/api/connections'] });
      toast({
        title: "Connection Started",
        description: "Connecting to Exchange Online...",
      });
    },
    onError: () => {
      toast({
        title: "Connection Failed",
        description: "Failed to connect to Exchange Online",
        variant: "destructive",
      });
    },
  });

  const connectPlacesMutation = useMutation({
    mutationFn: () => apiRequest('POST', '/api/connections/places'),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['/api/connections'] });
      toast({
        title: "Places Connected",
        description: "Successfully connected to Microsoft Places",
      });
    },
    onError: () => {
      toast({
        title: "Connection Failed",
        description: "Failed to connect to Microsoft Places",
        variant: "destructive",
      });
    },
  });

  return (
    <div className="space-y-8">
      {/* Installation Steps */}
      {/* Tenant Information */}
      <TenantInfo />

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Module Installation */}
        <ModuleInstallation />

        {/* Connection Configuration */}
        <Card>
          <CardHeader>
            <div className="flex items-center space-x-3">
              <div className="w-10 h-10 bg-green-500 rounded-lg flex items-center justify-center">
                <Plug className="text-white" size={20} />
              </div>
              <div>
                <CardTitle>Connection Setup</CardTitle>
                <p className="text-sm text-muted-foreground">Establish service connections</p>
              </div>
            </div>
          </CardHeader>
          <CardContent className="space-y-4">
            <div className="text-sm text-muted-foreground space-y-2">
              <p>After installing the required modules, connect to your Exchange Online environment to manage Microsoft Places.</p>
              <p>You'll need Microsoft 365 admin credentials with Places Administrator permissions.</p>
            </div>

            <div className="flex space-x-3 pt-4">
              <Button
                className="flex-1"
                onClick={() => setShowAuthDialog(true)}
                disabled={connectExchangeMutation.isPending}
              >
                <Plug size={16} className="mr-2" />
                Connect to Exchange Online
              </Button>
              <Button
                variant="secondary"
                className="flex-1"
                onClick={() => connectPlacesMutation.mutate()}
                disabled={connectPlacesMutation.isPending}
              >
                <Plug size={16} className="mr-2" />
                Connect Places
              </Button>
            </div>
          </CardContent>
        </Card>
      </div>

      {/* Command Execution Terminal */}
      <PowerShellTerminal />

      {/* Authentication Dialog */}
      <AuthDialog 
        open={showAuthDialog} 
        onOpenChange={setShowAuthDialog}
      />
    </div>
  );
}
