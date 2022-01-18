SCRIPT_DIR=$(cd $(dirname $0); pwd -P)
ROOT_DIR=$(cd "${SCRIPT_DIR}/.."; pwd -P)

TMP_DIR="${ROOT_DIR}/tmp"
CHART_DIR="${ROOT_DIR}/stable"

echo "CHART_DIR: ${CHART_DIR}"
echo "TMP_DIR: ${TMP_DIR}"
echo "ROOT_DIR: ${ROOT_DIR}"

mkdir -p "${TMP_DIR}"

cd "${TMP_DIR}"

ls "${CHART_DIR}" | while read chart; do
  echo "chart: $chart"
  helm package "${CHART_DIR}/${chart}"
done

cd "${ROOT_DIR}"

#git checkout --track origin/gh-pages


cp ${TMP_DIR}/* ${ROOT_DIR}/docs/

helm repo index "${ROOT_DIR}/docs/" --url "https://github.com/dw-csplab-gitops/csplab-multi-tenancy-gitops-charts/stable" --merge "${CHART_DIR}/docs/index.yaml"
#cp "${CHART_DIR}/index.yaml" "${ROOT_DIR}"