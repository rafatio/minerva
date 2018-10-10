build:
	docker build -t minerva_fundo .

run: build
	docker run -v `pwd`:/app -p 3000:3000 -d minerva_fundo
