FROM golang:buster AS builder

COPY /public /app/public/
COPY server.go go.mod /app/
WORKDIR /app
RUN CGO_ENABLED=0 go build -ldflags '-s -w' -o web-server ./server.go


FROM scratch

COPY --from=builder /app/web-server /bin/web-server
ENTRYPOINT ["/bin/web-server"]
