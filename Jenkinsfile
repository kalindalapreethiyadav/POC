pipeline
{
   agent { label "deploy" }
      stages{
         stage("build Image"){
            steps {
                   sh """
                   cd /home/centos/POC/POcs-CD/
                   echo "hello"
                   """
                  }    
            }
         stage('Run Image'){
            steps {
                  echo "hello1"
              }
           }
         }
      }