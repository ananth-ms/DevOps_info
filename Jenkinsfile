pipeline{
  any agent
    stage{
      stage("cleaning stage"){
        step{
          bat "MVM clean"
        }
      }
      stage("testing stage"){
        step{
          bat "MVN test"
        }
      }
      stage("packing stage"){
        step{
          bat "MVN package"
        }
      }
      
   }
 }
