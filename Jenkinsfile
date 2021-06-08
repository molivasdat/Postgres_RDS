#!/usr/bin/env groovy
// Liquibase declarative pipeline
//
//
pipeline {
agent any
  environment {
    PROJ="Postgres_RDS"
    GITURL="https://github.com/szandany"
    ENVIRONMENT_STEP="${params.step}"
    BRANCH="${params.pipeline}"
    PATH="/root/liquibase:$PATH"
  }
  stages {

    stage ('Precheck') {
		steps {
			sh '''
        { set +x; } 2>/dev/null
        echo "Current project: "$PROJ
        echo "Current scm branch: "$BRANCH
        echo "Current environment: "$ENVIRONMENT_STEP
			'''
		} // steps
	} // stage 'precheck'

    stage ('Checkout') {
      steps {
        // checkout Liquibase project from repo
        sh '''
          { set +x; } 2>/dev/null
          cd /root/workspace
          if [ -d "$PROJ" ]; then rm -Rf $PROJ; fi
          git clone ${GITURL}/${PROJ}.git
          cd ${PROJ}
          git checkout $BRANCH
          git status
          '''
      } // steps for checkout stages
    } // stage 'checkout'

   stage ('liquibase commands'){
      steps {
        sh '''
          { set +x; } 2>/dev/null
          cd /root/workspace/${PROJ}/${ENVIRONMENT_STEP}
          liquibase --version
          echo "------------------------------------"
          echo "----------liquibase status----------"
          echo "------------------------------------"
          liquibase --url=${Postgres_RDS_URL} --username=${Postgres_RDS_USERNAME} --password=${Postgres_RDS_PASSWORD} --contexts=$ENVIRONMENT_STEP status --verbose
          echo "---------------------------------------------"
          echo "----------liquibase rollbackCount=5----------"
          echo "---------------------------------------------"
          liquibase --url=${Postgres_RDS_URL} --username=${Postgres_RDS_USERNAME} --password=${Postgres_RDS_PASSWORD} --contexts=$ENVIRONMENT_STEP rollbackCount 5
          echo "---------------------------------------"
          echo "----------liquibase updateSQL----------"
          echo "---------------------------------------"
          liquibase --url=${Postgres_RDS_URL} --username=${Postgres_RDS_USERNAME} --password=${Postgres_RDS_PASSWORD} --contexts=$ENVIRONMENT_STEP updateSQL
          echo "---------------------------------------------"
          echo "----------liquibase tag database with version1----------"
          echo "---------------------------------------------"
          liquibase --url=${Postgres_RDS_URL} --username=${Postgres_RDS_USERNAME} --password=${Postgres_RDS_PASSWORD} --contexts=$ENVIRONMENT_STEP tag version1
          echo "------------------------------------"
          echo "----------liquibase update----------"
          echo "------------------------------------"
          liquibase --url=${Postgres_RDS_URL} --username=${Postgres_RDS_USERNAME} --password=${Postgres_RDS_PASSWORD} --contexts=$ENVIRONMENT_STEP update
          # echo "------------------------------------------------------------"
          # echo "----------liquibase diff with upper QA environment----------"
          # echo "------------------------------------------------------------"
          # liquibase --referenceUrl=${Postgres_RDS_URL} --referenceUsername=${Postgres_RDS_USERNAME} --referencePassword=${Postgres_RDS_PASSWORD} --url=$Postgres_RDS_DIFF_URL --username=${Postgres_RDS_DIFF_USERNAME} --password=${Postgres_RDS_DIFF_PASSWORD} --contexts=$ENVIRONMENT_STEP diff
          echo "---------------------------------------------"
          echo "----------liquibase rollback to version1----------"
          echo "---------------------------------------------"
          liquibase --url=${Postgres_RDS_URL} --username=${Postgres_RDS_USERNAME} --password=${Postgres_RDS_PASSWORD} --contexts=$ENVIRONMENT_STEP rollback version1
        '''
      } // steps
    }   // Environment stage

        stage ('Deleting project workspace'){
           steps {
             sh '''
               { set +x; } 2>/dev/null
               echo "Deleting project workspace..."
               cd /root/workspace && rm -r ${PROJ}
             '''
           } // steps
         }   // Deleting project workspace
  } // stages
}  // pipeline
