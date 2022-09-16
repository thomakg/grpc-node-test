PROTO_FILES=$(shell find . -path '*.proto' -and -not -path './node_modules/*' -and -not -path './cloud_functions/*' -and -not -path './python*' -and -not -path './out*' -and -not -path './api/*')


js:
	@mkdir -p $@

.PHONY: protoc-js
PROTOC_GEN_TS_PATH="./node_modules/.bin/protoc-gen-ts"
PROTOC_GEN_GRPC_PATH="./node_modules/.bin/grpc_tools_node_protoc_plugin"
TS_PROTOC="./node_modules/.bin/grpc_tools_node_protoc"
PROTOC_JS_FOLDER="./js"
protoc-js: js
	$(TS_PROTOC) \
		-I proto \
		-I /usr/local/include \
        --plugin=protoc-gen-ts=${PROTOC_GEN_TS_PATH} \
        --plugin=protoc-gen-grpc=${PROTOC_GEN_GRPC_PATH} \
        --js_out=import_style=commonjs,binary:js \
        --ts_out="service=grpc-node,mode=grpc-js:${PROTOC_JS_FOLDER}" \
        --grpc_out="grpc_js:${PROTOC_JS_FOLDER}" \
		$(PROTO_FILES)