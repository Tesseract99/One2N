#!/bin/bash
chart_name="kube-cron-chart"
helm_path="infra/helm/"
tar_backup="backup"
helm_tar="null"
helm_name=""

if [ -d "${helm_path}/${chart_name}" ]; then
  echo -e "Chart exists, proceeding. \n"
else
  echo "Chart does not exist, exiting. \n"
  exit
fi


cd $helm_path



# tar_pattern="${chart_name}"*.tgz
helm_tar=`ls "${chart_name}"*".tgz"`
if [ -f "${helm_tar}" ]; then
  echo -e "Tar exists, taking Backup \n"
  mkdir -p "${tar_backup}"
  mv "${chart_name}"*".tgz" "${tar_backup}"
fi


echo -e "Packaging helm.\n"
helm package ${chart_name}




if [ $helm_tar == "null" ]; then
    echo -e "Helm tar not found. Exiting. \n"
    exit
else
    echo -e "Helm tar: ${helm_tar}"
fi

echo -e "Deploying the Helm Chart.\n"
echo -e "Please provide the helm name: "
read helm_name

helm install "${helm_name}" "${helm_tar}"

echo -e "Successfully deployed helm chart\n"
sleep 2s

helm list