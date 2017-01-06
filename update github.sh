

{"name":"JobName",
 "url":"JobUrl",
 "build":{"number":1,
    "phase":"STARTED",
    "status":"FAILED",
          "url":"job/project/5",
          "full_url":"http://ci.jenkins.org/job/project/5"
          "parameters":{"branch":"master"}
   }
}

curl -u "ianvaughan:ce1ec1e09a4dc8c2145177f0d8a8bfef5291ae39" https://api.github.com/repos/econsultancy/death_star

curl \
  https://api.github.com/repos/econsultancy/death_star \
  -u "ianvaughan:ce1ec1e09a4dc8c2145177f0d8a8bfef5291ae39" \


 -H "Authorization: OAuth 2c4419d1aabeec" \
 -H "Accept: application/json" \

 -X PUT \
     -H 'Content-Type: application/json' \
     -d '{"firstName":"Kris", "lastName":"Jordan"}'
     echo.httpkit.com



curl --data "param1=value1&param2=value2" http://example.com/resource.cgi
curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"user":{"first_name":"firstname","last_name":"lastname","email":"email@email.com","password":"app123","password_confirmation":"app123"}}'  http://localhost:3000/api/1/users
curl -X POST -H "Content-Type: application/json" -d '{"username":"xyz","password":"xyz"}' http://localhost:3000/api/login
curl -X POST -H "Content-Type:application/json" -H "Accept:application/json" http://localhost:3000/nodes -d "{"node":{"name":"foo","ip_address":"10.0.1.120"}}"
curl -X POST -H "Content-Type:application/json" -H "Accept:application/json" http://localhost:3000/nodes/4d6f418d1769d024c300000f/metrics -d "{"metric":{"name":"foo","data":{"one":1,"two":2}}}"


others plugins

https://wiki.jenkins-ci.org/display/JENKINS/Build+Monitor+Plugin
https://wiki.jenkins-ci.org/display/JENKINS/Radiator+View+Plugin


https://github.com/litl/leeroy


Jenkins CLI

https://wiki.jenkins-ci.org/display/JENKINS/Jenkins+CLI
http://starkandwayne.com/articles/2013/04/12/jenkins-builds-from-cli/
http://kamino.local:8080/cli

