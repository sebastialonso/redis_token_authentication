# In-memory token-based authentication

The point of this app is to toy with the concept of Redis-based expiring authentication/session tokens for a microservice consisting in the management of user logic.

Since the token will be sent and compared in every request made to the service, storing the tokens in a table could potentially slowed the performance of the service. In-memory solutions could speed up this process and the same time favor an horizontal scaling if needed. Redis is the store used in this project.

Authentication is implemented from scratch, using bcrypt for management of both salts and encrypted passwords. Tokens are created using the excellent MicroToken gem.

Several articles were used as inspiration and also as resources. They appear in the References section

##References
