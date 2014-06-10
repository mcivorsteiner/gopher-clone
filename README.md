# Gopher Clone
### DESCRIPTION
Allows you to copy all repositories (and their  branches) from a Github organization to a Bitbucket account.  The resulting repos on Bitbucket are private.

### TODO BEFORE RUNNING:
- Create a <a href="https://bitbucket.org/" target="_blank">Bitbucket Account</a>
- Add SSH key to Bitbucket and Github accounts (account settings > SSH keys)
- Create Github account personal access token (account settings > applications)  
  - make sure the 'read:org' scope is checked when creating the token  


### TO RUN
- Clone down this repo
- Modify the app.rb file, filling in the args hash with the following info:
  - :github_org - name of Github organization you want to copy all repos from
  - :github_token - Github account personal access token
  - :bitbucket_username
  - :bitbucket_password
- Install httparty gem if not already installed ("gem install httparty")
- Run the following from the command line: 
```
ruby app.rb
```
- You will be prompted once or twice to verify the host authenticity, type "yes" when prompted
- Thats it!  The time it takes to transfer the repos will vary depending on the number of repos and their size.