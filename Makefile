generated_dir := proto

all: swift go

swift:
	mkdir -p ${generated_dir}
	# Swift requires absolute path
	protoc *.proto \
		--proto_path=. \
		--plugin=$(which protoc-gen-swift) \
		--swift_opt=Visibility=Public \
		--swift_out=${generated_dir}
	protoc *.proto \
		--proto_path=. \
		--plugin=$(which protoc-gen-grpc-swift) \
		--grpc-swift_opt=Visibility=Public \
		--grpc-swift_out=${generated_dir}
go:
	mkdir -p ${generated_dir}
	protoc --go_out=plugins=grpc:${generated_dir} *.proto

clean:
	mkdir -p proto
	rm -rf proto

.PHONY: all
