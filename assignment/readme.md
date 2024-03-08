#  Kubernetes Cronjob: Node Metrics

This project is meant to create a Kubernetes Cron job that runs at regular intervals, as defined and pull metrics from the node exporter endpoint. Each cronjob run creates a file in a Persistant Volume Claim (PVC) with filename distinguished by the timestamp. So, the data is retained, even on pod restarts.


### Usage
```
cd One2N/assignment/infra/helm



```


### Folder Structure
```
One2N/
└── assignment
    ├── cron_job.sh                     ---> bash script that's run by the cronjob
    ├── Dockerfile                      
    ├── infra
    │   └── helm
    │       ├── kube-cron-chart         ---> K8s yamls are packaged as helm chart
    │          ├── Chart.yaml
    │          ├── templates
    │          │   ├── cron.yaml          ---> CronJob
    │          │   ├── node-exporter.yaml ---> Node Exporter
    │          │   ├── pvc-inspector.yaml ---> a dummy pod for inspecting the PVC 
    │          │   └── pvc.yaml           ---> PVC
    │          └── values.yaml            ---> Default values for helm 
    │     
    ├── readme.md
    └── task.txt
```

### CONSIDERATIONS
* We can run this project in any Kubernetes environment, I chose AWS EKS.
* Docker image (for the cronjob) was pushed to a public repo in Docker Registry, K8s will pull images from here.


