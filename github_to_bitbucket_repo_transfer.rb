require 'httparty'
require 'json'

def get_github_org_repo_names(org_name, token)
  num_of_pages = 2 # WIP hard coding bc know there are ~170 repos in org, should change
  repo_names = []
  (1..num_of_pages).each do |page_num|
    response = HTTParty.get("https://api.github.com/orgs/#{org_name}/repos?page=#{page_num}&per_page=100",
                            :headers => { "User-Agent" => org_name,
                                          "Authorization" => "token #{token}"
                                        })
    repo_list = JSON.parse(response.body)
    repo_names += repo_list.map { |repo| repo["name"] }
  end
  repo_names
end


def create_bitbucket_repo(username, password, repo_name)
  print "\n"*3
  puts "creating bitbucket repo: #{repo_name}"
  system "curl --user #{username}:#{password} https://api.bitbucket.org/1.0/repositories/ \
          --data name=#{repo_name} \
          --data is_private=true"
end

def bare_clone_repo(org_name, repo_name)
  print "\n"*3
  puts "cloning #{repo_name} to bitbucket"
  system "git clone --bare git@github.com:#{org_name}/#{repo_name}.git"
  Dir.chdir "#{repo_name}.git"
end

def push_clone_to_bitbucket(username, repo_name)
  print "\n"*3
  puts "pushing clone of #{repo_name} to bitbucket"
  system "git push --mirror git@bitbucket.org:#{username}/#{repo_name}.git"
end

def delete_local_bare_clone(repo_name)
  Dir.chdir ".."
  system "rm -rf #{repo_name}.git"
end

# DRIVER CODE
github_org = "pocket-gophers-2014"

# enter your github account personal access token 
#   > create on github: settings > applications
#   > make sure admin:org scope is checked when creating the token
github_token = ""

# enter bitbucket credentials below
bitbucket_username = ""
bitbucket_password = ""


repo_names = get_github_org_repo_names(github_org, github_token)
# repo_names = ["phase-2-guide"]
repo_names.each do |repo|
  bare_clone_repo(github_org, repo)
  create_bitbucket_repo(bitbucket_username, bitbucket_password, repo)
  push_clone_to_bitbucket(bitbucket_username, repo)
  delete_local_bare_clone(repo)
end
