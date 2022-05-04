#export GIT_SHA="bfe4ff103191cd7a4659b7f9995f72f93481cc94"
# export REGISTRY_URL="asia-south1-docker.pkg.dev/izac-349007/izacdocker/master"

# export GIT_SHA_FLINK="69100cbc511b9289fd84b22580fc1abe966287f7"
# export REGISTRY_URL_FLINK="asia-south1-docker.pkg.dev/izac-349007/izacdocker/main"
export GIT_SHA="03052022"
export REGISTRY_URL="awhiteklay"

export GIT_SHA_FLINK="03052022"
export REGISTRY_URL_FLINK="awhiteklay"

export KAFKA_ADDRESS=izac-cp-kafka-headless:9092

export SCHEMA_REGISTRY_URL=http://izac-cp-schema-registry:8081

export FLINK_BUCKET=wasbs://izac-flink@izzac.blob.core.windows.net

export FLOW_CONFIGS='{\\\"flinkProperties\\\": {\\\"fs.azure.account.key.izzac.blob.core.windows.net\\\": \\\"/yF/lxi/Tx9uLa3fSSuUqr1rvVowwDX6bRuYwFtmJYFRwwLMNIDSBMzTi7l31dN6ue+Jpt1DVNLzf+1bX6RgOQ==\\\"}}'


helm upgrade --install izac izac-helm-charts --set client.image.repository=${REGISTRY_URL}/client --set client.image.tag=${GIT_SHA} --set server.image.repository=${REGISTRY_URL}/server --set server.image.tag=${GIT_SHA} --set consumeroffsetsparser.image.repository=${REGISTRY_URL}/consumeroffsetsparser --set consumeroffsetsparser.image.tag=${GIT_SHA} --set eventview.image.repository=${REGISTRY_URL}/eventview --set eventview.image.tag=${GIT_SHA} --set cp-kafka-connect.image.repository=${REGISTRY_URL}/kafkaconnect --set cp-kafka-connect.image.tag=${GIT_SHA}  --set queryconsumeroffsets.image.repository=${REGISTRY_URL}/queryconsumeroffsets --set queryconsumeroffsets.image.tag=${GIT_SHA} --set kafkaadmin.image.repository=${REGISTRY_URL}/kafkaadmin --set kafkaadmin.image.tag=${GIT_SHA} --set flow-utils.image.repository=${REGISTRY_URL_FLINK}/flow-utils --set flow-utils.image.tag=${GIT_SHA_FLINK} --set flow-utils.jarBuildingJob.image=${REGISTRY_URL_FLINK}/flow_utils_jar_building:${GIT_SHA_FLINK} --set flow-utils.flowJob.image=${REGISTRY_URL_FLINK}/flow:${GIT_SHA_FLINK}  --set flow-utils.kafka.external=false --set flow-utils.kafka.address=${KAFKA_ADDRESS} --set flow-utils.schemaRegistry.external=false --set flow-utils.schemaRegistry.address=${SCHEMA_REGISTRY_URL} --set flow-utils.flowJob.namespace=${WATCH_NAMESPACE} --set flow-utils.flowJob.flinkBucket=${FLINK_BUCKET} --set flow-utils.flowJob.flowConfigs='\{\\\"flinkProperties\\\": \{\\\"fs.azure.account.key.izzac.blob.core.windows.net\\\": \\\"/yF/lxi/Tx9uLa3fSSuUqr1rvVowwDX6bRuYwFtmJYFRwwLMNIDSBMzTi7l31dN6ue+Jpt1DVNLzf+1bX6RgOQ==\\\"\}\}' --set flow-validator.image.repository=${REGISTRY_URL_FLINK}/flow-validator --set flow-validator.image.tag=${GIT_SHA_FLINK} --set flow-validator.kafka.external=false --set flow-validator.kafka.address=${KAFKA_ADDRESS} --set flow-validator.schemaRegistry.external=false --set flow-validator.schemaRegistry.address=${SCHEMA_REGISTRY_URL} --set profile-kafka-to-postgres.image.repository=${REGISTRY_URL_FLINK}/profile-kafka-to-postgres --set profile-kafka-to-postgres.image.tag=${GIT_SHA_FLINK} --set profile-kafka-to-postgres.kafka.external=false --set profile-kafka-to-postgres.kafka.address=${KAFKA_ADDRESS} --set profile-kafka-to-postgres.schemaRegistry.external=false --set profile-kafka-to-postgres.schemaRegistry.address=${SCHEMA_REGISTRY_URL} --set profile-metrics-api.image.repository=${REGISTRY_URL_FLINK}/profile-metrics-api --set profile-metrics-api.image.tag=${GIT_SHA_FLINK} -n izac
