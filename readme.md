# Setup
## run the following in root:
- npm ci
- make protoc-js

## Next setup /api
- cd /api
- npm ci
- npm link ../js
- npm run build
- npm run start

To fix import you can run the fiximport.sh script