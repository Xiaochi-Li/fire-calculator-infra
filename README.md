# CIDR allocation
The CIDR range reserved for the fire-calculator application is `11.16.0.0/16` ~ `11.63.0.0/16`.
In each AZ, 2 `/16` VPCs are reserved. This totals 48 VPCs across 4 AWS accounts.

| Account | Region | AZs | CIDR |
| -------- | -------- | -------- | -------- |
| Dev | ap-southeast-2 | a | 11.16.0.0/16 11.16.0.1/16|
| ~ | ~ | b | 11.16.0.2/16 11.16.0.3/16|
| ~ | ~ | c | 11.16.0.4/16 11.16.0.5/16|
| ~ | ap-southeast-4 | a | 11.16.0.6/16 11.16.0.7/16|
| ~ | ~ | b | 11.16.0.8/16 11.16.0.9/16|
| ~ | ~ | c | 11.16.0.10/16 11.16.0.11/16|