#  Kubernetes Cronjob: Node Metrics

This project is meant to create a Kubernetes Cron job that runs at regular intervals, as defined and pull metrics from the node exporter endpoint. Each cronjob run creates a file in a Persistant Volume Claim (PVC) with filename distinguished by the timestamp. So, the data is retained, even on pod restarts.


### Usage
The below command automates the package and installation of the helm chart locally.
The helm chart is installed using the .tgz file generated during helm packaging.
```
>> bash deploy.sh 
```


### Folder Structure
```
One2N/
└── assignment
    ├── deploy.sh   ---> Run this, to deploy
    ├── docker
    │   ├── cron_job.sh               ---> bash script that's run by the cronjob
    │   └── Dockerfile
    ├── infra
    │   └── helm
    │       └── kube-cron-chart        ---> K8s yamls are packaged as helm chart
    │           ├── Chart.yaml
    │           ├── templates
    │           │   ├── cron.yaml          ---> CronJob
    │           │   ├── node-exporter.yaml ---> Node Exporter
    │           │   ├── pvc-inspector.yaml ---> a dummy pod for inspecting the PVC
    │           │   └── pvc.yaml           ---> PVC
    │           └── values.yaml            ---> Default values for helm 
    ├── readme.md
    └── task.txt

```

### CONSIDERATIONS
* We can run this project in any Kubernetes environment, I chose AWS EKS.
* Docker image (for the cronjob) was pushed to a public repo in Docker Registry, K8s will pull images from here.
* The Cronjob schedule can be changed easily in the values.yaml.


### OUTPUT
* Deployment of helm chart, will create the following
    * Namespace: monitoring
    * PVC: node-metrics-pvc
    * Cronjob: node-metrics-collector
    * Daemonset: node-exporter (ns: monitoring)
    * Service: node-exporter-service (ns: monitoring)
    * Pod: pvc-inspector
* The metrics are stored in PVC, at /data path.
* A dummy pod called pvc-inspector - is created which can be used to view these metrics

```
>> k exec -it pvc-inspector -- sh
>> cd data/

>> ls -ltr

-rw-r--r--    1 root     root         85717 Mar  8 05:33 stats_2024-03-08_05-33-00.log
-rw-r--r--    1 root     root         85734 Mar  8 05:34 stats_2024-03-08_05-34-00.log
```