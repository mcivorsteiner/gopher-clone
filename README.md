## Description
Script to transfer all repositories from a github organization to a Bitbucket account

## TODO BEFORE RUNNING:
- create bitbucket account
- need to connect ssh key to bitbucket
- create github account personal access token  
  > create on github: settings > applications  
  > make sure admin:org scope is checked when creating the token  


## TO RUN
- clone down this repo
- modify the app.rb file, filling in the args hash with the required info
- Run the following from the command line: 
```
ruby app.rb
```