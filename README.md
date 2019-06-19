# Lambda Layer Example

This is a lambda layer, use it like this:

  ```yaml
Parameters:
  LambdaLayerVersion:
    Type: String

...

Resources:
  PollerLambda:
    Type: AWS::Serverless::Function
    Properties:
      FunctionName: !Sub ${Service}-lambda
      CodeUri: ../src/lambdaSourceCode
      Handler: index.handler
      Layers: # Here you add the lambda layer config
        - !Sub arn:aws:lambda:${AWS::Region}:${AWS::AccountId}:layer:LambdaLayerExample:${LambdaLayerVersion}
      MemorySize: 128
      Runtime: nodejs8.10
      Timeout: 180
  ```

In your Makefile:

  ```bash
  LAMBDA_LAYER_VERSION = $(shell aws lambda list-layers | jq '.Layers[] | select(.LayerName == "LambdaLayer") | .LatestMatchingVersion.Version')


  aws cloudformation deploy \
  ...
  Environment=$(ENVIRONMENT) \
  LambdaLayerVersion=$(LAMBDA_LAYER_VERSION)
  ```

And in `jq` your bitbucket-pipelines.yml:

  ```
- apk add --no-cache py-pip make bash git openssh-client jq
  ```

## Pre requisite
1. Node
2. Make
3. awscli
4. jq
