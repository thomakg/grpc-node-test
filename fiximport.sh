#!/bin/sh

# We need to use grpc-js, not grpc. See: https://github.com/improbable-eng/ts-protoc-gen#using-grpcgrpc-js-instead-of-grpc
# It's supposed to do this, but it doesn't.
echo -e "Fixing import of 'grpc' package instead of 'grpc-js'"
for folder in $(ls ./js/proto/); do
    if [[ -d ./js/proto/$folder ]]; then
        for subFolder in $(ls ./js/proto/$folder); do
            if [[ -d ./js/proto/$folder/$subfolder ]]; then
                for subSubFolder in $(ls ./js/proto/$folder/$subFolder); do
                    for filename in $(ls ./js/proto/$folder/$subFolder/$subSubFolder | grep -E ".d.ts"); do
                        # sed -i -e 's%import * as grpc from "grpc";%import * as grpc from "@grpc/grpc-js";%g' $filename
                        echo $subSubFolder
                        echo $filename
                        sed -i 's%import \* as grpc from "grpc";%import \* as grpc from "@grpc/grpc-js";%g' js/$folder/$subFolder/$subSubFolder/$filename
                        exitCode=$?
                    done
                done
            else
                for filename in $(ls ./js/proto/$folder/$subFolder | grep -E ".d.ts"); do
                    # sed -i -e 's%import * as grpc from "grpc";%import * as grpc from "@grpc/grpc-js";%g' $filename
                    echo $subFolder
                    echo $filename
                    sed -i 's%import \* as grpc from "grpc";%import \* as grpc from "@grpc/grpc-js";%g' js/$folder/$subFolder/$filename
                    exitCode=$?
                done
            fi
        done

    else
        for filename in $(ls ./js/proto/$folder/ | grep -E ".d.ts"); do
            # sed -i -e 's%import * as grpc from "grpc";%import * as grpc from "@grpc/grpc-js";%g' $filename
            echo $folder
            echo $filename
            sed -i 's%import \* as grpc from "grpc";%import \* as grpc from "@grpc/grpc-js";%g' js/$folder/$filename
            exitCode=$?
        done
    fi
done
