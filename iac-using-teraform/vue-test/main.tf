provider "aws" {
  region  = "ap-southeast-1"
  profile = "yuri"
}

resource "aws_iam_role" "codebuild_role" {
  name = "codebuild-vue-test-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "codebuild.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role" "codepipeline_role" {
  name = "codepipeline-vue-test-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "codepipeline.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_policy" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "codepipeline_policy" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_s3_bucket" "pipeline_bucket" {
  bucket        = "vue-test-artifact-bucket-123456"
  force_destroy = true
}

resource "aws_codestarconnections_connection" "github_connection" {
  name          = "github-connection"
  provider_type = "GitHub"
}

resource "aws_codebuild_project" "vue_test" {
  name          = "vue-test"
  description   = "Clone vue-test repo from GitHub"
  service_role  = aws_iam_role.codebuild_role.arn
  build_timeout = 5

  source {
    type      = "CODEPIPELINE"
    buildspec = <<EOF
version: 0.2

phases:
  install:
    runtime-versions:
      nodejs: 18

  pre_build:
    commands:
      - echo Configuring Git credentials...
      - git config --global url."https://$GITHUB_TOKEN@github.com/".insteadOf "https://github.com/"

  build:
    commands:
      - echo "Cleaning workspace..."
      - rm -rf ./*
      - echo Cloning repository...
      - git clone --branch main https://github.com/AchillesLe/vue-components.git app
      - cd app
      - echo Installing Node.js dependencies...
      - npm install
      - echo Building project...
      - npm run build

  post_build:
    commands:
      - echo Publishing to NPM...
      - echo "//registry.npmjs.org/:_authToken=$NPM_TOKEN" > ~/.npmrc
      - npm publish

artifacts:
  files:
    - '**/*'
EOF
  }

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:7.0"
    type         = "LINUX_CONTAINER"

    environment_variable {
      name  = "GITHUB_TOKEN"
      value = var.GITHUB_TOKEN
    }
    environment_variable {
      name  = "NPM_TOKEN"
      value = var.NPM_TOKEN
    }
  }
}

resource "aws_codepipeline" "vue_test_pipeline" {
  name     = "vue-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.pipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "SourceAction"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.github_connection.arn
        FullRepositoryId = var.GIT_REPO
        BranchName       = "main"
      }
    }
  }

  stage {
    name = "CloneStage"

    action {
      name             = "CloneRepo"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["cloned_output"]
      configuration = {
        ProjectName = aws_codebuild_project.vue_test.name
      }
    }
  }
}
