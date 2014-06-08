require_relative 'github_to_bitbucket'

args = {
    # name of the github organization that you want to copy all repos from
    :github_org => "",

    # your github account personal access token (create on github: settings > applications, and make sure admin:org scope is checked when creating the token)
    :github_token => "",

    # bitbucket account credentials
    :bitbucket_username => "",
    :bitbucket_password => ""
  }

repo_names = get_github_org_repo_names(args[:github_org], args[:github_token])

repo_names.each_with_index do |repo, index|
  puts "\n\n\nPROCESSING REPO #{index + 1} OF #{repo_names.length}: #{repo}\n\n"
  copy_github_repo_to_bitbucket(repo, args)
end

