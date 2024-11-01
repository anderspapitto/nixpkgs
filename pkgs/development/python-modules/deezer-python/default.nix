{
  lib,
  buildPythonPackage,
  environs,
  fetchFromGitHub,
  httpx,
  poetry-core,
  pytest-mock,
  pytest-vcr,
  pytestCheckHook,
  pythonOlder,
  tornado,
}:

buildPythonPackage rec {
  pname = "deezer-python";
  version = "7.1.0";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "browniebroke";
    repo = "deezer-python";
    rev = "refs/tags/v${version}";
    hash = "sha256-d+cN6f6jw8D+noxyYl/TpDAkeTb8Krt+r0/Ai65cvdU=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace-fail " --cov=deezer" ""
  '';

  build-system = [ poetry-core ];

  dependencies = [
    httpx
    tornado
  ];

  nativeCheckInputs = [
    environs
    pytest-mock
    pytest-vcr
    pytestCheckHook
  ];

  pythonImportsCheck = [ "deezer" ];

  disabledTests = [
    # JSONDecodeError issue
    "test_get_user_flow"
    "test_with_language_header"
  ];

  meta = with lib; {
    description = "Python wrapper around the Deezer API";
    homepage = "https://github.com/browniebroke/deezer-python";
    changelog = "https://github.com/browniebroke/deezer-python/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ synthetica ];
  };
}
