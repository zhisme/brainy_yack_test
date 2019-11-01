# config valid for current version and patch releases of Capistrano
lock '~> 3.11.2'

set :application, 'brainy_yack_backend'
set :repo_url, 'git@github.com:zhisme/brainy_yack_test.git'

set :deploy_to, '/home/zh/apps/brainy_yack_backend'

# Default value for :linked_files is []
append :linked_files, 'config/database.yml', 'config/secrets.yml'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

set :keep_releases, 2
