env.SCM_URL = "https://github.com/myownsoul/hometest.git"
env.IMG_REG = "registry.devops.local:5000"
env.WEB_IMAGE = "${env.IMG_REG}/myweb-web"
env.APP_IMAGE = "${env.IMG_REG}/myweb-app"
env.TST_IMG_TAG = "tst-${env.BUILD_NUMBER}"
env.PRD_IMG_TAG = "prd-${env.BUILD_NUMBER}"
env.TST_SERVER = "tcp://139.198.188.39:2375"
env.PRD_SERVER = "tcp://139.198.188.221:2375"


node {
       stage 'CHECKOUT'
             git url: "${env.SCM_URL}"
       stage 'BUILD'
              sh "mvn install -f myweb/pom.xml"
              sh "zip -r myweb/target/web.zip myweb/web"
       stage 'PACKAGE'
              sh "docker build -f myweb/Dockerfile.App -t ${env.APP_IMAGE}:${env.TST_IMG_TAG} ."
              sh "docker build -f myweb/Dockerfile.Web -t ${env.WEB_IMAGE}:${env.TST_IMG_TAG} ."
       stage 'PUBLISH'
              sh "docker push ${env.APP_IMAGE}:${env.TST_IMG_TAG}"
              sh "docker push ${env.WEB_IMAGE}:${env.TST_IMG_TAG}"
       stage 'DEPLOY-TST'
              env.APP_IMG="${env.APP_IMAGE}:${env.TST_IMG_TAG}"
              env.WEB_IMG="${env.WEB_IMAGE}:${env.TST_IMG_TAG}"
              sh "export DOCKER_HOST=${env.TST_SERVER}"
              sh "scripts/startApp.sh"
       stage 'RELEASE'
              sh "export DOCKER_HOST=${env.TST_SERVER}"
              sh "docker tag ${env.APP_IMAGE}:${env.TST_IMG_TAG} ${env.APP_IMAGE}:${env.PRD_IMG_TAG}"
              sh "docker tag ${env.WEB_IMAGE}:${env.TST_IMG_TAG} ${env.WEB_IMAGE}:${env.PRD_IMG_TAG}"
              sh "docker push ${env.APP_IMAGE}:${env.PRD_IMG_TAG}"
              sh "docker push ${env.WEB_IMAGE}:${env.PRD_IMG_TAG}"
       stage 'DEPLOY-PRD'
              env.APP_IMG="${env.APP_IMAGE}:${env.PRD_IMG_TAG}"
              env.WEB_IMG="${env.WEB_IMAGE}:${env.PRD_IMG_TAG}"
              sh "export DOCKER_HOST=${env.PRD_SERVER}"
              sh "scripts/startApp.sh"
       }
