pipeline
{
   #agent { label 'docker || deploy' }
   agent any
      stages{
         stage("Change Directory"){
            steps {
                   sh """
                   cd /home/centos/POC/
                   ls -lrt;
                   """
                  }    
            }
         stage('source Code clean'){
            steps {
                  echo "cleaning the source code"
                  mvn clean
              }
         }
         stage('Source Code install'){
            steps {
                  echo "cleaning the source code"
                  mvn install
              }
           }
           stage('Source Code install'){
            steps {
                  echo "cleaning the source code"
                  mvn test
              }
           }
            stage('packaging'){
            steps {
                  echo "cleaning the source code"
                  sh 'zip /home/centos/POC/Robot_HelloWorld.0.0.1.Release.zip'
                  sh 'tar cxf /home/centos/POC/Robot_HelloWorld.0.0.1.Release.zip'
              }
           }
         }
      }
}

