ENVIRONMENT = ? dev

.PHONY: deploy
deploy:
	./node_modules/.bin/serverless deploy

clean:
	npm cache clean --force
	( cd files/nodejs && npm cache clean --force)
	rm -rf node_modules
	rm -rf ./files/nodejs/node_modules

install:
	npm install
	( cd files/nodejs && npm install)

install_production:
	npm install --production

prune:
	npm prune --production

get_layer_info:
	aws lambda list-layers | jq '.Layers[] | select(.LayerName == "LambdaLayer")'
