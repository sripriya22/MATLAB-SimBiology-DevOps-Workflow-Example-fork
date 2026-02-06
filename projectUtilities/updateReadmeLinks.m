function updateReadmeLinks()
%UPDATEREADMELINKS Updates links in README from original repo URL to forked
%repo URL

% Original URL
origRepoURL = "https://github.com/ChezJe/MATLAB-SimBiology-DevOps-Workflow-Example";
origRepoInfo = extractRepoIdentifiers(origRepoURL);

% Extract remote repo URL
g = gitrepo();
newRepoURL = g.Remotes.URL;
newRepoInfo = extractRepoIdentifiers(newRepoURL);

% Update README with current URLs
readmeText = fileread("README.md");
readmeText = replace(readmeText,origRepoInfo.RepoURL,newRepoInfo.RepoURL);
readmeText = replace(readmeText,origRepoInfo.PagesURL,newRepoInfo.PagesURL);
readmeText = replace(readmeText, ...
    "repo=" + origRepoInfo.UsernameAndRepoName, ...
    "repo=" + newRepoInfo.UsernameAndRepoName);
f = fopen("README.md","w");
fwrite(f,readmeText,"char");
fclose(f);

end

function repoInfo = extractRepoIdentifiers(inputURL)
repoURL = erase(inputURL,".git");
usernameAndOrg = extractAfter(repoURL,"github.com/");
tmpSplit = split(usernameAndOrg,"/");
username = tmpSplit(1);
repoName = tmpSplit(2);
pagesURL = "https://" + username + ".github.io/" + repoName;

repoInfo = struct( ...
    RepoURL = repoURL, ...
    PagesURL = pagesURL, ...
    UsernameAndRepoName = usernameAndOrg, ...
    Username = username, ...
    RepoName = repoName);
end