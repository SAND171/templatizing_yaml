export GIT_SHA="adfec6231466e8c1b81539d3dd3b57cc158384fd"
export REGISTRY_URL="prohankumar"

export KAFKA_ADDRESS=izac-cp-kafka-headless:9092

export SCHEMA_REGISTRY_URL=http://izac-cp-schema-registry:8081

export FLINK_BUCKET=wasbs://izac-flink@izzac.blob.core.windows.net

export FLOW_CONFIGS='{"flinkProperties": {"fs.azure.account.key.izzac.blob.core.windows.net": "/yF/lxi/Tx9uLa3fSSuUqr1rvVowwDX6bRuYwFtmJYFRwwLMNIDSBMzTi7l31dN6ue+Jpt1DVNLzf+1bX6RgOQ=="}}'


helm upgrade --install izac izac-helm-charts --set flow-utils.image.repository=${REGISTRY_URL}/flow-utils --set flow-utils.image.tag=${GIT_SHA} --set flow-utils.jarBuildingJob.image=${REGISTRY_URL}/flow_utils_jar_building:${GIT_SHA} --set flow-utils.flowJob.image=${REGISTRY_URL}/flow:${GIT_SHA}  --set flow-utils.kafka.external=false --set flow-utils.kafka.address=${KAFKA_ADDRESS} --set flow-utils.schemaRegistry.external=false --set flow-utils.schemaRegistry.address=${SCHEMA_REGISTRY_URL} --set flow-utils.flowJob.namespace=${WATCH_NAMESPACE} --set flow-utils.flowJob.flinkBucket=${FLINK_BUCKET} --set flow-utils.flowJob.flowConfigs=${FLOW_CONFIGS} --set flow-validator.image.repository=${REGISTRY_URL}/flow-validator --set flow-validator.image.tag=${GIT_SHA} --set flow-validator.kafka.external=false --set flow-validator.kafka.address=${KAFKA_ADDRESS} --set flow-validator.schemaRegistry.external=false --set flow-validator.schemaRegistry.address=${SCHEMA_REGISTRY_URL} --set profile-kafka-to-postgres.image.repository=${REGISTRY_URL}/profile-kafka-to-postgres --set profile-kafka-to-postgres.image.tag=${GIT_SHA} --set profile-kafka-to-postgres.kafka.external=false --set profile-kafka-to-postgres.kafka.address=${KAFKA_ADDRESS} --set profile-kafka-to-postgres.schemaRegistry.external=false --set profile-kafka-to-postgres.schemaRegistry.address=${SCHEMA_REGISTRY_URL} --set profile-metrics-api.image.repository=${REGISTRY_URL}/profile-metrics-api --set profile-metrics-api.image.tag=${GIT_SHA}