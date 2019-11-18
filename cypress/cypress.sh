docker run -it \
  -v $PWD:/cypress \
  -w /cypress \
  -e CYPRESS_baseUrl=http://0.0.0.0:3000 \
  cypress/included:3.3.1