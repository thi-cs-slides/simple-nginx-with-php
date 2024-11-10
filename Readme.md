# PHP Development with nginx webserver and PHP v8 using VS Code and xdebug

Important: 
1. open the folder PHP-Development with VS Code after download or unpacking! Otherwise the launch configuration in .vscode/launch.json will not work.
2. Install the Extension `PHP Debug`, otherwise you will not be able to set breakpoints (among other things)

## start server

- run `docker-compose up -d`
- open browser at localhost:8181 to see index.html

## start debugging in VS Code

- open your php source file
- set breakpoint(s)
- start debugging (run menu entry)
- open your php source file in browser, execution should stop at your first breakpoint

## stop server

run `docker-compose down`
