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

def create_bitbucket_repo(repo_name, username, password)
  puts "creating bitbucket repo: #{repo_name}"
  system "curl --user #{username}:#{password} https://api.bitbucket.org/1.0/repositories/ \
          --data name=#{repo_name} \
          --data is_private=true"
end

def bare_clone_repo(repo_name, org_name)
  puts "cloning #{repo_name} to bitbucket"
  system "git clone --bare git@github.com:#{org_name}/#{repo_name}.git"
  Dir.chdir "#{repo_name}.git"
end

def push_clone_to_bitbucket(repo_name, username)
  puts "pushing clone of #{repo_name} to bitbucket"
  system "git push --mirror git@bitbucket.org:#{username}/#{repo_name}.git"
end

def delete_local_bare_clone(repo_name)
  Dir.chdir ".."
  system "rm -rf #{repo_name}.git"
end

def copy_github_repo_to_bitbucket(repo_name, args)
  bare_clone_repo(repo_name, args[:github_org])
  create_bitbucket_repo(repo_name, args[:bitbucket_username], args[:bitbucket_password])
  push_clone_to_bitbucket(repo_name, args[:bitbucket_username])
  delete_local_bare_clone(repo_name)
end

