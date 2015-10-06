let
  credentials = SCRUBBED;
  relayRegion = "us-central1";
in
{
  resources.gceStaticIPs."relay-ip" = credentials // {
    region = relayRegion;
  };
  resources.gceDisks."relay-homes" = credentials // {
    region = relayRegion;
    diskType = "standard";
    size = 10;
    name = "relay-homes";
  };
  relay = {resources, ...}: {
    deployment.targetEnv = "gce";
    deployment.encryptedLinksTo = [];
    deployment.gce = credentials // {
      region = relayRegion;
      instanceType = "f1-micro";
      ipAddress = resources.gceStaticIPs."relay-ip";
    };

    fileSystems."/home" = {
      autoFormat = true;
      fsType = "ext4";
      gce.disk = resources.gceDisks."relay-homes";
    };
  };
}
