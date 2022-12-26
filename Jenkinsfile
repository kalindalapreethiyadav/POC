pipeline
{
    agent label{'deploy'}
    stages{
        stage('build Image'){
           steps {
            sh ''' 
            cd /POC/POc's-CD
            sh ls -lrt
            '''
           }
           
         }
         stage('Run Image'){
            steps {
            sh ''' 
            echo "run imge"
            }
         }
    }
}