#!/bin/bash
timestamp=$(date +%Y-%m-%d_%H-%M-%S)
filename="/data/stats_${timestamp}.log"
SVC_NAME="node-exporter-service" ##K8s service name used for the node exporter
NAMESPACE="monitoring" ##K8s namespace where the node exporter is installed
PORT="9100" ##K8s port  used for the service

wget -O $filename http://${SVC_NAME}.${NAMESPACE}.svc.cluster.local:${PORT}/metrics
