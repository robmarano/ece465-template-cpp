# ece465-template-cpp
ECE 465 Source Code Template for C++

This repo provides a client program that connects via a socket listening by a server program. The code is C++ built with Boost. Read [HOWTO-BOOST-UBUNTU.md](./HOWTO-BOOST-UBUNTU.md) to install and use Boost.

This has been tested on Ubuntu (WSL) and Mac OS. Be careful to configure Base.mk and the run-client.sh and run-server.sh shell files that run the programs.

Before you begin, you will need to build the [ServeD RESTful framework](https://github.com/meltwater/served), which is included in this repo as a submodule. You can see it as [served](./served/) when you at the contents of this directory.

# Build ServeD
Start with a terminal on Linux or macos in the repo as cloned on your computer. Mine will be in ```$HOME/dev/cooper/ece465/ece465-template-cpp```

You will need to install ```cmake``` on your Linux or macos:
* On Debian Linux (ubuntu) you will issue the command ```apt update &&  apt install -y cmake```
* On macos with Homebrew you will issue the command ```brew install cmake```

### Build ServeD
```bash
$ cd ece465-template-cpp
$ git checkout zkApp
$ mkdir served.build
$ cd served.build
$ cmake ../served
$ make
```

After it is successfully built, you will issue the following commands:
```bash
$ cd ece465-template-cpp
$ git checkout zkApp
$ cd served.build
$ make package
```

This will create a file in the directory ```ece465-template-cpp```:
```bash
libserved-1.4.3-Linux.tar.gz
```

Then issue the following commands to expand the build
```bash
$ cd ece465-template-cpp
$ git checkout zkApp
$ cd served.build
$ mkdir build
$ cd build
$ tar xvfz ../libserved-1.4.3-Linux.tar.gz
$ cd libserved-1.4.3-Linux
$ ls -la
```
After you issue ```ls -la``` you will see
```bash
drwxrwxr-x 5 rob rob 4096 Dec  9 15:06 .
drwxrwxr-x 3 rob rob 4096 Dec  9 15:06 ..
drwxrwxr-x 2 rob rob 4096 Dec  9 15:03 bin
drwxrwxr-x 3 rob rob 4096 Dec  9 15:03 include
drwxrwxr-x 3 rob rob 4096 Dec  9 15:03 lib
```
Now you are ready to go and build the example code in ```ece465-template-cpp```

# Build the ```node-server``` in ```ece465-template-cpp```

## Build the server code for a node
```bash
$ cd ece465-template-cpp
$ make clean
$ make
```

## Run ```node-server```
```bash
$ cd ece465-template-cpp
$ ./run-server.sh
```

The output will be:
```bash
Running node-server ...
Server running in background. Check server.log
Done. Don't forget to remove server.log.
```

## Test ```node-server```
Ensure you have no other processes using port 8080 on your host.
```bash
$ cd ece465-template-cpp
$ curl http://localhost:8080/hello
```

If done correctly, you will see this output:
```bash
Hello world!
```

You've got it running!

## Kill the ```node-server``` process
Issue the following command in the repo:
```bash
$ app_kill_server.sh
```

Now update the code to fit your application service needs for each node in your distributed cluster runnning on Zookeeper!