{ mkDerivation, stdenv, haskellPackages, fetchFromGitHub, base, directory }:

haskellPackages.mkDerivation rec {
  pname = "timetrack-cli";
  version = "0.1.0.2";

  src = fetchFromGitHub {
    owner = "rpearce";
    repo = "timetrack-cli";
    rev = "v${version}";
    sha256 = "00qd3s3lshhp2njkk5g3p8fi68wph1qd05zir2g8r0gpl4vr6yp4";
  };

  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base directory ];

  description = "Use the command line to keep track of your working hours in plain text files";
  homepage    = https://github.com/rpearce/timetrack-cli;
  license     = stdenv.lib.licenses.bsd3;
  maintainers = with stdenv.lib.maintainers; [ rpearce ];
}
