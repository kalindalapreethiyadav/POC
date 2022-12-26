pipeline
{
   agent { label 'docker || deploy' }
      stages{
         stage("build Image"){
            steps {
                   sh """
                   cd /home/centos/POC/POcs-CD/
                   ls -lrt;
   
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