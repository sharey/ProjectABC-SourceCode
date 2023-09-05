#!/bin/sh
kubectl port-forward --address 0.0.0.0 svc/projectabc 31000:8080 &
