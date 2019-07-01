{ mkDerivation, aeson, ansi-terminal, ansi-wl-pprint, base
, base64-bytestring, bytestring, colour, containers, directory
, filepath, mtl, network, network-uri, optparse-applicative, pandoc
, process, skylighting, stdenv, terminal-size, text, time
, unordered-containers, yaml
, haskellPackages
}:

haskellPackages.mkDerivation rec {
  pname = "patat";
  version = "0.8.2.3";
  src = ~/projects/patat/.;
  #src = fetchFromGitHub {
  #  owner = "rpearce";
  #  repo = "timetrack-cli";
  #  rev = "v${version}";
  #  sha256 = "0hqmjn3ddkq1prhp5kdz0mjskfgbcm4wh5p0nkr0m7ymxscn097q";
  #};

  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    aeson ansi-terminal ansi-wl-pprint base base64-bytestring
    bytestring colour containers directory filepath mtl network
    network-uri optparse-applicative pandoc process skylighting
    terminal-size text time unordered-containers yaml
  ];

  homepage = "http://github.com/jaspervdj/patat";
  description = "Terminal-based presentations using Pandoc";
  license = stdenv.lib.licenses.gpl2;
  maintainers = with stdenv.lib.maintainers; [ jaspervdj ];
}
