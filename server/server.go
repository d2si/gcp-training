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
		fmt.Fprintf(w, "%x\n", hashMe(os.Args[0]))
	})

	http.ListenAndServe(":80", nil)
}

func hashMe(path string) [sha1.Size]byte {
	data, err := ioutil.ReadFile(path)
	if err != nil {
		panic("unable to read file")
	}

	return sha1.Sum(data)
}
