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

# DRIVER CODE
github_org_name = "pocket-gophers-2014"

# enter your github account personal access token 
#   > create on github: settings > applications
#   > make sure admin:org scope is checked when creating the token
github_token = ""

puts get_github_org_repo_names("pocket-gophers-2014", github_token)
