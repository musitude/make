# install tools (static analysis, mocking, etc)
install:
	go install github.com/golang/mock/mockgen
	go get github.com/securego/gosec/cmd/gosec
	GO111MODULE=on go get github.com/sonatype-nexus-community/nancy
.PHONY: install

# execute application tests and static analysis
test:
	bash -c 'diff -u <(echo -n) <(gofmt -s -d .)'
	gosec ./...
	go vet ./...
	nancy go.sum
	go test -race ./...
.PHONY: test

# run dynamodb locally using docker
dynamodb-local:
	docker run -d -p 8000:8000 -v $(PWD)/local/dynamodb:/data/ amazon/dynamodb-local -jar DynamoDBLocal.jar -sharedDb -dbPath /data
.PHONY: dynamodb
