## Description
Allows you to transfer all repositories from a github organization to a Bitbucket account.

## TODO BEFORE RUNNING:
- Create a <a href="https://bitbucket.org/" target="_blank">Bitbucket Account</a>
- Add ssh key to Bitbucket and Github accounts (account settings > SSH keys)
- Create Github account personal access token (account settings > applications)  
  - make sure the 'read:org' scope is checked when creating the token  


## TO RUN
- Clone down this repo
- Modify the app.rb file, filling in the args hash with the following info:
  - :github_org - name of Github organization you want to copy all repos from
  - :github_token - Github account personal access token
  - :bitbucket_username
  - :bitbucket_password
- Run the following from the command line: 
```
ruby app.rb
```