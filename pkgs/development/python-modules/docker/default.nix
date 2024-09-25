{
  lib,
  stdenv,
  buildPythonPackage,
  fetchFromGitHub,
  pythonOlder,

  # build-system
  hatchling,
  hatch-vcs,

  # dependencies
  packaging,
  requests,
  urllib3,

  # optional-dependencies
  paramiko,
  pynacl,  # optional in paramiko, required here
  websocket-client,

  # tests
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "docker";
  version = "7.1.0";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "docker";
    repo = "docker-py";
    rev = "refs/tags/${version}";
    hash = "sha256-sk6TZLek+fRkKq7kG9g6cR9lvfPC8v8qUXKb7Tq4pLU=";
  };

  build-system = [
    hatchling
    hatch-vcs
  ];

  dependencies = [
    packaging
    requests
    urllib3
  ];

  optional-dependencies = {
    ssh = [ paramiko paramiko.optional-dependencies.ed25519 ];
    tls = [];
    websockets = [ websocket-client ];
  };

  pythonImportsCheck = [ "docker" ];

  nativeCheckInputs = [
    pytestCheckHook
    paramiko
    pynacl
    websocket-client
  ];

  pytestFlagsArray = [ "tests/unit" ];

  # Deselect socket tests on Darwin because it hits the path length limit for a Unix domain socket
  disabledTests = lib.optionals stdenv.hostPlatform.isDarwin [
    "api_test"
    "stream_response"
    "socket_file"
  ];

  meta = with lib; {
    changelog = "https://github.com/docker/docker-py/releases/tag/${version}";
    description = "API client for docker written in Python";
    homepage = "https://github.com/docker/docker-py";
    license = licenses.asl20;
    maintainers = [ ];
  };
}
