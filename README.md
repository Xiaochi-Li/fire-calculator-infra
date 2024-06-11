# CIDR allocation
The CIDR range reserved for the fire-calculator application is `11.16.0.0/16` ~ `11.63.0.0/16`.
In each AZ, 2 `/16` VPCs are reserved. This totals 48 VPCs across 4 AWS accounts.

| Account | Region | AZs | CIDR |
| -------- | -------- | -------- | -------- |
| Dev | ap-southeast-2 | a | 11.16.0.0/16 |
| ~ | ~ | b | 11.17.0.0/16 |
| ~ | ~ | c | 11.18.0.0/16 |
| ~ | ap-southeast-4 | a | 11.19.0./16 |
| ~ | ~ | b | 11.20.0.0/16 |
| ~ | ~ | c | 11.21.0.0/16 |

# Infrastructure Diagram
![Alt text](/img/infra-diagram.png)