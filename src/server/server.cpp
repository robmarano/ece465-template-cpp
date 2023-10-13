#include <iostream>

#include <boost/asio.hpp>

#include <vector>

#include <boost/array.hpp>

using boost::asio::ip::tcp;

 

std::string printFile(boost::array<char, 1024> buf, int length)

{

   

    std::string file(buf.data(), length);

    return file;

}

 

int main(int argc, char* argv[]) {

    if (argc != 2) {

        std::cerr << "Usage: server <port>\n";

        return 1;

    }
 

  try

  {

    boost::asio::io_context io_context;

 

    tcp::acceptor acceptor(io_context, tcp::endpoint(tcp::v4(), 13));

    std::cout << "Server started" << std::endl;

    for (;;)

    {

     

      tcp::socket socket(io_context);

      acceptor.accept(socket);  

      std::cout << "connection accepted" << std::endl;

      boost::array<char, 1024> buffer;

      boost::system::error_code error;

     

      size_t length = socket.read_some(boost::asio::buffer(buffer), error);

     

      if(error == boost::asio::error::eof)

        break;

      else if(error)

        throw boost::system::system_error(error);

     

      std::string file(buffer.data(),length);

     

      boost::asio::write(socket, boost::asio::buffer(file), error);

      if (error) {

        std::cout << "Error writing data back to the client: " << error.message() << std::endl;

        break;

      }

    }

  }

  catch (std::exception& e)

  {

    std::cout << "There was an error" << std::endl;

    std::cerr << e.what() << std::endl;

  }

 

  return 0;

}
