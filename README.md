# localstack-route53-ns-bug
Reproducing a limitation with LocalStack with Route53 NS records

## Reproduce

1. SetUp env for debugging and Pro support

```sh
export LOCALSTACK_API_KEY=<api-key>
export DEBUG=1 
```

1. Run the stack `docker-compose up`
This will run localstack and terraform.

1. Setup DNS resolver to `127.0.0.1` and try resolving the domain
```sh
dig @127.0.0.1 api.base.r53x
```
