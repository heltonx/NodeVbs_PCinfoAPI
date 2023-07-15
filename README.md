# VBS-NodeJs-PCinfo-API

The vbscript and the node.js file must be at the same directorty (As the powershell script just consumes the API exposed, it can be located in any place).

In that directory, do the following steps:

1) npm init -y (Initialize a new Node.js project)

2) npm install express (Install the Express.js package)

3) node server.js  (run this command to start the API server)

4) open the api link http://localhost:3000/computerinfo at your browser (or run the ps1).


The /computerinfo endpoint is part of the API exposed by the server (whose source file is server.js). When a client makes an HTTP GET request to http://localhost:3000/computerinfo, the server receives the request, executes the VBScript code to retrieve the computer information, and sends back (to your broser or the ps1 script) the response in JSON format.

.....................
OBSERVATIONS

If, when run the ps1 script, you get the error similar to

    + CategoryInfo          : ErrodeSegurança: (:) [], PSSecurityException
    + FullyQualifiedErrorId : UnauthorizedAccess

This links can help, but anticipating, you run these two commands and will run:

1) Get-ExecutionPolicy (the result probably will be Restricted)

2) Set-ExecutionPolicy RemoteSigned (choose S or Y)

https://pt.stackoverflow.com/questions/220078/o-que-significa-o-erro-execu%C3%A7%C3%A3o-de-scripts-foi-desabilitada-neste-sistema






