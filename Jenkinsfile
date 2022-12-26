pipeline
{
   agent { label "deploy" }
      stages{
         stage("build Image"){
            steps {
                   sh """
                   cd /home/centos/POC/POcs-CD/
                   ls -lrt;
                   echo "hello";
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