env.SCM_URL = "git@github.com:myownsoul/hometest.git"
env.IMG_REG = "registry.devops.local:5000"
env.WEB_IMAGE = "${IMG_REG}/myweb-web"
env.APP_IMAGE = "${IMG_REG}/myweb-app"
env.TST_IMG_TAG = "tst-${GIT_COMMIT}-${BUILD_NUMBER}"
env.PRD_IMG_TAG = "prd-${GIT_COMMIT}-${BUILD_NUMBER}"
env.TST_SERVER = "139.198.188.39"
env.PRD_SERVER = "139.198.188.221"


node {
       stage 'CHECKOUT'
             git url: "${SCM_URL}"
       stage 'BUILD'
              sh "mvn install if myweb/pom.xml"
              sh "zip -r myweb/target/web.zip myweb/web"
       stage 'PACKAGE'
              sh "docker build -f myweb/Dockerfile.App -t ${APP_IMAGE}:${TST_IMG_TAG}"
              sh "docker build -f myweb/Dockerfile.Web -t ${WEB_IMAGE}:${TST_IMG_TAG}"
       stage 'PUBLISH'
              sh "docker push ${APP_IMAGE}:${TST_IMG_TAG}"
              sh "docker push ${WEB_IMAGE}:${TST_IMG_TAG}"
       stage 'DEPLOY-TST'
              env.APP_IMG=${APP_IMAGE}:${TST_IMG_TAG}"
              env.WEB_IMG=${WEB_IMAGE}:${TST_IMG_TAG}"
              sh " export DOCKER_HOST="tcp://${TST_SERVER}:2375""
              sh "scripts/startApp.sh"
       stage 'RELEASE'
              sh "export DOCKER_HOST="tcp://${TST_SERVER}:2375""
              sh "docker tag ${APP_IMAGE}:${TST_IMG_TAG} ${APP_IMAGE}:${PRD_IMG_TAG}"
              sh "docker tag ${WEB_IMAGE}:${TST_IMG_TAG} ${WEB_IMAGE}:${PRD_IMG_TAG}"
              sh "docker push ${APP_IMAGE}:${PRD_IMG_TAG}"
              sh "docker push ${WEB_IMAGE}:${PRD_IMG_TAG}"
       stage 'DEPLOY-PRD'
              env.APP_IMG=${APP_IMAGE}:${PRD_IMG_TAG}
              env.WEB_IMG=${WEB_IMAGE}:${PRD_IMG_TAG}
              sh "export DOCKER_HOST="tcp://${PRD_SERVER}:2375""
              sh "scripts/startApp.sh"
       }
