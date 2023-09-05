#!/bin/sh
( ( nohup kubectl port-forward --address 0.0.0.0 svc/projectabc 31000:8080>/dev/null 2>&1)  & )
