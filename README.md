# RabbitMQ as API proxy PoC

## Notable

* using straight `bunny` adapter.
* using Puma (threaded web server)
* rails-api in lieu if full rails




Just a simple test, not wholly real world.

* See api/posts controller for 'api'
* See app/services for Publisher and Subscriber.

Inspired from: http://codetunes.com/2014/event-sourcing-on-rails-with-rabbitmq/


1000 Posts models `title:string, body: text, published: boolean`

`siege -c 10 -t 1M http://localhost:3000/api/posts.json`

## With Straight ActiveRecord

```bash
Transactions:            247 hits
Availability:         100.00 %
Elapsed time:          59.63 secs
Data transferred:        66.35 MB
Response time:            1.82 secs
Transaction rate:         4.14 trans/sec
Throughput:           1.11 MB/sec
Concurrency:            7.55
Successful transactions:         247
Failed transactions:             0
Longest transaction:          3.89
Shortest transaction:         0.45
```

## With Publish to rabbit all rows and then pop all from queue (synchronously)

```bash
Transactions:            128 hits
Availability:         100.00 %
Elapsed time:          59.39 secs
Data transferred:        34.38 MB
Response time:            3.56 secs
Transaction rate:         2.16 trans/sec
Throughput:           0.58 MB/sec
Concurrency:            7.67
Successful transactions:         128
Failed transactions:             0
Longest transaction:          7.72
Shortest transaction:         0.51
```
