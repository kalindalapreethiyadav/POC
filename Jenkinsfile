pipeline
{  
   agent { label "deploy" }
      stages{
         stage('build Image'){
            steps {
              cd /POC/POc's-CD/;
              ls -lrt
                  }    
            }
         stage('Run Image'){
            steps {
              sh ''' 
               echo "run imge"
               '''
              }
           }
         }
      }