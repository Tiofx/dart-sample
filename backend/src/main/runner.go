package main

import (
	"fmt"
	"path/filepath"
	"os/exec"
	"bufio"
)

func main() {
	channel := make(chan string)
	commandForStartBackend := exec.Command("bee", "run", getPathToBackend())

	commandForStartFrontend := exec.Command("pub", "serve", "--port=8081")
	commandForStartFrontend.Dir = getPathToFrontend()

	go startSide("<|--- | backend  | ", commandForStartBackend, channel)
	go startSide("---|> | frontend | ", commandForStartFrontend, channel)
	//docker start confident_lamarr

	for temp := range channel {
		fmt.Println(temp)
	}
}

func startSide(tag string, commandForStartBackend *exec.Cmd, c chan string) {
	defer close(c)
	stdout, err := commandForStartBackend.StdoutPipe()
	defer stdout.Close()
	reader := bufio.NewReader(stdout)
	commandForStartBackend.Start()

	for err == nil {
		if line, _, err := reader.ReadLine(); err == nil && len(line) != 0 {
			c <- tag + string(line)
		} else {
			c <- tag + "error " + err.Error()
		}
	}
}

func getPathToBackend() string {
	if projectPath, err := filepath.Abs("./"); err == nil {
		return filepath.Join(projectPath, "src", "beego")

	} else {
		fmt.Print(err.Error())
		panic(err)
	}
}

func getPathToFrontend() string {
	if projectPath, err := filepath.Abs("../"); err == nil {
		return filepath.Join(projectPath, "frontend")

	} else {
		fmt.Print(err.Error())
		panic(err)
	}
}
