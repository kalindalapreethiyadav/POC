pipeline
{
   agent { label 'docker || deploy' }
      stages{
         stage("Change Directory"){
            steps {
                   sh """
                   cd /home/centos/POC/POcs-CD/
                   ls -lrt;
                   """
                  }    
            }
            stage("login docker"){
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

