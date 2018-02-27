with import <nixpkgs> {};

let
  nginxPort = "80";
  nginxConf = writeText "nginx.conf" ''
    user nginx nginx;
    daemon off;
    error_log /dev/stdout info;
    pid /dev/null;
    events {}
    http {
      access_log /dev/stdout;
      server {
        listen ${nginxPort};
        index index.html;
        location / {
          root ${nginxWebRoot};
        }
      }
    }
  '';
  nginxWebRoot = writeTextDir "index.html" ''
    <html><body><span>Hello from nginx inside Docker container!</span></body></html>
  '';
in
dockerTools.buildImage {
  name = "nginx";
  tag = "latest";

  contents = pkgs.nginx;

  runAsRoot = ''
    #!${stdenv.shell}
    ${dockerTools.shadowSetup}
    groupadd --system nginx
    useradd --system --gid nginx nginx
  '';

  config = {
    Cmd = [ "nginx" "-c" nginxConf ];
    ExposedPorts = {
      "${nginxPort}/tcp" = {};
    };
  };
}

