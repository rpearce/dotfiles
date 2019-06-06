{ mkDerivation, stdenv, haskellPackages, fetchFromGitHub, base, directory }:

haskellPackages.mkDerivation rec {
  pname = "timetrack-cli";
  version = "0.1.0.3";

  src = fetchFromGitHub {
    owner = "rpearce";
    repo = "timetrack-cli";
    rev = "v${version}";
    sha256 = "09z29i1pw6c6a2mwl9dnp121nq9ijw3891yffqw7ilb4rq83gbzh";
  };

  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base directory ];

  description = "Use the command line to keep track of your working hours in plain text files";
  homepage    = https://github.com/rpearce/timetrack-cli;
  license     = stdenv.lib.licenses.bsd3;
  maintainers = with stdenv.lib.maintainers; [ rpearce ];
}
