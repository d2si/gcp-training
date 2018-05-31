This code creates an HTTP server that simulates CPU-intensive requests by returning a SHA-1 hash of its own binary as a response.

To build it, you'll need a [Go language](https://golang.org/) compiler >= 1.9:

```
go build -o server server.go
```

Once running, the HTTP server listens to port 8000 for requests on `/`.
