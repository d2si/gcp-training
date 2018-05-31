package main

import (
	"crypto/sha1"
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "%x\n", hashMe())
	})

	if err := http.ListenAndServe(":8000", nil); err != nil {
		fmt.Fprintf(os.Stderr, "unable to start server: %s\n", err)
		os.Exit(1)
	}
}

func hashMe() [sha1.Size]byte {
	data, err := ioutil.ReadFile(os.Args[0])
	if err != nil {
		fmt.Fprintf(os.Stderr, "unable to read file: %s\n", err)
		os.Exit(1)
	}

	return sha1.Sum(data)
}
