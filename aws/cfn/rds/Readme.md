export DB_PASSWORD=<db_password>
gp env DB_PASSWORD=<db_password>

get the new db endpoint
Go to System Manager and update the parameter store named connection URL 


Add TCP inbound rule to port 5432 from anywhere on the new DB SG

Goto R53 to the hosted zone - cruddursn.net - api.cruddursn.net - change the load balancer to the new one
change also the cruddursn.net load balancer pointing