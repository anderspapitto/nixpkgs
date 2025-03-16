{
  buildPostgresqlExtension,
  cmake,
  fetchFromGitHub,
  h3_4,
  lib,
  postgresql,
  postgresqlTestExtension,
  stdenv,
}:

buildPostgresqlExtension (finalAttrs: {
  pname = "h3-pg";
  version = "4.2.2";

  src = fetchFromGitHub {
    owner = "zachasme";
    repo = "h3-pg";
    tag = "v${finalAttrs.version}";
    hash = "sha256-2xp9gssPMTroLT/1Me0VWvtIPyouIk9MW0Rp13uYBEw=";
  };

  postPatch =
    ''
      substituteInPlace CMakeLists.txt \
        --replace-fail "add_subdirectory(cmake/h3)" "include_directories(${lib.getDev h3_4}/include/h3)"
    ''
    + lib.optionalString stdenv.hostPlatform.isDarwin ''
      substituteInPlace cmake/AddPostgreSQLExtension.cmake \
        --replace-fail "INTERPROCEDURAL_OPTIMIZATION TRUE" ""
    '';

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
    h3_4
  ];

  passthru.tests.extension = postgresqlTestExtension {
    inherit (finalAttrs) finalPackage;
    withPackages = [ "postgis" ];
    sql = ''
      CREATE EXTENSION h3;
      CREATE EXTENSION h3_postgis CASCADE;

      SELECT h3_lat_lng_to_cell(POINT('37.3615593,-122.0553238'), 5);
      SELECT ST_NPoints(h3_cell_to_boundary_geometry('8a63a9a99047fff'));
    '';
  };

  meta = {
    description = "PostgreSQL bindings for H3, a hierarchical hexagonal geospatial indexing system";
    homepage = "https://github.com/zachasme/h3-pg";
    license = lib.licenses.asl20;
    maintainers = [ ];
    inherit (postgresql.meta) platforms;
  };
})
