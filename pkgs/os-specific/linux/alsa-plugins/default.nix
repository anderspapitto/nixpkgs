{ stdenv, fetchurl, lib, pkg-config, alsaLib, libogg, libpulseaudio ? null, libjack2 ? null }:

stdenv.mkDerivation rec {
  pname = "alsa-plugins";
  version = "1.2.5";

  src = fetchurl {
    url = "mirror://alsa/plugins/${pname}-${version}.tar.bz2";
    sha256 = "086z2g2f95570vfvp9d5bakib4k18fb4bszf3lgx3j6j6f2gkvj2";
  };

  nativeBuildInputs = [ pkg-config ];

  # ToDo: a52, etc.?
  buildInputs =
    [ alsaLib libogg ]
    ++ lib.optional (libpulseaudio != null) libpulseaudio
    ++ lib.optional (libjack2 != null) libjack2;

  meta = with lib; {
    description = "Various plugins for ALSA";
    homepage = "http://alsa-project.org/";
    license = licenses.lgpl21;
    maintainers = [ maintainers.marcweber ];
    platforms = platforms.linux;
  };
}
