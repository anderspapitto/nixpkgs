{
  lib,
  boto3,
  buildPythonPackage,
  fetchPypi,
  pythonOlder,
  setuptools,
  typing-extensions,
}:
let
  toUnderscore = str: builtins.replaceStrings [ "-" ] [ "_" ] str;

  buildMypyBoto3Package =
    serviceName: version: hash:
    buildPythonPackage rec {
      pname = "mypy-boto3-${serviceName}";
      inherit version;
      pyproject = true;

      disabled = pythonOlder "3.7";

      src = fetchPypi {
        pname = "mypy_boto3_${toUnderscore serviceName}";
        inherit version hash;
      };

      build-system = [ setuptools ];

      dependencies = [ boto3 ] ++ lib.optionals (pythonOlder "3.12") [ typing-extensions ];

      # Project has no tests
      doCheck = false;

      pythonImportsCheck = [ "mypy_boto3_${toUnderscore serviceName}" ];

      meta = with lib; {
        description = "Type annotations for boto3 ${serviceName}";
        homepage = "https://github.com/youtype/mypy_boto3_builder";
        license = with licenses; [ mit ];
        maintainers = with maintainers; [
          fab
          mbalatsko
        ];
      };
    };
in
rec {
  mypy-boto3-accessanalyzer =
    buildMypyBoto3Package "accessanalyzer" "1.37.0"
      "sha256-mm2NgDfVTGN4LqbUR0YJhMwmcsftMRpyg3QZNo/p2Ko=";

  mypy-boto3-account =
    buildMypyBoto3Package "account" "1.37.0"
      "sha256-jw5HNxl27fEtBEfkK4oHQICMtF8W91mKyU5lTlhCndc=";

  mypy-boto3-acm =
    buildMypyBoto3Package "acm" "1.37.0"
      "sha256-gsMMlrHbh6ngwsbRlSKXn5M9WnJ/x3n8wp1xeyCuZKs=";

  mypy-boto3-acm-pca =
    buildMypyBoto3Package "acm-pca" "1.37.0"
      "sha256-Wi7ObxF433J/tamCPrjyDefvARAl35suSR74foUS5ko=";

  mypy-boto3-amp =
    buildMypyBoto3Package "amp" "1.37.0"
      "sha256-rxpBCIXOkSl5UeP1e0Rz8VK4tU3qD7nqG77YiGTv/0U=";

  mypy-boto3-amplify =
    buildMypyBoto3Package "amplify" "1.37.0"
      "sha256-u3dXLZ2cSPWfOyzvWh/TtXaPz9Oaon3LqcQXhnEa67Q=";

  mypy-boto3-amplifybackend =
    buildMypyBoto3Package "amplifybackend" "1.37.0"
      "sha256-uLmvOXUQwovfh97MWlKIqJwey2oLffriJfKJS3YxnDM=";

  mypy-boto3-amplifyuibuilder =
    buildMypyBoto3Package "amplifyuibuilder" "1.37.0"
      "sha256-QDagskTiBtIbR8dIh5E3bdAxaezblNXWNEGGmNUcrWY=";

  mypy-boto3-apigateway =
    buildMypyBoto3Package "apigateway" "1.37.0"
      "sha256-VS0iDnBlRPV6KBDC198tkxECMC13W1jjujsmig174BE=";

  mypy-boto3-apigatewaymanagementapi =
    buildMypyBoto3Package "apigatewaymanagementapi" "1.37.0"
      "sha256-Y6BQWnf8h7ec2Rt4bhuyAl1KAIe53rnhTupcNeROQ8I=";

  mypy-boto3-apigatewayv2 =
    buildMypyBoto3Package "apigatewayv2" "1.37.0"
      "sha256-vF9qDs4R1LCPpYjdRqSEmTB64rOTKToJjmKwHlwOkyc=";

  mypy-boto3-appconfig =
    buildMypyBoto3Package "appconfig" "1.37.0"
      "sha256-dXyky8lKmsgsiClukddDdKHAwu1V7dlD71WShhzYBJE=";

  mypy-boto3-appconfigdata =
    buildMypyBoto3Package "appconfigdata" "1.37.0"
      "sha256-RPLid9Y3w84UcTJoZaxOEX5Faghne85+JA+RhsJs2pw=";

  mypy-boto3-appfabric =
    buildMypyBoto3Package "appfabric" "1.37.0"
      "sha256-Cpfs4Z5ziJoW32uwFQNhwpj6uRCjURn30LGL+/iL/1w=";

  mypy-boto3-appflow =
    buildMypyBoto3Package "appflow" "1.37.0"
      "sha256-VRNuh0ldVT7I2Pml5WzJpz1yvs3K1hlMgHIpcFTGuuE=";

  mypy-boto3-appintegrations =
    buildMypyBoto3Package "appintegrations" "1.37.0"
      "sha256-tyUEvQdkjZZYaGytrQOK2TOGrhKlVikdxyECl6Zz57M=";

  mypy-boto3-application-autoscaling =
    buildMypyBoto3Package "application-autoscaling" "1.37.0"
      "sha256-lcpglldLcTNS22dpGNB/NnDt1CPOUAzwVdcWoRMzHyE=";

  mypy-boto3-application-insights =
    buildMypyBoto3Package "application-insights" "1.37.0"
      "sha256-2NYYxdpcfu21ZhCAuoTR1d0QihRCHM49Sb1nqfOHLgk=";

  mypy-boto3-applicationcostprofiler =
    buildMypyBoto3Package "applicationcostprofiler" "1.37.0"
      "sha256-hL42qeJXsW9DGu8Q8U5QEBJEHSa5WsneEk0obz9MHeY=";

  mypy-boto3-appmesh =
    buildMypyBoto3Package "appmesh" "1.37.0"
      "sha256-XqjSIzrwDJt/3sezSWzHAklsUuUttuBs6THG5ghvdow=";

  mypy-boto3-apprunner =
    buildMypyBoto3Package "apprunner" "1.37.0"
      "sha256-HNZHoep58nGU3b6e5s3X9RGBORJy6ogNT6Jbz0fNmOk=";

  mypy-boto3-appstream =
    buildMypyBoto3Package "appstream" "1.37.0"
      "sha256-v47OKnLvmkjv8+HBRlrv+wP+MIapoiz3HGplK6SEXGM=";

  mypy-boto3-appsync =
    buildMypyBoto3Package "appsync" "1.37.0"
      "sha256-KuiUFCfIcGHwIRrKsezOcGodrA3UrqdDPI3yl5Lpkmw=";

  mypy-boto3-arc-zonal-shift =
    buildMypyBoto3Package "arc-zonal-shift" "1.37.0"
      "sha256-3s+fYgf1gAy1o5V0uNrUcznLplweWm+2mTgMl4cmMWQ=";

  mypy-boto3-athena =
    buildMypyBoto3Package "athena" "1.37.0"
      "sha256-qBzg02M7akfgvbBeeg2T++ahv9cr712G+/3oyhU37Q8=";

  mypy-boto3-auditmanager =
    buildMypyBoto3Package "auditmanager" "1.37.0"
      "sha256-wH8zPvix4Yd0uBbz71EJmk6YWe/bBZz4v+QHjl2yud0=";

  mypy-boto3-autoscaling =
    buildMypyBoto3Package "autoscaling" "1.37.0"
      "sha256-C28bRk0IhJreEN0Zs/SfyBrhnvV12+Lbojp2oGJenfc=";

  mypy-boto3-autoscaling-plans =
    buildMypyBoto3Package "autoscaling-plans" "1.37.0"
      "sha256-cHLVZqOWxEFgselqi+XBqItepzP8hND1Ef7jHDOLdNU=";

  mypy-boto3-backup =
    buildMypyBoto3Package "backup" "1.37.0"
      "sha256-s4fJlVo+fCChHPX7YNaFVv7JHBfVegr9ce26VxVQ1v4=";

  mypy-boto3-backup-gateway =
    buildMypyBoto3Package "backup-gateway" "1.37.0"
      "sha256-SFybjQDlMxvgIFQbv/D6wDexm+s4u26I6Lj2T94vwak=";

  mypy-boto3-batch =
    buildMypyBoto3Package "batch" "1.37.0"
      "sha256-FRkn9wyzw5uuM8i40Vj+Nv7+gRN8jAa7ijfIWcU3XWo=";

  mypy-boto3-billingconductor =
    buildMypyBoto3Package "billingconductor" "1.37.0"
      "sha256-/SE9khiBMUq4oKpg58wUlIuauRerWWm40K3d/soRxv4=";

  mypy-boto3-braket =
    buildMypyBoto3Package "braket" "1.37.0"
      "sha256-qGK4daMp3zODuppGz335Or5hpggK6uTkbQqfXOKq6eM=";

  mypy-boto3-budgets =
    buildMypyBoto3Package "budgets" "1.37.0"
      "sha256-M1WWs/HMcN0L9qK2eu4x+JmZsvbEbmxZzQBkjU5gfh4=";

  mypy-boto3-ce =
    buildMypyBoto3Package "ce" "1.37.0"
      "sha256-nlk8Jb31LevHaTX8DwCv6H3h6CSQKzoBwXWDqgfqZa0=";

  mypy-boto3-chime =
    buildMypyBoto3Package "chime" "1.37.0"
      "sha256-SzXIm9zxflVGjvmCa/15Dg3lG782PIuHozbVtEpFDnI=";

  mypy-boto3-chime-sdk-identity =
    buildMypyBoto3Package "chime-sdk-identity" "1.37.0"
      "sha256-iGZ9RTkHEJwMWwr2n4+WMtl4RtLmhXT2wMXixx4Akek=";

  mypy-boto3-chime-sdk-media-pipelines =
    buildMypyBoto3Package "chime-sdk-media-pipelines" "1.37.0"
      "sha256-8mTGUxCx/HeIWtwj9mHejVRBMQSNjv8MeLdWTTpwA7Y=";

  mypy-boto3-chime-sdk-meetings =
    buildMypyBoto3Package "chime-sdk-meetings" "1.37.0"
      "sha256-k/OxG9pwEz+dUNohIHocantP82rho4C407lnaU9LA/8=";

  mypy-boto3-chime-sdk-messaging =
    buildMypyBoto3Package "chime-sdk-messaging" "1.37.0"
      "sha256-c7p/kch9H2Skn48ue8emfMkt5+mTmLZWEeuAuAhvX0w=";

  mypy-boto3-chime-sdk-voice =
    buildMypyBoto3Package "chime-sdk-voice" "1.37.0"
      "sha256-FINgDMmIhMn5M/qVGE3rzZJZEU121rDXNQYa39veAYk=";

  mypy-boto3-cleanrooms =
    buildMypyBoto3Package "cleanrooms" "1.37.0"
      "sha256-ovn/hkWHBBTUsDkQppzTApcVRYZXwxTOugZHIPnbCQk=";

  mypy-boto3-cloud9 =
    buildMypyBoto3Package "cloud9" "1.37.0"
      "sha256-ihfdqDnLejO7jEpXp1UPzeOWZTk2RgCBDbSIYJsy0oU=";

  mypy-boto3-cloudcontrol =
    buildMypyBoto3Package "cloudcontrol" "1.37.0"
      "sha256-BmOYLQsJB84gWmOepiX/8D+E6iE9BXKSYJnvdrUOb7M=";

  mypy-boto3-clouddirectory =
    buildMypyBoto3Package "clouddirectory" "1.37.0"
      "sha256-lIkRuhQHTqlXRkyf9hIIZ0oh3vgdr5GzLApLt9lXvaw=";

  mypy-boto3-cloudformation =
    buildMypyBoto3Package "cloudformation" "1.37.0"
      "sha256-v8dLqGFGcUBuEfKEYJZ0FnUz7aIg3WNcL7gky2Ajuu0=";

  mypy-boto3-cloudfront =
    buildMypyBoto3Package "cloudfront" "1.37.0"
      "sha256-64htrgGn+WKIbNszPP5GX5X1Hr7lE5+tuxVRu6XK9Fg=";

  mypy-boto3-cloudhsm =
    buildMypyBoto3Package "cloudhsm" "1.37.0"
      "sha256-TfXQ7WusMBtFnYahTsFUezH3WjwCZwi18ZfrdVQ6jpk=";

  mypy-boto3-cloudhsmv2 =
    buildMypyBoto3Package "cloudhsmv2" "1.37.0"
      "sha256-qNrd2rqQOdp3KHc+qbFr7JipKYOTC6GYOIvZ1evaUD0=";

  mypy-boto3-cloudsearch =
    buildMypyBoto3Package "cloudsearch" "1.37.0"
      "sha256-UxNVDqlpS9Uuh50DTHmtWhcGNEyN2o2vdJ363JYikOE=";

  mypy-boto3-cloudsearchdomain =
    buildMypyBoto3Package "cloudsearchdomain" "1.37.0"
      "sha256-6tc2bij0RUtPFNgefY9R60Zh6mSEvWTYTWoaeNweNpg=";

  mypy-boto3-cloudtrail =
    buildMypyBoto3Package "cloudtrail" "1.37.0"
      "sha256-qBBsxvlXnJHiRrGUQFWMoEeIvLJsC8TVnV7UtBbSRWQ=";

  mypy-boto3-cloudtrail-data =
    buildMypyBoto3Package "cloudtrail-data" "1.37.0"
      "sha256-7pvwZiB49BKMjtIinH4mP9ANB/Lmz+t9lGDe4/npbkg=";

  mypy-boto3-cloudwatch =
    buildMypyBoto3Package "cloudwatch" "1.37.0"
      "sha256-opF62LDq9qj0vLpAUrSVSI1aTRtpSk3z2yiJtvUsnNI=";

  mypy-boto3-codeartifact =
    buildMypyBoto3Package "codeartifact" "1.37.0"
      "sha256-nVAeLXy2hjJZDjNTjFccKClY7DS0oLv9Q9QLlngkX6M=";

  mypy-boto3-codebuild =
    buildMypyBoto3Package "codebuild" "1.37.1"
      "sha256-8Z+3exV0XBznoiPVFcisI+8BP7HL5ZLxJ6NHUoD6lNU=";

  mypy-boto3-codecatalyst =
    buildMypyBoto3Package "codecatalyst" "1.37.0"
      "sha256-TlaHDYxzCGSqT0a6M6NeY2tQvzMofBdnIi/j7Ylc2Fc=";

  mypy-boto3-codecommit =
    buildMypyBoto3Package "codecommit" "1.37.0"
      "sha256-hg72Shw9ceqVqiuETPt6NNnvR7WaASg6CJLI2nfRV20=";

  mypy-boto3-codedeploy =
    buildMypyBoto3Package "codedeploy" "1.37.0"
      "sha256-J8Gj/NH17QlI6rfqt4kdp+FhW3n+KNp+vTA3Wevs2Lk=";

  mypy-boto3-codeguru-reviewer =
    buildMypyBoto3Package "codeguru-reviewer" "1.37.0"
      "sha256-rCeCZ4BgNHxS9Su5nh/Ho8Ka2NSizmztBNRDMzMw01U=";

  mypy-boto3-codeguru-security =
    buildMypyBoto3Package "codeguru-security" "1.37.0"
      "sha256-7WCHPCcPl1d9j0dWT8KdokZkEKOvtb+ablzcRnrjwng=";

  mypy-boto3-codeguruprofiler =
    buildMypyBoto3Package "codeguruprofiler" "1.36.0"
      "sha256-5weqZgq2tnFneI4MXEAwunYBoUlDBJhSiptnXj5IeNk=";

  mypy-boto3-codepipeline =
    buildMypyBoto3Package "codepipeline" "1.36.24"
      "sha256-z/7o4ZGaQp71yJkoAJFBFpuDsHBgdQW1TYd4M8XjAS8=";

  mypy-boto3-codestar =
    buildMypyBoto3Package "codestar" "1.35.0"
      "sha256-B9Aq+hh9BOzCIYMkS21IZYb3tNCnKnV2OpSIo48aeJM=";

  mypy-boto3-codestar-connections =
    buildMypyBoto3Package "codestar-connections" "1.36.0"
      "sha256-OfDE5Ngx8+MkxcbX1T2EvA1ba6B9ISRVt4ryhHNYSjE=";

  mypy-boto3-codestar-notifications =
    buildMypyBoto3Package "codestar-notifications" "1.36.0"
      "sha256-PWvj/RzcfvUQugRLUkBcO8G69T2vNnsaB6y1EmZ+Pfo=";

  mypy-boto3-cognito-identity =
    buildMypyBoto3Package "cognito-identity" "1.36.0"
      "sha256-nO1+08anNtpqBSO8zIQs1p8bDAWYhFMp/bexSWWgBaE=";

  mypy-boto3-cognito-idp =
    buildMypyBoto3Package "cognito-idp" "1.36.3"
      "sha256-MEk24PAeivKmBAmagBJvmOEvoBDUiCjlN7bLqjH3Yqc=";

  mypy-boto3-cognito-sync =
    buildMypyBoto3Package "cognito-sync" "1.36.0"
      "sha256-vSKgq4NK3xODiaAm84Ad4BXWVRYmO2+5f0lZYUAVnQE=";

  mypy-boto3-comprehend =
    buildMypyBoto3Package "comprehend" "1.36.0"
      "sha256-xOanwN2CX9+0dF89nsKVOMqbKoQYFhhzXH2ZYVcs5to=";

  mypy-boto3-comprehendmedical =
    buildMypyBoto3Package "comprehendmedical" "1.36.0"
      "sha256-xG6gwY/pkE19QKs7WJ/0/XVJa4wvuqJvnnvgK3zOy5g=";

  mypy-boto3-compute-optimizer =
    buildMypyBoto3Package "compute-optimizer" "1.36.0"
      "sha256-DF4h2RSEqLUh/tBbM1hn+sJe7sgKE0Puru924M8AU20=";

  mypy-boto3-config =
    buildMypyBoto3Package "config" "1.36.0"
      "sha256-VK7/vxmSeMHYNow/ifwEYB8w/35PQfUiMhinyKNlDJ8=";

  mypy-boto3-connect =
    buildMypyBoto3Package "connect" "1.36.21"
      "sha256-RYsdpVuGbjbBF48dLNRT0d4Ne0injVvKQGsy7CXnnZY=";

  mypy-boto3-connect-contact-lens =
    buildMypyBoto3Package "connect-contact-lens" "1.36.0"
      "sha256-73ODpCcmgtPk5Zb8KzofJ7fiBPZamlLdFHWMN/uOtN8=";

  mypy-boto3-connectcampaigns =
    buildMypyBoto3Package "connectcampaigns" "1.36.0"
      "sha256-2wNQJFcUo9VO5387QSE1kGyTA8oHkFAPgdEIMdQqSo0=";

  mypy-boto3-connectcases =
    buildMypyBoto3Package "connectcases" "1.36.15"
      "sha256-M0TsvGiiw66MBc3LCThjho+1c094x8JbUyEtWN00pyc=";

  mypy-boto3-connectparticipant =
    buildMypyBoto3Package "connectparticipant" "1.36.0"
      "sha256-2IkBKbj+u5X6PJu4geV51jO9oCq02t22rUCq9VTmJZo=";

  mypy-boto3-controltower =
    buildMypyBoto3Package "controltower" "1.36.0"
      "sha256-WLflw9l+Hl+fhdQzVECiTo18Wl1vvE1bx8Rut3/y9uA=";

  mypy-boto3-cur =
    buildMypyBoto3Package "cur" "1.36.0"
      "sha256-9XuhrMQH+zXq2JaRgwXYUMQcVcuqTNHyfuj47gC4OZY=";

  mypy-boto3-customer-profiles =
    buildMypyBoto3Package "customer-profiles" "1.36.0"
      "sha256-V9sxGG4Fb/h1hLzHI/S63hx91KiA8vKd0kFxL4LHUtE=";

  mypy-boto3-databrew =
    buildMypyBoto3Package "databrew" "1.36.0"
      "sha256-IrLzHBqQpINtGnwBdkXusY7QLE9puKbZmaWCEy2br98=";

  mypy-boto3-dataexchange =
    buildMypyBoto3Package "dataexchange" "1.36.0"
      "sha256-PWkUc6sIG/PufTPU+nTnPvWy9xs/d6itT1yx8W7OvCA=";

  mypy-boto3-datapipeline =
    buildMypyBoto3Package "datapipeline" "1.36.0"
      "sha256-BThesaer2rOGyx8OtRo6cWQoX2xnyTgSgi3amd+qDrU=";

  mypy-boto3-datasync =
    buildMypyBoto3Package "datasync" "1.36.13"
      "sha256-FiJ3WZv0QYq3lV7WfKRYGfoxJpYWFVjyx9m7/nT8sLA=";

  mypy-boto3-dax =
    buildMypyBoto3Package "dax" "1.36.0"
      "sha256-UkuWWk99OTXMMhYMuAby9rbJjlhYBI0WwA9clnz4U9A=";

  mypy-boto3-detective =
    buildMypyBoto3Package "detective" "1.36.2"
      "sha256-91C7CVfMmGvvfm4GdnDuWzSXi1sDsL5qj8YLC17loiI=";

  mypy-boto3-devicefarm =
    buildMypyBoto3Package "devicefarm" "1.36.0"
      "sha256-IipLmvFCzQ9GA8BcOtRwORY+RORxS2UArh+qmcY/sKM=";

  mypy-boto3-devops-guru =
    buildMypyBoto3Package "devops-guru" "1.36.0"
      "sha256-2B9WXAldrhCN91Bfpy14FU6nW4IFi8tbyc+ToppCzFU=";

  mypy-boto3-directconnect =
    buildMypyBoto3Package "directconnect" "1.36.0"
      "sha256-vsQqIfI1pCzglFLq6/3NU+V98viLpOXe7ga3t4RhSRE=";

  mypy-boto3-discovery =
    buildMypyBoto3Package "discovery" "1.36.0"
      "sha256-eEgRtTa8uwRsrixtrGrnn2vRSrHC+a3FXVtrt1t3DmY=";

  mypy-boto3-dlm =
    buildMypyBoto3Package "dlm" "1.36.0"
      "sha256-si7pjgKzxg++SfVdOsIQP37rXG84IZM0ltcwc2+wn3I=";

  mypy-boto3-dms =
    buildMypyBoto3Package "dms" "1.36.22"
      "sha256-Pc4KEedGm6ASBM0nBnOrnyTgv46rQ3D+hRsdP2x/xvs=";

  mypy-boto3-docdb =
    buildMypyBoto3Package "docdb" "1.36.0"
      "sha256-gDpPgNv3/zpJDnQr50BA4Khylz1HKwghNN4QKwHm28U=";

  mypy-boto3-docdb-elastic =
    buildMypyBoto3Package "docdb-elastic" "1.36.0"
      "sha256-+eIiLbW/GBQkx0yfwUmxTAPGCUGxUCgTrkDWXJZNHfc=";

  mypy-boto3-drs =
    buildMypyBoto3Package "drs" "1.36.0"
      "sha256-knGzFh7hI8OFxMIMtix8TRw4QsOymWg44sTX+3Iu8aA=";

  mypy-boto3-ds =
    buildMypyBoto3Package "ds" "1.36.0"
      "sha256-8aWD6LDmLO9htE7SO2xu0IMRdRcSGrO3+NQNtR439MM=";

  mypy-boto3-dynamodb =
    buildMypyBoto3Package "dynamodb" "1.36.0"
      "sha256-FofkaJI2pTkXVRJuhuwlltQI65VAjDGsCaPR6yidUW0=";

  mypy-boto3-dynamodbstreams =
    buildMypyBoto3Package "dynamodbstreams" "1.36.0"
      "sha256-TSLvTHGLuEIAsJnlaeCwrOgX+Sgl2cqUkxURwHGZsPg=";

  mypy-boto3-ebs =
    buildMypyBoto3Package "ebs" "1.36.0"
      "sha256-YrzTW5fEsZPDu4p84jhY4avS/wM01XybrvGCOtF48cQ=";

  mypy-boto3-ec2 =
    buildMypyBoto3Package "ec2" "1.36.18"
      "sha256-9+Qt4q49OI2HaYmwbPGmLdGJb9th192Hy3C6GW0p2+E=";

  mypy-boto3-ec2-instance-connect =
    buildMypyBoto3Package "ec2-instance-connect" "1.36.0"
      "sha256-q6u1MssNxk38vE2Gy/508A5bhdUrqxH/Mq3DeBFVfqA=";

  mypy-boto3-ecr =
    buildMypyBoto3Package "ecr" "1.36.16"
      "sha256-Fph1HYTByDH/zepZRzRh2l90s/EsFO2fNpEHpUCzuQY=";

  mypy-boto3-ecr-public =
    buildMypyBoto3Package "ecr-public" "1.36.10"
      "sha256-ecc65BMq6HfjT+gI6EdN+5IzYUBawTST8Arbx5+I5OE=";

  mypy-boto3-ecs =
    buildMypyBoto3Package "ecs" "1.36.24"
      "sha256-3DHcUQInBP2JsVeQbnrpn1K65zOT0yQhgNJgZVII9jA=";

  mypy-boto3-efs =
    buildMypyBoto3Package "efs" "1.36.0"
      "sha256-5xK6JX8tM+3EDHC5Ma4G6fGYSf/9Q1V7O2YS+E20HOo=";

  mypy-boto3-eks =
    buildMypyBoto3Package "eks" "1.36.16"
      "sha256-9ZSeS+cRrNWdlZBVIqBU7HQ87+B0Oyel6qWQsZAVyd4=";

  mypy-boto3-elastic-inference =
    buildMypyBoto3Package "elastic-inference" "1.36.0"
      "sha256-duU3LIeW3FNiplVmduZsNXBoDK7vbO6ecrBt1Y7C9rU=";

  mypy-boto3-elasticache =
    buildMypyBoto3Package "elasticache" "1.36.0"
      "sha256-lFQJUk53Hc9ocDGPdOWFe/tD0gu1IfTohQTJwAdFjRE=";

  mypy-boto3-elasticbeanstalk =
    buildMypyBoto3Package "elasticbeanstalk" "1.36.0"
      "sha256-kWYiIJm+i5qrKHzOlNYVJt7uESE0RYOYYLJhRSvpMuo=";

  mypy-boto3-elastictranscoder =
    buildMypyBoto3Package "elastictranscoder" "1.36.0"
      "sha256-uJa3jqLs1PT+JnqoULgS+BhJq2puEQeI+8ai9jfiw44=";

  mypy-boto3-elb =
    buildMypyBoto3Package "elb" "1.36.0"
      "sha256-jfF0FDyLYqOObAjD5NOzDeyVIx0yQ9PpWmGXPR6S8i0=";

  mypy-boto3-elbv2 =
    buildMypyBoto3Package "elbv2" "1.36.0"
      "sha256-B483GDsM1gyxF875fq9+JJcMu/RY+el5NsUB477QN88=";

  mypy-boto3-emr =
    buildMypyBoto3Package "emr" "1.36.0"
      "sha256-j61F+3E2FfQ7hpsnT9M/7maaL/uKNNlRhm8cKH5RoAo=";

  mypy-boto3-emr-containers =
    buildMypyBoto3Package "emr-containers" "1.36.23"
      "sha256-fLHB86UPQH/q6nItMngOxiXZyC34n+giryXQcuypPQw=";

  mypy-boto3-emr-serverless =
    buildMypyBoto3Package "emr-serverless" "1.36.3"
      "sha256-K3BC9tO+z2BUGPs6SaMZKAmU4wkP5aKcJIjiIL5uDx8=";

  mypy-boto3-entityresolution =
    buildMypyBoto3Package "entityresolution" "1.36.0"
      "sha256-8AYX5ZmyC08SXL7Ahuj0do4hngw0Tc8aIKSQOBqLDhU=";

  mypy-boto3-es =
    buildMypyBoto3Package "es" "1.36.0"
      "sha256-6spN2EnD4ZLu0app85PgOVuSu0vFyPOeAootshpBDTM=";

  mypy-boto3-events =
    buildMypyBoto3Package "events" "1.36.0"
      "sha256-9fRXPt5L32Rc1qa0na4OCJbyYZWemAszatW4SRMcO/I=";

  mypy-boto3-evidently =
    buildMypyBoto3Package "evidently" "1.36.0"
      "sha256-ZL6PFxN2uN8qehPqNE+SRVxi5qiPlSph4bJC5pvU5O8=";

  mypy-boto3-finspace =
    buildMypyBoto3Package "finspace" "1.36.0"
      "sha256-sSigyHiVmF4AJ00H0W+G34E1nU1cOZoZcg+qmgsl5sk=";

  mypy-boto3-finspace-data =
    buildMypyBoto3Package "finspace-data" "1.36.0"
      "sha256-Jkf9euVgG4wY8vyMfj1FV973DxZjly1lNZ5MKN/b6WA=";

  mypy-boto3-firehose =
    buildMypyBoto3Package "firehose" "1.36.8"
      "sha256-5NcedA+2dPGC4qTg9HPT0nA3Y4QIGECNVaIy6c09lMw=";

  mypy-boto3-fis =
    buildMypyBoto3Package "fis" "1.36.20"
      "sha256-+h8nsRHHMpAQrXdIIk3I8yZK1nc4A6/zM2jeFtfeO0g=";

  mypy-boto3-fms =
    buildMypyBoto3Package "fms" "1.36.0"
      "sha256-18L9i0t/98USqXxSujbvE6hkxA6FHELJemiTdqLfxLM=";

  mypy-boto3-forecast =
    buildMypyBoto3Package "forecast" "1.36.0"
      "sha256-9sT/Ie3KDssXQs48WdY/ALcJG/ONEg+za275ACXNb/M=";

  mypy-boto3-forecastquery =
    buildMypyBoto3Package "forecastquery" "1.36.0"
      "sha256-TWypDz0ZRrNI4D6VV6lDHrlfWCeTOETspmEx1Pj1wCk=";

  mypy-boto3-frauddetector =
    buildMypyBoto3Package "frauddetector" "1.36.0"
      "sha256-AF/akUwLmAZnHABVlvFS+f3Iqr/Yi0b+3XxGNJRfuug=";

  mypy-boto3-fsx =
    buildMypyBoto3Package "fsx" "1.36.19"
      "sha256-11p4ACLZU/UmhXVk9w9dmRpSUfoF4Sj5aPiJs2nnOyQ=";

  mypy-boto3-gamelift =
    buildMypyBoto3Package "gamelift" "1.36.0"
      "sha256-NoAl0xnWbLdppEUh5F00Ok5In+5ypYSrMA/ihHGNIF4=";

  mypy-boto3-glacier =
    buildMypyBoto3Package "glacier" "1.36.0"
      "sha256-OvHk8XMzUC/UgOAHVgf0lZ+LK0r8oq/m7PWYgLLoj40=";

  mypy-boto3-globalaccelerator =
    buildMypyBoto3Package "globalaccelerator" "1.36.0"
      "sha256-1Xjn3SfQQOXthfqH1dwHkldEIgSmUGEnn8N83H7ALXQ=";

  mypy-boto3-glue =
    buildMypyBoto3Package "glue" "1.36.4"
      "sha256-b4YwzN4ovNNGyg/GDDOjlKo6anyHjdDrIuJVy0ZO1fQ=";

  mypy-boto3-grafana =
    buildMypyBoto3Package "grafana" "1.36.0"
      "sha256-VyDTj6Ja+BY575tibQ/pKvvu64Hziux9cSnWG/kxmGA=";

  mypy-boto3-greengrass =
    buildMypyBoto3Package "greengrass" "1.36.0"
      "sha256-h9aBSA5JsTHuP+pXum2dD6TsLYa6UOs2jC0h4pnsg8E=";

  mypy-boto3-greengrassv2 =
    buildMypyBoto3Package "greengrassv2" "1.36.0"
      "sha256-P0heAD3PH5XA51yC/47SSuEw7k+OPpQY8+dNAHq5lpQ=";

  mypy-boto3-groundstation =
    buildMypyBoto3Package "groundstation" "1.36.0"
      "sha256-UuIfeTSLWceXllm025Cu3AfxXwt6x0cExPmTgdvClvc=";

  mypy-boto3-guardduty =
    buildMypyBoto3Package "guardduty" "1.36.25"
      "sha256-95uSsdcZaz4ySaZBnQ2EVUkYcZjmciC2fqKMEJ94JXg=";

  mypy-boto3-health =
    buildMypyBoto3Package "health" "1.36.0"
      "sha256-EofHk2ODs/ARQ8wYlKtIEkSyreK0oNnY2XaAqXJ+jJw=";

  mypy-boto3-healthlake =
    buildMypyBoto3Package "healthlake" "1.36.6"
      "sha256-5qJo7cHwuGBFz8B9x8C9JZUc5hb+UbmKV2SZHEZ3WzE=";

  mypy-boto3-iam =
    buildMypyBoto3Package "iam" "1.36.13"
      "sha256-HUBVdOaGK45ixr341riGfM3JFw29WcSWXyaZfMpk16I=";

  mypy-boto3-identitystore =
    buildMypyBoto3Package "identitystore" "1.36.0"
      "sha256-AaQ2aEjl7UvdgjPiWa0pf/QEZ9SBQD7BswkwYwvyfGQ=";

  mypy-boto3-imagebuilder =
    buildMypyBoto3Package "imagebuilder" "1.36.0"
      "sha256-lRYLRpJ12+MtoUav4WiyPSrHrvQE0wmaS28JuAsc83g=";

  mypy-boto3-importexport =
    buildMypyBoto3Package "importexport" "1.36.0"
      "sha256-ZF20ZT+H4hlPoXll7Nmfcqn1FY7C5/3WcmzrIre8fvg=";

  mypy-boto3-inspector =
    buildMypyBoto3Package "inspector" "1.36.0"
      "sha256-FH0ZCCvDp2nb0HQ+2JiiurdsHR5Xc2sY9q+w8/U+kDc=";

  mypy-boto3-inspector2 =
    buildMypyBoto3Package "inspector2" "1.36.0"
      "sha256-1ls+K6DVycjWd7LzW6CpKkL5lzcN0J3+iI/xcSjfrKg=";

  mypy-boto3-internetmonitor =
    buildMypyBoto3Package "internetmonitor" "1.36.0"
      "sha256-YBNZe+PnJgXQ2On2x1ppx/a2ua/HMS9XQjg6nYlsLj4=";

  mypy-boto3-iot =
    buildMypyBoto3Package "iot" "1.36.7"
      "sha256-C+UaX7jvRy/g54924iLazVt1Dg67gkW8/wI1+NfU7wY=";

  mypy-boto3-iot-data =
    buildMypyBoto3Package "iot-data" "1.36.0"
      "sha256-uczlAx7Gs17O4p87DrZuPu/2X4xeTiLnX6vH46kF9nY=";

  mypy-boto3-iot-jobs-data =
    buildMypyBoto3Package "iot-jobs-data" "1.36.0"
      "sha256-fq84bOiVqzQ1A5k6a2VHmaECaCkUcv24q5M8ziKeLfQ=";

  mypy-boto3-iot1click-devices =
    buildMypyBoto3Package "iot1click-devices" "1.35.93"
      "sha256-fwfuhSitYIJW5QswYdZ8ZpNL3AEg6MXhJitbbU48STs=";

  mypy-boto3-iot1click-projects =
    buildMypyBoto3Package "iot1click-projects" "1.35.93"
      "sha256-LFuz5/nCZGpSfgqyswxn80VzxXsqzZlBFqPtPJ8bzgo=";

  mypy-boto3-iotanalytics =
    buildMypyBoto3Package "iotanalytics" "1.36.0"
      "sha256-J/cWC9YNHDdP7ApNEE71I0WSNoDUmuS/jIySwA44EOA=";

  mypy-boto3-iotdeviceadvisor =
    buildMypyBoto3Package "iotdeviceadvisor" "1.36.0"
      "sha256-tSSMUqBE5e9gopcvm3PxxePwiiLBkjaYyu6D66GoFyI=";

  mypy-boto3-iotevents =
    buildMypyBoto3Package "iotevents" "1.36.0"
      "sha256-XafQ3MRL9IHWfp3mCqUjFGrwRiUzcOKaumglpwix9vU=";

  mypy-boto3-iotevents-data =
    buildMypyBoto3Package "iotevents-data" "1.36.0"
      "sha256-DNEqCI1aoIrIyVamItdQy3GUmT6i7fIzxtQNQAMr8HI=";

  mypy-boto3-iotfleethub =
    buildMypyBoto3Package "iotfleethub" "1.36.0"
      "sha256-K0Hnp30qFjGjWEB/EFzK8bighPm2kapyTeVN6P6rsdo=";

  mypy-boto3-iotfleetwise =
    buildMypyBoto3Package "iotfleetwise" "1.36.0"
      "sha256-kEh130w7sSC+TiLEfqJyD5w3FOcFdzJ6RIThWedRXGA=";

  mypy-boto3-iotsecuretunneling =
    buildMypyBoto3Package "iotsecuretunneling" "1.36.0"
      "sha256-CZyyJNJDkz/rtwuQib7522Irs123wRAIFop37FfmGRw=";

  mypy-boto3-iotsitewise =
    buildMypyBoto3Package "iotsitewise" "1.36.3"
      "sha256-ng93EV/PD82KyNEbY8EvGwi9R3beG8qjrbKH0bAeT40=";

  mypy-boto3-iotthingsgraph =
    buildMypyBoto3Package "iotthingsgraph" "1.36.0"
      "sha256-smH5AheV5DDKSzjSwTzZAx+hZfTXsjTaitSUfGvxyL0=";

  mypy-boto3-iottwinmaker =
    buildMypyBoto3Package "iottwinmaker" "1.36.0"
      "sha256-Nz7msdzZzU/DVWdgssq543FfUjCYuVvq2UbJPrYdZeg=";

  mypy-boto3-iotwireless =
    buildMypyBoto3Package "iotwireless" "1.36.0"
      "sha256-zJzHwGuUXosX1VfvVT1ajJ/tD7h+L1VtItOBFWaGZwg=";

  mypy-boto3-ivs =
    buildMypyBoto3Package "ivs" "1.36.0"
      "sha256-ldYei0GpjsnhQt3pRq68e4AiRXNmJrO9cGj3WpZ7VWA=";

  mypy-boto3-ivs-realtime =
    buildMypyBoto3Package "ivs-realtime" "1.36.0"
      "sha256-7toQB9Wbeakz+XQO+yC49xiEbjsxalzE9nqfew/V0rY=";

  mypy-boto3-ivschat =
    buildMypyBoto3Package "ivschat" "1.36.0"
      "sha256-h8UNUmTdX/g0mZpgbJxOPWhMH6r4685Rhzxe0TZJmZc=";

  mypy-boto3-kafka =
    buildMypyBoto3Package "kafka" "1.36.0"
      "sha256-mGlREIlUgg9uYhtcf7mqauCMfdmZk+YSNSd7xT2/dzU=";

  mypy-boto3-kafkaconnect =
    buildMypyBoto3Package "kafkaconnect" "1.36.0"
      "sha256-YYRZ/0CoUoj/uDhtBhb9MBspBYPD2VMZ3Ma2TWZNTD8=";

  mypy-boto3-kendra =
    buildMypyBoto3Package "kendra" "1.36.0"
      "sha256-ID1GrzGMUTR7t1pU1ydk55+2CYTPw1NAafSgC7RrsOA=";

  mypy-boto3-kendra-ranking =
    buildMypyBoto3Package "kendra-ranking" "1.36.0"
      "sha256-2g30YUUGHrp4MNXKCOGOWrCCnkCqLZpg3f2DPbDHzhY=";

  mypy-boto3-keyspaces =
    buildMypyBoto3Package "keyspaces" "1.36.0"
      "sha256-NlL6/Q9jx0ZBmF/lSGgiFPndOleCMYGZMn5E2cTMuJ4=";

  mypy-boto3-kinesis =
    buildMypyBoto3Package "kinesis" "1.36.0"
      "sha256-+0aZUOweOPd1cMFFka6PzWtl+8oKSMC6JEWM2eWFu14=";

  mypy-boto3-kinesis-video-archived-media =
    buildMypyBoto3Package "kinesis-video-archived-media" "1.36.0"
      "sha256-9noyiHF4RCoqjSgJrstb0OgUDIGIH7jzgFNiO6Ir+K0=";

  mypy-boto3-kinesis-video-media =
    buildMypyBoto3Package "kinesis-video-media" "1.36.0"
      "sha256-L+//sNC225F1sCm4xNXXdP+FpDRHrwmoJQwlXYf+f5U=";

  mypy-boto3-kinesis-video-signaling =
    buildMypyBoto3Package "kinesis-video-signaling" "1.36.0"
      "sha256-mi7iLkOVY8FQgCbQN4n0jxRVtQjFvbyGfZAdWK5ESNY=";

  mypy-boto3-kinesis-video-webrtc-storage =
    buildMypyBoto3Package "kinesis-video-webrtc-storage" "1.36.0"
      "sha256-pueAIQKI5NhW7pH+dWsCCEDmn7L07dXf9iQZpx3p7DY=";

  mypy-boto3-kinesisanalytics =
    buildMypyBoto3Package "kinesisanalytics" "1.36.0"
      "sha256-zAN+C603mvir4xwT91mnn7zMMZU6mAjRWNRwyR2MAJQ=";

  mypy-boto3-kinesisanalyticsv2 =
    buildMypyBoto3Package "kinesisanalyticsv2" "1.36.0"
      "sha256-wQtBLe2wrD3ugUoMwTHP4i8fpc/der7/oaQ3BvIhWxI=";

  mypy-boto3-kinesisvideo =
    buildMypyBoto3Package "kinesisvideo" "1.36.0"
      "sha256-Oyu3v0c80kLBfyQVjuvF5Np/fzzA1DDSjsXYS9lXLR8=";

  mypy-boto3-kms =
    buildMypyBoto3Package "kms" "1.36.0"
      "sha256-DLRdQOvm24K9UDd55UaXfljRjFLVLmqIyykL5AJDNFQ=";

  mypy-boto3-lakeformation =
    buildMypyBoto3Package "lakeformation" "1.36.0"
      "sha256-lmrEGyuzdZcqxXHYu5Gz87u5kqyJPVrtQ3THa/Wwev4=";

  mypy-boto3-lambda =
    buildMypyBoto3Package "lambda" "1.36.0"
      "sha256-Xp8jcCBgUpqtIWo84qI2g5GhEt8HkJ+9OqgNVz2EiTw=";

  mypy-boto3-lex-models =
    buildMypyBoto3Package "lex-models" "1.36.0"
      "sha256-zjgF1vq4w9ZxLnHtm7eLPsWRA+EysVdaGS0QHcLx8Rs=";

  mypy-boto3-lex-runtime =
    buildMypyBoto3Package "lex-runtime" "1.36.0"
      "sha256-304z/Ky6U2XWC8Qp3Tmzm+l7wykk9c5eIrn/DD8oZiI=";

  mypy-boto3-lexv2-models =
    buildMypyBoto3Package "lexv2-models" "1.36.0"
      "sha256-l7phYjwCiOCxAOaObymIQLNMPNDJ/+R9TCT5AdV6chU=";

  mypy-boto3-lexv2-runtime =
    buildMypyBoto3Package "lexv2-runtime" "1.36.0"
      "sha256-TBggXXwbCAgvLadafBStGR5XLVIEEP/cMamyT4H/dVU=";

  mypy-boto3-license-manager =
    buildMypyBoto3Package "license-manager" "1.36.0"
      "sha256-o5MD7At5cPELQQfA46ged/FLeRrqHhxrQ9rbELaC69M=";

  mypy-boto3-license-manager-linux-subscriptions =
    buildMypyBoto3Package "license-manager-linux-subscriptions" "1.36.0"
      "sha256-o9S7VlcIUK5ESZbKhnzVXipp7e7dNkdi4D6421zKoIE=";

  mypy-boto3-license-manager-user-subscriptions =
    buildMypyBoto3Package "license-manager-user-subscriptions" "1.36.25"
      "sha256-NMUlRMm5RBYhp6pGaXeJyMRj0jf0klIF1SUiA+6jK+8=";

  mypy-boto3-lightsail =
    buildMypyBoto3Package "lightsail" "1.36.24"
      "sha256-6K5Yo5lQ/QAuzNaFCIFKoVkkvGxUOpRi/jfLnq8fyT0=";

  mypy-boto3-location =
    buildMypyBoto3Package "location" "1.36.24"
      "sha256-T50aDATanZgUeBh98Kg2q5/oijnNr3JwEBN3GLPzmfw=";

  mypy-boto3-logs =
    buildMypyBoto3Package "logs" "1.36.3"
      "sha256-dtIzYyo2ZlCUrIiKaF+t4VDBBmWrTK0bFyZQN/yt0Jg=";

  mypy-boto3-lookoutequipment =
    buildMypyBoto3Package "lookoutequipment" "1.36.0"
      "sha256-idS7nS8Bh6v6c6wUpJxaqY+0+JEQd4XoR68vlg4v6UI=";

  mypy-boto3-lookoutmetrics =
    buildMypyBoto3Package "lookoutmetrics" "1.36.0"
      "sha256-KkCskIoCTXPcMqIsEltfNkmtgPKwgBYn8g0n4fe06Zc=";

  mypy-boto3-lookoutvision =
    buildMypyBoto3Package "lookoutvision" "1.36.0"
      "sha256-io3qKqROXYFpOFmwjppVJTIRHFFO6IgUiow1izALKTE=";

  mypy-boto3-m2 =
    buildMypyBoto3Package "m2" "1.36.0"
      "sha256-KDDUPBwEpjRpcLrJJ0PZ0DHu1/4BoL9QREJzIY/LY18=";

  mypy-boto3-machinelearning =
    buildMypyBoto3Package "machinelearning" "1.36.0"
      "sha256-qk6euuMYqJx9Nas49Ve+lFwmI0dOKVg04YZJspzdjqw=";

  mypy-boto3-macie2 =
    buildMypyBoto3Package "macie2" "1.36.0"
      "sha256-pBbyaMCoSCFSaTjHAhBNZzK3N7bXclswkpP4Y/+CfAY=";

  mypy-boto3-managedblockchain =
    buildMypyBoto3Package "managedblockchain" "1.36.0"
      "sha256-uSzu/Vwyfly3T6iaFqdCTZLzM/ivgLArjl6L7f3t7MU=";

  mypy-boto3-managedblockchain-query =
    buildMypyBoto3Package "managedblockchain-query" "1.36.0"
      "sha256-mZsAe1265C9GHoJ9UHQJPFHr08lmWeG/THevZ1Hy5mw=";

  mypy-boto3-marketplace-catalog =
    buildMypyBoto3Package "marketplace-catalog" "1.36.0"
      "sha256-oQP89VgDaIGYe50XvbLjJjOw2n7T1m5u66CIKXIasw8=";

  mypy-boto3-marketplace-entitlement =
    buildMypyBoto3Package "marketplace-entitlement" "1.36.0"
      "sha256-0kOv8xR3PM9ib/I/eHUSjlZPzhvfENawberjC4HaYFU=";

  mypy-boto3-marketplacecommerceanalytics =
    buildMypyBoto3Package "marketplacecommerceanalytics" "1.36.0"
      "sha256-2FL4VPPd8IEirK7o1bFa7pagleqFKQUqx2o+b3bDNm0=";

  mypy-boto3-mediaconnect =
    buildMypyBoto3Package "mediaconnect" "1.36.0"
      "sha256-kNE9LvLz9ltNM6UcMhXeyGWm+uHMAK3E5V/t30QYo+0=";

  mypy-boto3-mediaconvert =
    buildMypyBoto3Package "mediaconvert" "1.36.16"
      "sha256-Zs7r18i4H2k2XnqvRN/d+b5W+0bjfNonNL1EI1rK7aw=";

  mypy-boto3-medialive =
    buildMypyBoto3Package "medialive" "1.36.23"
      "sha256-BoQr6Zei1WNmBGt6/AIp2OHCzX7VicNnn16jfpWWPVU=";

  mypy-boto3-mediapackage =
    buildMypyBoto3Package "mediapackage" "1.36.0"
      "sha256-8JO+oqizY0RwBBDBCGYp/iHWOUkWn0f4xfny85FsjZM=";

  mypy-boto3-mediapackage-vod =
    buildMypyBoto3Package "mediapackage-vod" "1.36.0"
      "sha256-2s23evnXhLsv5FxFAD/4tdZeQCaWIYBX9Dr8Dq7k2tY=";

  mypy-boto3-mediapackagev2 =
    buildMypyBoto3Package "mediapackagev2" "1.36.0"
      "sha256-ZFCPxaZXY1ohxD4ea7STpXmF87qxE827sI/bmytYjnU=";

  mypy-boto3-mediastore =
    buildMypyBoto3Package "mediastore" "1.36.0"
      "sha256-D2yTzZbvYTJvZ6GnHGQIw7O2PsLgV2yn5zBzw8gEeos=";

  mypy-boto3-mediastore-data =
    buildMypyBoto3Package "mediastore-data" "1.36.0"
      "sha256-0RThm2DxaPHRdCtIAvHQvN8y3jU6B5qYQALgl4tWUck=";

  mypy-boto3-mediatailor =
    buildMypyBoto3Package "mediatailor" "1.36.12"
      "sha256-HlB0Mi6U7mr4P3cq6bFDI9IFMR+CIZZB+Tl6MGw0gAo=";

  mypy-boto3-medical-imaging =
    buildMypyBoto3Package "medical-imaging" "1.36.0"
      "sha256-asKHNM6ORMO/GQwbQ58Ob0NMB3n9jyV3kYctae0c0zc=";

  mypy-boto3-memorydb =
    buildMypyBoto3Package "memorydb" "1.36.0"
      "sha256-oN6Fs79zMP6iM3F6HSde/VDVYxBpnUwf/O8H6Yqklk8=";

  mypy-boto3-meteringmarketplace =
    buildMypyBoto3Package "meteringmarketplace" "1.36.0"
      "sha256-WjVdupckuasEt4OU4i+QlyllZ3s6q44ykAd9I6WBCQw=";

  mypy-boto3-mgh =
    buildMypyBoto3Package "mgh" "1.36.0"
      "sha256-x6iCDFDs1Tci3sqnEQ9aYDGAps3YrMl7txII4xNOsmI=";

  mypy-boto3-mgn =
    buildMypyBoto3Package "mgn" "1.36.0"
      "sha256-kEUY/1s6/BNxfh4wlz8tUqiwrprg70Y9rG9RxZ7tR7A=";

  mypy-boto3-migration-hub-refactor-spaces =
    buildMypyBoto3Package "migration-hub-refactor-spaces" "1.36.0"
      "sha256-SliFmnwE0mfJiUcDbtMpC5ZFMTIqadlB1mC3fQ9jyBA=";

  mypy-boto3-migrationhub-config =
    buildMypyBoto3Package "migrationhub-config" "1.36.0"
      "sha256-ZWgzFm5/WE3/K7Mlqbl6SGPQ3juE4fuD5NXlXQU649Q=";

  mypy-boto3-migrationhuborchestrator =
    buildMypyBoto3Package "migrationhuborchestrator" "1.36.0"
      "sha256-AborBP/G7wH6ewa1+j5M7kNiqnlEB6pYyL4FwRqvgKg=";

  mypy-boto3-migrationhubstrategy =
    buildMypyBoto3Package "migrationhubstrategy" "1.36.0"
      "sha256-YoOU9TXuRc0WcgZvmwv85HXgIDfhs/x33cQTORZvcAw=";

  mypy-boto3-mq =
    buildMypyBoto3Package "mq" "1.36.0"
      "sha256-KBl6GBwjMR2rePLqqmVqkBPh5VMLm7Knslm3FtpoZek=";

  mypy-boto3-mturk =
    buildMypyBoto3Package "mturk" "1.36.0"
      "sha256-TpHUvW/JrAm/kiZfYpzDVExpjiGESMVtg51DJR3mQwA=";

  mypy-boto3-mwaa =
    buildMypyBoto3Package "mwaa" "1.36.0"
      "sha256-gvx0Pkg2zapDG71yBGYZCCbl/O2FhmOxyNv7PSsEogM=";

  mypy-boto3-neptune =
    buildMypyBoto3Package "neptune" "1.36.0"
      "sha256-x4V5zM+jK0XD9kKA9ciF7MzMrvWjboDf4mu/byGUkNk=";

  mypy-boto3-neptunedata =
    buildMypyBoto3Package "neptunedata" "1.36.0"
      "sha256-DAMj8WUnQBt0fEnimPvsht3VgQdLYAZIgf2YbzC8yr8=";

  mypy-boto3-network-firewall =
    buildMypyBoto3Package "network-firewall" "1.36.24"
      "sha256-P8/aw3Dm47Z/NL5Q7HDTzB++R46puU4kB/DTWmvdtuY=";

  mypy-boto3-networkmanager =
    buildMypyBoto3Package "networkmanager" "1.36.0"
      "sha256-0xuH1KqfMrVPDrwZ5mWkKs9iFFAXQ6m5qaibfPj7g9A=";

  mypy-boto3-nimble =
    buildMypyBoto3Package "nimble" "1.35.0"
      "sha256-gs9eGyRaZN7Fsl0D5fSqtTiYZ+Exp0s8QW/X8ZR7guA=";

  mypy-boto3-oam =
    buildMypyBoto3Package "oam" "1.36.0"
      "sha256-Cp3N7wNoJXmsYkFKxZ1NKNdA4CjMKWU3GNSQ6vexOz4=";

  mypy-boto3-omics =
    buildMypyBoto3Package "omics" "1.36.0"
      "sha256-ZOAJLTyhyo6QrZcDdmoEiC5Vz1dDPrNmX3+Xr+vHqwc=";

  mypy-boto3-opensearch =
    buildMypyBoto3Package "opensearch" "1.36.0"
      "sha256-oz48RBbQGyDikXQJ4sjOYgVjs6oy2tYPsPuHqpupO5w=";

  mypy-boto3-opensearchserverless =
    buildMypyBoto3Package "opensearchserverless" "1.36.19"
      "sha256-CjPLD9P2FZpyFpH6S1FbXIxY1UEF7pgrjOIpInCA9Rw=";

  mypy-boto3-opsworks =
    buildMypyBoto3Package "opsworks" "1.36.0"
      "sha256-gkeZEJW9tQy7R07xKYcmXl2q0c3ojuMZONlWejQ9m6A=";

  mypy-boto3-opsworkscm =
    buildMypyBoto3Package "opsworkscm" "1.36.0"
      "sha256-eq5BDNSIGhF8IVOFsYrSy+9doDnbA/ewdKGrBwbMJZo=";

  mypy-boto3-organizations =
    buildMypyBoto3Package "organizations" "1.36.0"
      "sha256-cc253S3nQvojCguXun2DxnMJXX6DPU1wJjzctpTNILY=";

  mypy-boto3-osis =
    buildMypyBoto3Package "osis" "1.36.0"
      "sha256-Taq1U8zH2IRvTPxWDaJO2n02lpmSm2JI47JJG+Lh6/c=";

  mypy-boto3-outposts =
    buildMypyBoto3Package "outposts" "1.36.0"
      "sha256-v3tU+ARbeC+8gi0OLgpbAX+0NhCMQgkoedeeod5PZWQ=";

  mypy-boto3-panorama =
    buildMypyBoto3Package "panorama" "1.36.0"
      "sha256-D+8C9ZPCXqgB1p00qZ7JwM3PSzPXHgI/I2OoxM8lkDQ=";

  mypy-boto3-payment-cryptography =
    buildMypyBoto3Package "payment-cryptography" "1.36.0"
      "sha256-nw1Ht6WlwqBJ6H6UpxNAkg5KArUq3mg4Ug/VYD2o6+A=";

  mypy-boto3-payment-cryptography-data =
    buildMypyBoto3Package "payment-cryptography-data" "1.36.0"
      "sha256-y3oLN7Tbgc62rfflmq1FO+N9s1YGfrs9fsswoVsQpx0=";

  mypy-boto3-pca-connector-ad =
    buildMypyBoto3Package "pca-connector-ad" "1.36.0"
      "sha256-4QTYcauRoREIZ55yNsczpHRILyEvQ8P2gcelBQJWKAo=";

  mypy-boto3-personalize =
    buildMypyBoto3Package "personalize" "1.36.0"
      "sha256-cYPjCVdl4VCwjOfyNt01cQN5bbCotw+CIwl8OCQeDDo=";

  mypy-boto3-personalize-events =
    buildMypyBoto3Package "personalize-events" "1.36.0"
      "sha256-4qYuEGWtRvOtn7+61nZFC7zCNHI9eIpcURUQW2eZ/SQ=";

  mypy-boto3-personalize-runtime =
    buildMypyBoto3Package "personalize-runtime" "1.36.0"
      "sha256-4/9lvIlwuiXlkPXYcjKdC+Ewzhglg+cEgswJaYMDBWU=";

  mypy-boto3-pi =
    buildMypyBoto3Package "pi" "1.36.18"
      "sha256-DSuDOZ8R3r4rlhnPsoY4qbulr0aThwONLf7/TqNm+5o=";

  mypy-boto3-pinpoint =
    buildMypyBoto3Package "pinpoint" "1.36.0"
      "sha256-QGTzWnz2xi5PJN5R7qbTlU0i+pclDDU6xInfn7uQPLA=";

  mypy-boto3-pinpoint-email =
    buildMypyBoto3Package "pinpoint-email" "1.36.0"
      "sha256-HB28FeLwe6Bu0OPiFd0gWnvAUzNky/7tplYoz0QRZdc=";

  mypy-boto3-pinpoint-sms-voice =
    buildMypyBoto3Package "pinpoint-sms-voice" "1.36.0"
      "sha256-A3BYcEdeP1KAlgjfxmGFLu8Nlyvg9FK+PpUZZ28yUzo=";

  mypy-boto3-pinpoint-sms-voice-v2 =
    buildMypyBoto3Package "pinpoint-sms-voice-v2" "1.36.0"
      "sha256-engw5h8DCksSr77xHcNgimU05W2TZs6dxQdajhN0q6k=";

  mypy-boto3-pipes =
    buildMypyBoto3Package "pipes" "1.36.0"
      "sha256-CCM2JZp9dcNhbmqU1xwpnN6cahGHy0lo3byX6KhyQ50=";

  mypy-boto3-polly =
    buildMypyBoto3Package "polly" "1.36.19"
      "sha256-lI9liwsOjlcvgiCimRuroWLkTWI/Zy0/VJ6YJNh8tXc=";

  mypy-boto3-pricing =
    buildMypyBoto3Package "pricing" "1.36.0"
      "sha256-mf7j5YWyPMlSUgIpOgJpLf64zecRJZbhmFCCLoZUNjM=";

  mypy-boto3-privatenetworks =
    buildMypyBoto3Package "privatenetworks" "1.36.0"
      "sha256-A5phaD0eEsVPwj5U6VXP5UJreNJwVj5zkddst3FNeCo=";

  mypy-boto3-proton =
    buildMypyBoto3Package "proton" "1.36.0"
      "sha256-y9vY1gQQZAgnaNoKzQWWmpK/eHCGkNoS/BKYY54DrCQ=";

  mypy-boto3-qldb =
    buildMypyBoto3Package "qldb" "1.36.0"
      "sha256-va3xJr4moPSwZVgJjabF4WgUttvLZVYi3Qmtd0lFrhw=";

  mypy-boto3-qldb-session =
    buildMypyBoto3Package "qldb-session" "1.36.0"
      "sha256-IIhC16TF+6AWHq0phnsTfxAdw/DuZ+5piLJROLBcAlw=";

  mypy-boto3-quicksight =
    buildMypyBoto3Package "quicksight" "1.36.3"
      "sha256-q3F2VE4EI7qTCCuYMb6ZUYrU7hYUfbnNjSHw2jqHqk4=";

  mypy-boto3-ram =
    buildMypyBoto3Package "ram" "1.36.0"
      "sha256-nAFuDtCSm3I9m7+w4zSFSna+bcdxv5P4UkK1eZ9E+4U=";

  mypy-boto3-rbin =
    buildMypyBoto3Package "rbin" "1.36.0"
      "sha256-afWYZZR8qCp3f19RodsHltXxAfSwFmTYaoGSHMV5MvI=";

  mypy-boto3-rds =
    buildMypyBoto3Package "rds" "1.36.25"
      "sha256-KzGuqgu8Otp1om5TgGKrNLrrmwWtcVAesZMalEpa5QM=";

  mypy-boto3-rds-data =
    buildMypyBoto3Package "rds-data" "1.36.21"
      "sha256-c3IaYAK+BnQWnI4PL5HlM0liGaxrNHmFLuIGmaz2N0s=";

  mypy-boto3-redshift =
    buildMypyBoto3Package "redshift" "1.36.0"
      "sha256-kQNSEOnoWGmMwZdxlwNa4WmhHmJKDVudgyVb6bEk9S0=";

  mypy-boto3-redshift-data =
    buildMypyBoto3Package "redshift-data" "1.36.0"
      "sha256-XrRuyeDv3qQU/hmunqsnZKOj6KY1OgvjEnAWBxucWC0=";

  mypy-boto3-redshift-serverless =
    buildMypyBoto3Package "redshift-serverless" "1.36.0"
      "sha256-fZPFD9lJ3ZbGLprcPapewcts8qsxUJD1hzsjEh4T9s0=";

  mypy-boto3-rekognition =
    buildMypyBoto3Package "rekognition" "1.36.0"
      "sha256-Z9C9MFtokgiaYd9GvtT2mkdkVCEoL37bclPNNZ/jtRo=";

  mypy-boto3-resiliencehub =
    buildMypyBoto3Package "resiliencehub" "1.36.0"
      "sha256-1508j+58jEg5fQP1ZuitJzv18Xr/K+IJtJz52IOdTQc=";

  mypy-boto3-resource-explorer-2 =
    buildMypyBoto3Package "resource-explorer-2" "1.36.0"
      "sha256-yYAVQ8AXwxK9dpPy/78RDA57EmL/kNDATsIGnAuoAD0=";

  mypy-boto3-resource-groups =
    buildMypyBoto3Package "resource-groups" "1.36.0"
      "sha256-ZJvnfqIiAG4nh1Xc73A3JNP0SS0vizx1M5Qv/xTdyg4=";

  mypy-boto3-resourcegroupstaggingapi =
    buildMypyBoto3Package "resourcegroupstaggingapi" "1.36.0"
      "sha256-fazaiE4Ug2V669z3os10SeF9nyKytBU3UfzhhuoaHaY=";

  mypy-boto3-robomaker =
    buildMypyBoto3Package "robomaker" "1.36.0"
      "sha256-P9In8vYi3s+EbiFGwYCv8yDUclesTQe0fIBV37STzN8=";

  mypy-boto3-rolesanywhere =
    buildMypyBoto3Package "rolesanywhere" "1.36.0"
      "sha256-ZiD92KL4LGfIH/L34r1mRE05E91Say4ljm7PA4j3Aew=";

  mypy-boto3-route53 =
    buildMypyBoto3Package "route53" "1.36.0"
      "sha256-vJO4RA/UANKfhXjlvHYaplsuZ1MDxhYPT1Wnc2kAM2s=";

  mypy-boto3-route53-recovery-cluster =
    buildMypyBoto3Package "route53-recovery-cluster" "1.36.0"
      "sha256-mOmUQpYgkRUqAOTBWnr8WoJuKnUdZO9rRAkOf0M7cck=";

  mypy-boto3-route53-recovery-control-config =
    buildMypyBoto3Package "route53-recovery-control-config" "1.36.0"
      "sha256-aJYGZRenjJ5HTpblArMAhIXcmPKuFnCatq+oxf+wpV4=";

  mypy-boto3-route53-recovery-readiness =
    buildMypyBoto3Package "route53-recovery-readiness" "1.36.0"
      "sha256-gz1f418XrU5TDLV1CgRdVSnNNJqi85KXOtywZT51PBs=";

  mypy-boto3-route53domains =
    buildMypyBoto3Package "route53domains" "1.36.0"
      "sha256-CfBTucYs6eRUDfWxB/J93deoaLJZy8MZPL+pCMZIsEY=";

  mypy-boto3-route53resolver =
    buildMypyBoto3Package "route53resolver" "1.36.0"
      "sha256-KKOHvf0EPB9F2X/mB0qyU0r3gO9B01Q+XbgBRDCzbIE=";

  mypy-boto3-rum =
    buildMypyBoto3Package "rum" "1.36.0"
      "sha256-DLbt+8tSmmMHfjifzFJGKezEmbiTxiA5KfCfcL+I/V8=";

  mypy-boto3-s3 =
    buildMypyBoto3Package "s3" "1.36.21"
      "sha256-nGFDwNq/vZjmx0HnzGWjPH+HuMKO6zc6K8PiySOvgoM=";

  mypy-boto3-s3control =
    buildMypyBoto3Package "s3control" "1.36.7"
      "sha256-mGZawDNAK8+MpJihk1AVKiXRQ3GhLQvvYZbn6hGskVE=";

  mypy-boto3-s3outposts =
    buildMypyBoto3Package "s3outposts" "1.36.0"
      "sha256-oLFs4pHfXJbG5cenQi83ur7ZaMfPLYzqp4AvvAadg+k=";

  mypy-boto3-sagemaker =
    buildMypyBoto3Package "sagemaker" "1.36.25"
      "sha256-6o9mkUBxo3gT+PTc9HBx5rsjpv/A0P7K83FdYIXlpso=";

  mypy-boto3-sagemaker-a2i-runtime =
    buildMypyBoto3Package "sagemaker-a2i-runtime" "1.36.0"
      "sha256-IPFFvyHcpmdDIPNbUSVRzzGnBcL7NhstwTRaE/rJqq0=";

  mypy-boto3-sagemaker-edge =
    buildMypyBoto3Package "sagemaker-edge" "1.36.0"
      "sha256-ck/nxwOGvfn/7cwwW71Rg+EXU7hjB4E0kM5diBo8ZKE=";

  mypy-boto3-sagemaker-featurestore-runtime =
    buildMypyBoto3Package "sagemaker-featurestore-runtime" "1.36.0"
      "sha256-uZNeHQY0YG6m6ag6SgXf5jxJ95JUpWJWXJrSiyXNb+o=";

  mypy-boto3-sagemaker-geospatial =
    buildMypyBoto3Package "sagemaker-geospatial" "1.36.0"
      "sha256-4ISRJZSVLmyzzwNbpLimMyl40b44Za9gZVt/oFqrcUU=";

  mypy-boto3-sagemaker-metrics =
    buildMypyBoto3Package "sagemaker-metrics" "1.36.0"
      "sha256-6GeBv76AS5bMfd6tqc1lx2mvH8iKs6rHe5MZGOOCYGc=";

  mypy-boto3-sagemaker-runtime =
    buildMypyBoto3Package "sagemaker-runtime" "1.36.0"
      "sha256-VVJElbjLKkWAlrsZUr0TZpe7lwiEdkqRh3SsMm3Iy9k=";

  mypy-boto3-savingsplans =
    buildMypyBoto3Package "savingsplans" "1.36.0"
      "sha256-O6+ygT/lRLLE9JpXMpNufFtPIQzvg5c12T0Vz0mXQQU=";

  mypy-boto3-scheduler =
    buildMypyBoto3Package "scheduler" "1.36.0"
      "sha256-7i960YDd65LyHLGksqfo/b2Qyfnsa+Tyv0xICIQJlEo=";

  mypy-boto3-schemas =
    buildMypyBoto3Package "schemas" "1.36.0"
      "sha256-OFBu3vHrNfad5gNIl1BF8xygY956xCOmqd+7wYOUVfM=";

  mypy-boto3-sdb =
    buildMypyBoto3Package "sdb" "1.36.0"
      "sha256-T1aCzVPgwpi8xLUJREre+tCLHdFN4/wx+s/bZoWIwkY=";

  mypy-boto3-secretsmanager =
    buildMypyBoto3Package "secretsmanager" "1.36.0"
      "sha256-bh+RzVsMHwUz+M+pHkdVhV05kxR159HiPujbsucWPRg=";

  mypy-boto3-securityhub =
    buildMypyBoto3Package "securityhub" "1.36.0"
      "sha256-Ct5MyqeN5xXI/R0UbOisqVno9p12bY00p36ZkDaOgfQ=";

  mypy-boto3-securitylake =
    buildMypyBoto3Package "securitylake" "1.36.0"
      "sha256-LNpu2+bCPpcmn8frAyI+QaUXDauc8DuBkbNn1cuFu6o=";

  mypy-boto3-serverlessrepo =
    buildMypyBoto3Package "serverlessrepo" "1.36.0"
      "sha256-sWmqOjkVcU/2kdU8MytG0fV75NCa9+k9ustlJ0AyRE4=";

  mypy-boto3-service-quotas =
    buildMypyBoto3Package "service-quotas" "1.36.0"
      "sha256-6XUCz3uMFtC4gCXVhC+Oismf9I7wkZvO/NOFZH8Ymqs=";

  mypy-boto3-servicecatalog =
    buildMypyBoto3Package "servicecatalog" "1.36.0"
      "sha256-bSY5MAXJ04JJEMAwJMCvXclUyqvEyBYlte3D8/T5BdM=";

  mypy-boto3-servicecatalog-appregistry =
    buildMypyBoto3Package "servicecatalog-appregistry" "1.36.0"
      "sha256-u7GYGYWFF3nqrq1UPvFCxBWhbijzGDHiBlYBYz5kjS8=";

  mypy-boto3-servicediscovery =
    buildMypyBoto3Package "servicediscovery" "1.36.0"
      "sha256-edpmbbgwyFcZFMag8WLm8K2ARaFc+h0MYCuI0FSOvS0=";

  mypy-boto3-ses =
    buildMypyBoto3Package "ses" "1.36.0"
      "sha256-RIQRIwT1s97XFR33uwwuHNa7s+Un3ASqOmOrC8fai7w=";

  mypy-boto3-sesv2 =
    buildMypyBoto3Package "sesv2" "1.36.24"
      "sha256-+0bMPwkBIVkh4F5+tbslOwFi9UvKtjhA/zbpjhOFZ04=";

  mypy-boto3-shield =
    buildMypyBoto3Package "shield" "1.36.0"
      "sha256-30CqqZWYiZdj8Mhsri/MQRWQckLhiybLC8DPlDznBWQ=";

  mypy-boto3-signer =
    buildMypyBoto3Package "signer" "1.36.0"
      "sha256-NWmgQ7uzY9GCDc8TW0Wt4tAMaIgpryEo+52dBAcx3io=";

  mypy-boto3-simspaceweaver =
    buildMypyBoto3Package "simspaceweaver" "1.36.0"
      "sha256-FcrE51N0aYbvv7JclXPen7L3+uv2h5Yhgh9/M4UwmX8=";

  mypy-boto3-sms =
    buildMypyBoto3Package "sms" "1.36.0"
      "sha256-ctcjvfFru5Q5JOVy6rFHSXkNDCh7vj2ojBRhBV/H8PQ=";

  mypy-boto3-sms-voice =
    buildMypyBoto3Package "sms-voice" "1.36.0"
      "sha256-ZlytTF14VELeSYBTGuBWwlyxw9hz0J4GEA80+kF37wY=";

  mypy-boto3-snow-device-management =
    buildMypyBoto3Package "snow-device-management" "1.36.0"
      "sha256-6A2Ndgosuh9NFSA9m99D8xIRzi46PXug7PNJy7FwHq0=";

  mypy-boto3-snowball =
    buildMypyBoto3Package "snowball" "1.36.0"
      "sha256-7bTjFV56sVY9Vcl8pnU+Eajx6hkK50u9eq0ot4suLT4=";

  mypy-boto3-sns =
    buildMypyBoto3Package "sns" "1.36.3"
      "sha256-1SH0X0eIpMEdFxXf5sKvhX65T3ZksZdTo8ZW+xG6+m8=";

  mypy-boto3-sqs =
    buildMypyBoto3Package "sqs" "1.36.0"
      "sha256-p/kB20Mw0WpJyhE8MVQRkQbj2zT7J/6+vuEpl4aBUUM=";

  mypy-boto3-ssm =
    buildMypyBoto3Package "ssm" "1.36.6"
      "sha256-7cgZt1Jqs1sQVkhgODnRWLABRq9XQ/x3hNsyJwc+GXM=";

  mypy-boto3-ssm-contacts =
    buildMypyBoto3Package "ssm-contacts" "1.36.0"
      "sha256-0/flVKiNnjaHkYQOIEVu8G8AzWarB391uVeDaadKT4I=";

  mypy-boto3-ssm-incidents =
    buildMypyBoto3Package "ssm-incidents" "1.36.0"
      "sha256-0nuHTFbRsqS5GDz4C/KFdH862PBDOH8riY3Er+JSsxw=";

  mypy-boto3-ssm-sap =
    buildMypyBoto3Package "ssm-sap" "1.36.0"
      "sha256-xWqUERBxKnifM7YMEQ5khsaw+E9W0QUdDGMOvTcTxFY=";

  mypy-boto3-sso =
    buildMypyBoto3Package "sso" "1.36.0"
      "sha256-+OEtYj5bnfafzuXqa4nRBUXZAPg/9F7+J/qGcP36zFs=";

  mypy-boto3-sso-admin =
    buildMypyBoto3Package "sso-admin" "1.36.0"
      "sha256-SdY+ZIHzE7P2riMhr9MbiPISKx8eK0uXH8R8eSFY7Yo=";

  mypy-boto3-sso-oidc =
    buildMypyBoto3Package "sso-oidc" "1.36.6"
      "sha256-beQp4GmS7la2xDmHNnhuyAFeoZ4UIJ7xTS/qEedAfnQ=";

  mypy-boto3-stepfunctions =
    buildMypyBoto3Package "stepfunctions" "1.36.0"
      "sha256-+y+FrXGQLqqw2Cl4nWFu2VdP8OvXquK7jo5Quud+70U=";

  mypy-boto3-storagegateway =
    buildMypyBoto3Package "storagegateway" "1.36.20"
      "sha256-tIafSx4DSMsVIep/uaEs3/cOVuIwNX3Tytuk6GVXobc=";

  mypy-boto3-sts =
    buildMypyBoto3Package "sts" "1.36.0"
      "sha256-UiA1G5H4n/z5P1eZ3IDidk1QGZlc70BBpuK0U+tL1rM=";

  mypy-boto3-support =
    buildMypyBoto3Package "support" "1.36.0"
      "sha256-FUE+oSeW6pZPsssvMUXNasYq5PiWbdG7iTBpFw+IE3c=";

  mypy-boto3-support-app =
    buildMypyBoto3Package "support-app" "1.36.0"
      "sha256-1sr4RkK9bTllRULsKDiPLlvXDTfiU9JQeYYSA7iiQjQ=";

  mypy-boto3-swf =
    buildMypyBoto3Package "swf" "1.36.0"
      "sha256-+D9j1AvOxl2PNWXaKufjl3wtV3jjvu5qc9wp5hyYdmo=";

  mypy-boto3-synthetics =
    buildMypyBoto3Package "synthetics" "1.36.0"
      "sha256-GSSDvsdGqwNKnVxfdVJap3gGovEHvakSFYQLwV7ITww=";

  mypy-boto3-textract =
    buildMypyBoto3Package "textract" "1.36.0"
      "sha256-FW/moXZl11tEMK6bMU2c11Mwo8xMfgP3LemSM8G1VMU=";

  mypy-boto3-timestream-query =
    buildMypyBoto3Package "timestream-query" "1.36.0"
      "sha256-IOBqTSc+FwXoWYCfofH5nYhshFnLACBMn05Vjh34KpA=";

  mypy-boto3-timestream-write =
    buildMypyBoto3Package "timestream-write" "1.36.0"
      "sha256-e9OUxHV8zKmsvT7uBTcrkvSF1EKi34PCAnMZGEDwMwk=";

  mypy-boto3-tnb =
    buildMypyBoto3Package "tnb" "1.36.0"
      "sha256-4esWqRpxC9Q1AfpNY5mwZ+upTjZTQ+HqdRVwoU7Lhas=";

  mypy-boto3-transcribe =
    buildMypyBoto3Package "transcribe" "1.36.16"
      "sha256-qPrG06bvFqloggeixei6kBq1jcq/MjXN2N+95oMDqs8=";

  mypy-boto3-transfer =
    buildMypyBoto3Package "transfer" "1.36.6"
      "sha256-i+bqPZy3UkWbXBA6nW0HxaXq+v6Nky0yS1khYfF/H4o=";

  mypy-boto3-translate =
    buildMypyBoto3Package "translate" "1.36.0"
      "sha256-eciWk3er9XomkPcP8vNGta2L2+vRwL4ytUVjmR1gDBQ=";

  mypy-boto3-verifiedpermissions =
    buildMypyBoto3Package "verifiedpermissions" "1.36.10"
      "sha256-ddf14Wu/CBtG3BtoDDxaP2ALv2aRntAdwXtZvVrHAp4=";

  mypy-boto3-voice-id =
    buildMypyBoto3Package "voice-id" "1.36.0"
      "sha256-DaJeOcWIg5Q4MZB3FhzPXhbnyq46/n7K/kB3qn0mYAo=";

  mypy-boto3-vpc-lattice =
    buildMypyBoto3Package "vpc-lattice" "1.36.0"
      "sha256-0zF/E6r7uzdWVTu08i5fIKBxlJW5EB3lqypFcNHUaOo=";

  mypy-boto3-waf =
    buildMypyBoto3Package "waf" "1.36.0"
      "sha256-3Y3/m25jH83b45h/5/ArmUzpGWL1O7j2Yrf3JB+oKHA=";

  mypy-boto3-waf-regional =
    buildMypyBoto3Package "waf-regional" "1.36.0"
      "sha256-l0OLeiaJfVKT7SxGOGGcy2Q629Ay0ZedYau/tlOF0mQ=";

  mypy-boto3-wafv2 =
    buildMypyBoto3Package "wafv2" "1.36.21"
      "sha256-d24DBuJMPocqC7lJoQZAZg9RjIWnocDRHb/ygK3nWf0=";

  mypy-boto3-wellarchitected =
    buildMypyBoto3Package "wellarchitected" "1.36.0"
      "sha256-ntUry6ANYTFhl2MBw6JbQLCmq45rXkILYfhTxBTZxvU=";

  mypy-boto3-wisdom =
    buildMypyBoto3Package "wisdom" "1.36.0"
      "sha256-5lMYZjiUIxoSX1RhixACXY8ch4AGXQsC5/WrPpHZzuQ=";

  mypy-boto3-workdocs =
    buildMypyBoto3Package "workdocs" "1.36.0"
      "sha256-E7UI4bjrruLEt4GDm7xgd+RIBglBqdOYmy1OZheMQQI=";

  mypy-boto3-worklink =
    buildMypyBoto3Package "worklink" "1.35.0"
      "sha256-AgK4Xg1dloJmA+h4+mcBQQVTvYKjLCk5tPDbl/ItCVQ=";

  mypy-boto3-workmail =
    buildMypyBoto3Package "workmail" "1.36.0"
      "sha256-uN6NXBbyJZoZSrtP1OhZ9mhWl3NnjOJ4Dd7ZHg3g9Xs=";

  mypy-boto3-workmailmessageflow =
    buildMypyBoto3Package "workmailmessageflow" "1.36.0"
      "sha256-IbNtF9S3xSSB+FmEgSq3RQjOyztX2Gmf4gX93EpDrPE=";

  mypy-boto3-workspaces =
    buildMypyBoto3Package "workspaces" "1.36.0"
      "sha256-L0UaK8VamOkBtuNaiOYp47CMhofy36ubVqvSdi7SaXU=";

  mypy-boto3-workspaces-web =
    buildMypyBoto3Package "workspaces-web" "1.36.25"
      "sha256-wEaRMxUYtoqb7gXaui6to4TUl2eYJw3FiPrPWIvI2fE=";

  mypy-boto3-xray =
    buildMypyBoto3Package "xray" "1.36.0"
      "sha256-WuK0wzO/KIGHD/uW8dmc1efuFwbQcbaSPc1t5s6zrAw=";
}
