DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Repository;

CREATE TABLE IF NOT EXISTS User (id INTEGER PRIMARY KEY, rawLogin TEXT, login TEXT, name TEXT, bio TEXT, email TEXT, avatar_url TEXT, html_url TEXT, blog TEXT, company TEXT, location TEXT, collaborators INTEGER, public_repos INTEGER, owned_private_repos INTEGER, public_gists INTEGER, private_gists INTEGER, followers INTEGER, following INTEGER, disk_usage INTEGER);
CREATE TABLE IF NOT EXISTS Repository (id INTEGER PRIMARY KEY, name TEXT, owner_login TEXT, owner_avatar_url TEXT, description TEXT, language TEXT, pushed_at TEXT, created_at TEXT, updated_at TEXT, clone_url TEXT, ssh_url TEXT, git_url TEXT, html_url TEXT, default_branch TEXT, private INTEGER, fork INTEGER, watchers_count INTEGER, forks_count INTEGER, stargazers_count INTEGER, open_issues_count INTEGER, subscribers_count INTEGER);
CREATE TABLE IF NOT EXISTS Search (id INTEGER PRIMARY KEY autoincrement, keyword TEXT, searched_at TEXT, userId INTEGER);
CREATE TABLE IF NOT EXISTS User_Following_User (id INTEGER PRIMARY KEY autoincrement, userId INTEGER, targetUserId INTEGER);
CREATE TABLE IF NOT EXISTS User_Starred_Repository (id INTEGER PRIMARY KEY autoincrement, userId INTEGER, repositoryId INTEGER);