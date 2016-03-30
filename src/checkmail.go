package main

import (
	"os"
	"os/exec"
    "fmt"
    "github.com/jasonlvhit/gocron"
)


func checkPersonalInbox() {
	cmd := "mbsync"
	args := []string{"aaermolov@gmail.com-inbox"}
	if err := exec.Command(cmd, args...).Run(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	fmt.Println("Successfully checked aaermolov@gmail.com-inbox")
}

func checkWorkInbox() {
	cmd := "mbsync"
	args := []string{"aermolov@mirantis.com-inbox"}
	if err := exec.Command(cmd, args...).Run(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	fmt.Println("Successfully checked aermolov@mirantis.com-inbox")
}

func checkPersonalFull() {
	cmd := "mbsync"
	args := []string{"aaermolov@gmail.com"}
	if err := exec.Command(cmd, args...).Run(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	fmt.Println("Successfully checked aaermolov@gmail.com")
}

func checkWorkFull() {
	cmd := "mbsync"
	args := []string{"aermolov@mirantis.com"}
	if err := exec.Command(cmd, args...).Run(); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	fmt.Println("Successfully checked aermolov@mirantis.com")
}

func main() {
    gocron.Every(3).Minutes().Do(checkPersonalInbox)
    gocron.Every(3).Minutes().Do(checkWorkInbox)
    gocron.Every(20).Minutes().Do(checkPersonalFull)
    gocron.Every(20).Minutes().Do(checkWorkFull)
    <- gocron.Start()
}
