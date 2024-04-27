pipeline{
  agent any
    stages{
      stage ("cleaning stage"){
        steps{
          bat "MVN clean"
        }
      }
      stage ("testing stage"){
        steps{
          bat "MVN test"
        }
      }
      stage ("packing stage"){
        steps{
          bat "MVN package"
        }
      }
}
}
