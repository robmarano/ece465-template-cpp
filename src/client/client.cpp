#include <boost/asio.hpp>

#include <fstream>

#include <string>

#include <vector>

#include <iostream>

#include <boost/array.hpp>

#include <cctype>

 

using boost::asio::ip::tcp;

#define BOOST_TEST_MODULE <client.cpp>

class client {

public:

    int currentState(tcp::socket &socket);

    int sendStuff(std::string msg, int choice, tcp::socket &socket);

    int execute();

    client(std::string host, int port) : host(host), state("sleep"), port(port) {}

   

    ~client() {}

 

    std::string getHost() { return host;}

    void setHost(std::string newHost) { host = newHost; }

    int getPort(){ return port;}

 

private:

    std::string host;

    std::string state;

    int port;

};

 

int client::execute()

{

    boost::asio::io_context io_context;

    tcp::resolver resolver(io_context);

    tcp::resolver::results_type endpoints = resolver.resolve(getHost(), std::to_string(getPort()));

    tcp::socket socket(io_context);

    boost::asio::connect(socket, endpoints);

    currentState(socket);

    io_context.run();

    return 0;

}

 

int client::sendStuff(std::string msg, int choice, tcp::socket &socket) {

    switch (choice) {

        case 1:

        {

            try {

                std::string upLoadFile;

                std::cout << "What file would you like to upload?" << std::endl;

                std::cin >> upLoadFile;

                std::ifstream file(upLoadFile, std::ios_base::binary | std::ios_base::ate);

 

                if (file) {

                    size_t file_size = file.tellg();

                    file.seekg(0);

                    char buffer[1024];

                    while (file.read(buffer, sizeof(buffer))) {

                        boost::asio::write(socket, boost::asio::buffer(buffer, sizeof(buffer)));

                    }

                    if (file.gcount() > 0) {

                        boost::asio::write(socket, boost::asio::buffer(buffer, file.gcount()));

                    }

                } else {

                    std::cerr << "Can't open the specified file: " << upLoadFile << std::endl;

                   

                }

            } catch (std::exception& e) {

                std::cout << "Error sending file: " << e.what() << std::endl;

                return 1;

            }

            break;

        }

        case 2:

        {

            std::string input;

            std::cout << "Which file do you want to download" << std::endl;

            std::cin >> input;

            boost::asio::write(socket, boost::asio::buffer(input, sizeof(input)));

            boost::array<char, 1024> buffer;

            boost::system::error_code error;

            size_t length = socket.read_some(boost::asio::buffer(buffer), error);

            if (error == boost::asio::error::eof)

                break;

            else if (error)

                throw boost::system::system_error(error);

            std::string file(buffer.data(), length);

            std::cout << file << std::endl;

            break;

        }

        case 3:

        {

            std::cout << "Quitting the program" << std::endl;

            break;

        }

        default:

        {

            std::cout << "Default" << std::endl;

        }

    }

    return 0;

}

 

int client::currentState(tcp::socket &socket) {

    std::string curState;

    for(;;){

    std::cout << "What would you like to do? (Upload/Download/Quit)" << std::endl;

    std::cin >> curState;

    for (char &c : curState) {

        c = std::toupper(c);

    }

   

    if (curState == "UPLOAD") {

        boost::asio::write(socket, boost::asio::buffer("UPLOAD", 6));

        sendStuff("UPLOAD", 1, socket);

    } else if (curState == "DOWNLOAD") {

        boost::asio::write(socket, boost::asio::buffer("DOWNLOAD", 8));

        sendStuff("DOWNLOAD", 2, socket);

    } else if (curState == "QUIT") {

        boost::asio::write(socket, boost::asio::buffer("QUIT", 4));

        sendStuff("QUIT", 3, socket);

        exit(0);

    }

    }

    return 0;

}

 

int main(int argc, char* argv[]) {

    if (argc != 3) {

        std::cerr << "Usage: client <host> <port>\n";

        return 1;

    }

    try {

       

        client myClient(argv[1], atoi(argv[2]));

        myClient.execute();

    } catch (std::exception& e) {

        std::cout << "There was an error: " << e.what() << std::endl;

    }

    return 0;

}
